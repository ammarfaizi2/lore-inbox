Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264668AbSJ3Rki>; Wed, 30 Oct 2002 12:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264750AbSJ3Rkh>; Wed, 30 Oct 2002 12:40:37 -0500
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:33676 "EHLO
	rrzs2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S264668AbSJ3Rkf>; Wed, 30 Oct 2002 12:40:35 -0500
Date: Wed, 30 Oct 2002 18:46:55 +0100
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
To: Orion Poplawski <orion@colorado-research.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Running linux-2.4.20-rc1 on Dell Dimension 4550
Message-ID: <20021030184655.C30480@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tuesday 29 October 2002 11:42 pm, Mitch Adair wrote:
>> > Thought I'd post some information about what I'm seeing running RH7.3
>> > with kernel 2.4.20-rc1 on a brand new Dell Dimension 4550.  Currently
>> > there are two problems with the machine:
>> >
>> > - When I swtich to a text console and back to the X screen, the machine
>> > locks up (or at least the console does not respond anymore).
>> 
>> you don't say the kernel, X, or hardware, but I've seen that personally
>> with radeon 7500... that what you have?
> 
> Kernel is 2.4.20-rc1, X is 4.2.0-8 from RH.  The X log reports:
> 
> (--) Chipset ATI Rage 128 Pro ULTRA TF (AGP) found
> 
> Warnings/errors are:
> 
> (WW) R128(0): Can't determine panel dimensions, and none specified.
>       Disabling programming of FP registers.
> 
> (EE) R128(0): No DFP detected
> 
> The Dell packing list reports: 32MB ATI RAGE ULTRA 4X AGP.
> 
> Probably should take this off linux-kernel....

Hi,

its definitly an X problem.
i ran into similar probs with radeons and rage128s... and seemed to be the 
same with different kernels.
Debian unstable contains a fix for that behaviour, but I don't know about RH 
7.x and 8.x:

A temporary fix would be disabling drm.

....
Debian changelog:

xfree86 (4.2.1-2) unstable; urgency=low

   * patch #000_post421: resynced with xf-4_2-branch as of 2002-10-06
     + Xdm patches: realloc usage, zero malloc()ated memory, enable
       /dev/urandom on NetBSD 1.4 and later (#5345, Mike A. Harris, #5401,
       Matthias Scheler) (Matthieu Herrb)
     + Fix crash in the TextWidget reported by Hans Wilmer. The bug is fixed in
       the TextAction.c patch (actually it was fixed in head, but I forgot to
       update the 4.2 branch, that is what most people are using).  Also synced
       some other bug fixes only in CVS head.  (Paulo Cesar Pereira de Andrade)

   * patch #002: resynced with xf-4_2-branch updates
   * patch #024: new; fix for hangs upon VT switch back to XFree86 on Rage128
     and Radeon cards due to failure to set and reset PCI busmastering properly
     (thanks, Michel Dänzer) (Closes: #163359)

...

Christian
