Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261886AbTC0KEp>; Thu, 27 Mar 2003 05:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261891AbTC0KEp>; Thu, 27 Mar 2003 05:04:45 -0500
Received: from 80-26-6-149.uc.nombres.ttd.es ([80.26.6.149]:49166 "EHLO
	bonkers.sytes.net") by vger.kernel.org with ESMTP
	id <S261886AbTC0KEm>; Thu, 27 Mar 2003 05:04:42 -0500
Subject: Re: CRC errors decompressing kernel on boot
From: Pedro Soria Rodriguez <psoria@hispafuentes.com>
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
In-Reply-To: <1047567911.3419.17.camel@queen.pelusa.net>
References: <1047567911.3419.17.camel@queen.pelusa.net>
Content-Type: text/plain; charset=ISO-8859-15
Organization: HispaFuentes
Message-Id: <1048760140.6984.11.camel@queen.pelusa.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 27 Mar 2003 11:15:41 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ended up finding a solution to my problem myself, so I will post it
here for the record.
First, a summary of the problem I had with kernel 2.4.20-ac2 and
2.4.21-pre5-ac2 and Lilo 22.4:

On Thu, 2003-03-13 at 16:05, Pedro Soria Rodriguez wrote:
> I am getting a CRC error when the kernel is being decompressed after
> loading.  It is intermitent, but I can force it to occur on every boot
> if I type on the keyboard while the kernel is loaded (before being 
> decompressed). 
> It happens on a certain machine, 
> with USB keyboard, and not with a PS2 keyboard.
> It does not happen on other machines with USB or PS2 keyboards.

The problem turned out to be a combination of LILO and an apparently
buggy BIOS. 

I switched from using LILO to using GRUB as a boot loader, and the
problem went away.  I found that loading a kernel with SYSLINUX (from
CDROM), LoadLin (from DOS), PXE (over the net) all works fine.  It is
only when loading it with LILO when the CRC error appears.  I read
somewhere on the net that the problem may be related to a buggy BIOS in
the machine.   

The problem was the USB keyb + buggy BIOS + LILO + large kernel    
(apparently this does not happen on small kernels, as I read somewhere
else on the net).

cheers,

--
Pedro Soria-Rodríguez


