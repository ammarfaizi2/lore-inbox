Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268008AbUHKJSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268008AbUHKJSu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 05:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268010AbUHKJSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 05:18:49 -0400
Received: from main.gmane.org ([80.91.224.249]:29128 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268008AbUHKJSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 05:18:48 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: Allow userspace do something special on overtemp
Date: Wed, 11 Aug 2004 11:18:49 +0200
Message-ID: <yw1x657q9gna.fsf@kth.se>
References: <20040811085326.GA11765@elf.ucw.cz> <1092215024.2816.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:fzxmTgs1lXWArnJgV/m9ziQwJDw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:

> On Wed, 2004-08-11 at 10:53, Pavel Machek wrote:
>> Hi!
>> 
>> This patch cleans up thermal.c a bit, and adds possibility to react to
>> critical overtemp: it tries to call /sbin/overtemp, and only if that
>> fails calls /sbin/poweroff.
>
> why not call /sbin/hotplug ????

Good idea, then udev could create /dev/blowtorch so some other program
can do ioctl(SCSI_STOP) (or just run cdrecord dev=6,6,6 -eject).
Besides, it is called HOTplug for a reason.

Seriously, though, isn't hotplug supposed to handle plugging and
unplugging of hardware, rather than any random events detected by the
kernel?

-- 
Måns Rullgård
mru@kth.se

