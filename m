Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbULFIoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbULFIoN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 03:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbULFIoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 03:44:13 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:64980 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S261392AbULFIoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 03:44:04 -0500
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.5  (F2.73; T1.001; A1.64; B3.05; Q3.03)
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
References: <1102256916.29858.210104494@webmail.messagingengine.com>
   <41B36A5D.50901@verizon.net>
Subject: Re: Booting 2.6.10-rc3
In-Reply-To: <41B36A5D.50901@verizon.net>
To: "Jim Nelson" <james4765@verizon.net>
Date: Mon, 06 Dec 2004 00:44:02 -0800
From: "Anandraj" <anandrajm@fastmail.fm>
X-Sasl-Enc: cLz1dT/6pK5CcZ2lEoU6DQ 1102322642
Message-Id: <1102322642.18071.210148617@webmail.messagingengine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi , 

Now it works after makingsome changes in the grub.conf

all i did was, in the grub.conf changed the 

kernel /vmlinuz-2.6.10-rc3 ro root=LABLE=/ rhgb quiet

to 

kernel /vmlinuz-2.6.10-rc3

but, i have no idea , this works!
can anybody shed some light on this ?

TIA,
Anand



On Sun, 05 Dec 2004 15:06:53 -0500, "Jim Nelson" <james4765@verizon.net>
said:
> Anandraj wrote:
> > hi,
> > My linux box with 2.6.9 kernel patched with 2.6.10-rc3 patch doesnot
> > come up.
> > It shows the following while booting-
> > 
> > root(hd0,4)
> > Filesystem type is ext2fs , partition type 0x83
> > kernel /vmlinuz-2.6.10-rc3 ro root=LABLE=/ rhgb quiet
> 
> try root=LABEL=/.
> 
> If that does not work, try passing the root fs as something like:
> 
> root=/dev/hda3
> 
> or wherever your root filesystem is.
> 
> >     [Linux-bzImage, setup=0x1400,size=0x187b53]
> > initrd /initrd-2.6.10-rc3.img
> >     [Linux-initrd @ 0x1fcb1000,0x2eb22 bytes]
> > 
> > Uncompressing Linux... Ok, booting kernel
> > audit(1102189352.204:0):initialized
> > Red Hat nash version 3.5.22 starting 
> > mount: error 6 mounting ext3
> > pivotroot: pivo_root(/sysroot,/sysroot/initrd) failed : 2
> > umount /initrd/proc failed: 2
> > Kenel panic - not syncing: No init found. Try Passing init=option to
> > kernel.
> > 
> > 
> > I am using Fedora 2 distro!
> > The default kernel 2.6.5-1.358 that comes along with the distro works !
> > 
> > I had looked into various forums for "mount: error 6 mounting ext3",
> > none of the aswers given by them worked,
> > the answers like , making your ext3 module inbuilt ,also does not work !
> > 
> > Mine is a simple desktop PC with Pentium 4 512MB RAM, it does not deal
> > with any SCSI stuff!
> > Can somebody help me on this !! ??
> > 
> 
> If you did not build an initrd, you do not need reference to an initrd in
> the 
> grub.conf file.
> 
> > TIA,
> > Anand
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
