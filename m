Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269805AbRHINmT>; Thu, 9 Aug 2001 09:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269806AbRHINmJ>; Thu, 9 Aug 2001 09:42:09 -0400
Received: from adsl-63-198-217-24.dsl.snfc21.pacbell.net ([63.198.217.24]:3844
	"EHLO hp.masroudeau.com") by vger.kernel.org with ESMTP
	id <S269805AbRHINmA>; Thu, 9 Aug 2001 09:42:00 -0400
Date: Thu, 9 Aug 2001 06:38:41 -0700 (PDT)
From: Etienne Lorrain <etienne@masroudeau.com>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Gujin graphical bootloader 0.4
In-Reply-To: <20010809132604.C14108@emma1.>
Message-ID: <Pine.LNX.4.33.0108090551570.18005-100000@hp.masroudeau.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2001, Matthias Andree wrote:
> On Mon, 06 Aug 2001, Etienne Lorrain wrote:
> >   I released the 0.4 version of the GPL Gujin bootloader.
> >
> >  Its homepage (with screenshoots) is at:
> > http://gujin.sourceforge.net/
>
> Given that I need to use rdev: is there any way to tell gujin to pass
> parameters to the kernel? I use ide0=ata66 on my 2.2 kernels, and other
> options on some other machines.

  Right now, it is only possible at the installation of Gujin on the
 floppy or at the boot.exe generation, by using the "--cmdline=" option
 of "./instboot" - so it will append the parameters to all kernel booted.
 So you will need to recompile from the source.

 It is still not possible to have different options for different kernels.

  --> Have a look at "./instboot --help".
 The maximum size of this string is 64 bytes (compile time: see boot.h,
 struct gujin_param_str->extra_cmdline).

  The target is to have a setup screen where this field can be modified,
 but before a more generic menu system is needed, and also a way to
 select the keyboard language.

  Note that you need to use rdev only if you have your kernel on a scsi
 disk or in a "small" partition at the beginning of the disk.
  If the kernel is /boot/vmlinuz*, and /boot is not a mount point,
 the root partition is surely the /

 If /boot is a mount point, there is also the trick:
cp /boot/vmlinuz* /tmp
umount /boot
cp /tmp/vmlinuz* /boot
mount /boot
 So you can select the right file at next reboot.


> Do you plan to set up a gujin mailing list on sourceforge to pull
> discussions off here?

 I was thinking the forum would be enought, but if you want it,
 and considering sourceforge says it is better to create those three:

gujin-devel@lists.sourceforge.net
gujin-users@lists.sourceforge.net
gujin-announce@lists.sourceforge.net

 Sourceforge says:
It will take 6-24 Hours for your list to be created.

 See you there,
 Etienne.

