Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263238AbRE2HpS>; Tue, 29 May 2001 03:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263235AbRE2Ho7>; Tue, 29 May 2001 03:44:59 -0400
Received: from [209.10.41.242] ([209.10.41.242]:23248 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263232AbRE2Hov>;
	Tue, 29 May 2001 03:44:51 -0400
Message-ID: <3B135166.E061B01F@idcomm.com>
Date: Tue, 29 May 2001 01:36:06 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.15-config.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: bzdisk broken in 2.4.5?
In-Reply-To: <3B12E8B4.238DCD11@idcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"D. Stimits" wrote:
> 
> I've tried on two separate machines to test out 2.4.5 through the "make
> bzdisk" boot floppy, and it fails on both (the compile succeeds, but
> boot never gets to LILO, it simply gives "400" and a repeating list of
> AX, BX, CX, and DX registers). Both are scsi aic7xxx, but use different
> controllers, and have scsi directly compiled in. One machine is based on
> RH 7.1 beta, the other on RH 7.1. Both are x86 SMP, with motherboard and
> all hardware being different. Using the same kernel through a
> "mkbootdisk" works, only "make bzdisk" fails. Can anyone here verify
> that "make bzdisk" will create a bootable floppy (I did try an entire
> box of different floppies) on 2.4.5+? Especially, can anyone verify this
> for SMP and/or purely scsi machines? If scsi, do you use aic7xxx?
> 
> D. Stimits, stimits@idcomm.com

I found some references to bzdisk breaking in 2.3.28, followed by a fix.
Checking /usr/src/linux/arch/i386/boot/bootsect.S, the fix has remained
and has not been lost. See:
http://web.gnu.walfield.org/mail-archive/linux-kernel/1999-November/1818.html

However, something else must have changed since then to cause the image
size to go over its maximum. Has bzdisk being abandoned (or at least
ignored)?

D. Stimits, stimits@idcomm.com
