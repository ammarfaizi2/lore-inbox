Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbUCTJQB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 04:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263261AbUCTJQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 04:16:01 -0500
Received: from shadow02.cubit.at ([80.78.231.91]:64716 "EHLO
	skeletor.netshadow.at") by vger.kernel.org with ESMTP
	id S263259AbUCTJP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 04:15:57 -0500
Message-ID: <010f01c40e5b$f6c00a50$02bfa8c0@kuecken>
From: "Andreas Unterkircher" <unki@netshadow.at>
To: <mtr@sepsit.org>, <linux-kernel@vger.kernel.org>
References: <2101.202.88.238.147.1079767903.squirrel@www.sepsit.org>
Subject: Re: kernel compilation
Date: Sat, 20 Mar 2004 10:16:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you havent build all the modules i think :)

this order as example if you wanna do it step by step

make xconfig
make clean
make dep
make
make modules
make bzImage
make modules_install

andi

----- Original Message ----- 
From: <mtr@sepsit.org>
To: <linux-kernel@vger.kernel.org>
Sent: Saturday, March 20, 2004 8:31 AM
Subject: kernel compilation


> hai
>
>  I am a new bie in the list. I have a doubt. It is about kernel
compilation.
> I use  linux-2.4.20-8 in redhat 9. In the default kernel after i giving
> the lsmod command it will list the following list
>
> Module                  Size  Used by    Not tainted
> sr_mod                 18136   0  (autoclean)
> i810_audio             27720   0  (autoclean)
> ac97_codec             13640   0  (autoclean) [i810_audio]
> soundcore               6404   2  (autoclean) [i810_audio]
> parport_pc             19076   1  (autoclean)
> lp                      8996   0  (autoclean)
> parport                37056   1  (autoclean) [parport_pc lp]
> autofs                 13268   0  (autoclean) (unused)
> microcode               4668   0  (autoclean)
> 8139too                18088   1
> mii                     3976   0  [8139too]
> ide-scsi               12208   0
> scsi_mod              107160   2  [sr_mod ide-scsi]
> ide-cd                 35708   0
> cdrom                  33728   0  [sr_mod ide-cd]
> keybdev                 2944   0  (unused)
> mousedev                5492   1
> hid                    22148   0  (unused)
> input                   5856   0  [keybdev mousedev hid]
> ehci-hcd               19976   0  (unused)
> usb-ohci               21480   0  (unused)
> usbcore                78784   1  [hid ehci-hcd usb-ohci]
> ext3                   70784   7
> jbd                    51892   7  [ext3]
>
> After compilation the new kernel is booting and i could not get the USB
> mouse and Xserver. At the prompt i give ls mode it will give only the
> following line.
> Module                  Size  Used by    Not tainted
>
> I compile the source in /usr/src/linux-2.4.20-8/ using the commands
>
> make xconfig
> make dep
> make clean
> make bzImage
>
> after this i move the bzImage to the boot directory and edit grub to boot
> the new kernel.
>
> How to load all modules in the default kernel into the new kernel.
> or How to make a kernel image that contain all the default modules and my
> new option given in make xconfig.
>
> Sorry for this long mail to this list and my not good english.
>
> If this is not a list to ask this type of questions please give the
> apropriate list name
>
> With regards
> Manoj
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

