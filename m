Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVEZVxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVEZVxd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 17:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVEZVxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 17:53:32 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:29610 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S261816AbVEZVxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 17:53:09 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
To: Bill Davidsen <davidsen@tmr.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       linux-kernel@vger.kernel.org, 7eggert@gmx.de
Reply-To: 7eggert@gmx.de
Date: Thu, 26 May 2005 23:53:05 +0200
References: <48cRq-7TH-5@gated-at.bofh.it> <48cRq-7TH-7@gated-at.bofh.it> <48cRq-7TH-3@gated-at.bofh.it> <48dDM-5I-1@gated-at.bofh.it> <48wdp-7lh-1@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DbQHp-0001LK-M2@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> wrote:
> Kyle Moffett wrote:
>> On May 25, 2005, at 18:46:55, Joerg Schilling wrote:
>>> "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>"

>>>> I just burned a CD on my IDE-burner using mmc_cdr with cdrtools-2.01
>>>> (the one without the hack) on a vanilla 2.6.11.10. I can even scan
>>>> both my SCSI and IDE devices using -dev=ATAPI, but not without -dev.
>>>
>>>
>>> The unability to give this kind of convenience to cdrecord users is  a
>>> result
>>> of the refusal of the Linux kernel crew to include the kernel internal
>>> device instance numbers in the ioctl structures I need to read.

It's just strange if you're able to see my SCSI devices only through
ATAPI.

>> There is a specific reason that the numbers are _kernel_internal_!!!   I
>> set up
>> my udev so that my green CD burner is /dev/green_burner, and my blue  CD
>> burner
>> is /dev/blue_burner.  Please tell me again why exactly I can't just
>> give the
>> option -dev=/dev/green_burner and have it use my green CD burner?
> 
> You do realize that you can?

It's "unintentional and not supported". Users are supposed to convert the
device name into scsi numbers (e.g. using lsscsi) in order to to enable
cdrecord to peek around until it finds that number instead of directly
opening the correct device.

>>> Note that the fields are there but the information is intentionally
>>> obscured
>>> for come of the calls just to make the life of cdrecord useers  harder
>>> :-(
>> 
>> The information is obscured because userspace shouldn't know or care
> 
> So having you see the information to set up your udev is a good use and
> having Joerg use them is bad?

Udev is supposed to handle physical to logical mappings. No other program
should need to care, except for lsscsi and similar programs.

>>>> (I'm running as user, and cdrecord has no need for suid bits.)
> 
> Which is fine if you have a system to dedicate to burning CDs. But on a
> loaded system Joerg is right, you get a better burn if you don't have
> the burnfree used.

If I need RT privileges, I'll need to suid untill the non-root RT support
is ready and I'll be glad that it's supported.

> Like any other minor defect it may or may not bite
> you, a lot of them will measurably reduce your CD capacity, which
> actually will bite you if you are trying to use every last byte.

AFAI read, burnfree isn't supposed to do anything unless a buffer underrun
occures. If that's true, I'd prefer a warning message to really destroying
my CD.

> There is an option if you would read the manpage. There are legitimate
> complaints, this doesn't seem to be one of them.

I had to write a wrapper, and wrappers tend to indicate bad programs.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
