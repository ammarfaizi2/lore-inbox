Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269932AbTGKMoq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 08:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269933AbTGKMoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 08:44:46 -0400
Received: from main.gmane.org ([80.91.224.249]:39651 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269932AbTGKMop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 08:44:45 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: "/proc/asound/dev" gone in 2.5.75
Date: Fri, 11 Jul 2003 14:59:10 +0200
Message-ID: <yw1xof016wyp.fsf@users.sourceforge.net>
References: <Pine.GSO.4.53.0307111450440.29900@pitsa.pld.ttu.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:yUAdxO0hR2o5rfgidXaHLZAaRtE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siim Vahtre <siim@pld.ttu.ee> writes:

> I just went from 2.5.70 to 2.5.75 and discovered that sound no longer
> works. After short period of investigation, I found that "/dev/snd" is
> pointing to "/proc/asound/dev" that now, for some unknown reason, is gone.
>
> 'dmesg' shows
>> ALSA device list:
>>  #0: Intel 82801BA-ICH2 at 0xe800, irq 9
>
> And '/proc/asound' seems  to be there, aswell.
>> siim@void:/proc/asound$ ls
>> I82801BAICH2@  card0/  cards  devices  oss/  pcm  timers  version
>
> But no 'dev' there. I am also missing those control0* stuff. Strange...
>
> Can anyone please tell me what I'm doing wrong?

The /proc/asound/dev directory has been removed.  Either switch to
devfs (IMHO a good thing), or run some script to create the proper
device files (it's in the ALSA distribution).

-- 
Måns Rullgård
mru@users.sf.net

