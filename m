Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262587AbTCMWJT>; Thu, 13 Mar 2003 17:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262594AbTCMWJS>; Thu, 13 Mar 2003 17:09:18 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:37580 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S262587AbTCMWJR>; Thu, 13 Mar 2003 17:09:17 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: VESA FBconsole driver?
Date: 13 Mar 2003 23:24:35 +0100
Organization: SuSE Labs, Berlin
Message-ID: <87adfy7vmk.fsf@bytesex.org>
References: <20030312110748.A9773@devserv.devel.redhat.com> <3E708815.23768.38089C@localhost>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1047594276 1067 127.0.0.1 (13 Mar 2003 22:24:36 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kendall Bennett" <KendallB@scitechsoft.com> writes:

> No-one has responded to this email, so either no-one remembers this is 
> people think someone else responded to my email ;-)

I remember, but havn't heard anything for a long time and don't know
the current status.

> at references that will help me figure out how the kernel can make 
> callbacks into a user land daemon?

Look how /sbin/{hotplug|modprobe} is called if needed.

> Is there any reason why the vm86() services in the Linux kernel
> cannot be used by other kernel code?

Unlikely.  To ugly to live with (says Linus, and lot of people agree),
and not really needed.  Doing it in userspace also has the advantage
that you can play alot more tricks.  XFree86 for example has a x86
emulator to execute vga bios code on !x86 platforms.  _That_ you
really don't want to do in kernel mode ...

  Gerd

-- 
/join #zonenkinder
