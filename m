Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265239AbTLIJ0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266160AbTLIJ0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:26:11 -0500
Received: from main.gmane.org ([80.91.224.249]:4569 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265239AbTLIJ0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:26:06 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Date: Tue, 09 Dec 2003 10:26:03 +0100
Message-ID: <yw1xhe0aibpw.fsf@kth.se>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com>
 <3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com>
 <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
 <20031209075619.GA1698@kroah.com> <1070960433.869.77.camel@nomade>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:J9K3U/ezv7yyjpTqPAArFdTgyXU=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel <xavier.bestel@free.fr> writes:

>>   A:  That is correct.  If you really require this functionality, then
>>       use devfs.  There is no way that udev can support this, and it
>>       never will.
>
> That's something I don't understand: I thought that with a well
> configured hotplug+udev system, you'll never have to worry about loading
> drivers on device-node open() because all drivers should be auto-loaded
> and all device-nodes should be auto-created.
>
> Am I wrong ?

Let me give an example.  Hotplug will automatically load the ALSA
drivers for my sound card, and /dev/snd/* are created (by devfs or
udev, it doesn't matter for now).  Suppose that, some time, I run a
program that tries to use OSS for sound.  Now, the ALSA OSS emulation
is not loaded by hotplug, and I don't want it to.  It's nice to have
snd-pcm-oss automatically loaded when some legacy application tries to
use /dev/dsp.

-- 
Måns Rullgård
mru@kth.se

