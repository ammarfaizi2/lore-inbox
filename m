Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVBUWUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVBUWUV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 17:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVBUWUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 17:20:21 -0500
Received: from mta10.adelphia.net ([68.168.78.202]:16814 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S261854AbVBUWUN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 17:20:13 -0500
Message-ID: <421A5E28.1030409@nodivisions.com>
Date: Mon, 21 Feb 2005 17:18:16 -0500
From: Anthony DiSante <theant@nodivisions.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups
References: <421A3414.2020508@nodivisions.com> <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu>            <421A4375.9040108@nodivisions.com> <200502212054.j1LKs3xi032658@turing-police.cc.vt.edu>
In-Reply-To: <200502212054.j1LKs3xi032658@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> See the thread rooted here:
>  
> Date: Wed, 03 Nov 2004 07:51:39 -0500
> From: Gene Heskett <gene.heskett@verizon.net>
> Subject: is killing zombies possible w/o a reboot?
> Sender: linux-kernel-owner@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> Reply-to: gene.heskett@verizon.net
> Message-id: <200411030751.39578.gene.heskett@verizon.net>

OK, there are two different opinions expressed at various places in that 
thread: they are that automatically killing processes hung in D state would 
be either 1) difficult/nonideal, or 2) impossible.

If it's truly impossible, then that settles it.

But if it's just difficult/nonideal, then here are my thoughts.  Again 
referencing that thread, there are a bunch of comments saying "that's an NFS 
bug, fix the bug" and "that's a samba bug, fix the bug" and "that's a driver 
bug, fix the driver."

It's indisputable that there will always be driver bugs and faulty hardware. 
  Of course these should be fixed, but if it's possible for the kernel to 
gracefully deal with the bugs until they get fixed, then why shouldn't it do 
so?  I understand the goal of making the common (non-buggy) case fast, but 
in my experience (and I can't be the only one) buggy hardware/drivers are 
becoming more and more common, and with the computer industry getting 
ever-bigger and people doing ever-more with their computers, this trend will 
only continue (the more hardware on the market the more bugs there will be).

As I stated in my original post, on the 3 different systems I administer, I 
need to reboot ~weekly because of the permanent D state.  These 3 systems 
are completely different, and the processes that hang are different -- 
digital camera software/drivers, a CDROM, and a printer are among the 
sources that have recently caused the permanent D state.  Maybe the 
non-buggy case is the most common one, but the buggy case is certainly not 
UNcommon.  If it's possible to wipe out this whole class of problem with 
some (admittedly difficult) extra work in the kernel, then I don't see how 
that isn't preferable to guaranteeing that people will always need to reboot 
their linux systems when they get new hardware that puts processes into the 
D state permanently.

-Anthony DiSante
http://nodivisions.com/
