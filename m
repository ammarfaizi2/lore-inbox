Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267884AbTBYOVl>; Tue, 25 Feb 2003 09:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267941AbTBYOVk>; Tue, 25 Feb 2003 09:21:40 -0500
Received: from CPE0080c6e90c22-CM014280010574.cpe.net.cable.rogers.com ([24.43.161.4]:264
	"EHLO stargate.coplanar.net") by vger.kernel.org with ESMTP
	id <S267884AbTBYOVf>; Tue, 25 Feb 2003 09:21:35 -0500
Message-ID: <002f01c2dcda$ff505070$7c07a8c0@kennet.coplanar.net>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: "Ville Herva" <vherva@niksula.hut.fi>, <linux-kernel@vger.kernel.org>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se> <20030225092520.A9257@flint.arm.linux.org.uk> <20030225110704.GD159052@niksula.cs.hut.fi> <20030225113557.C9257@flint.arm.linux.org.uk> <20030225120357.GC158866@niksula.cs.hut.fi>
Subject: Re: zImage now holds vmlinux, System.map and config in sections. (fwd)
Date: Tue, 25 Feb 2003 09:34:05 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From a pure technical point of view, it seems just like bloat.  But from a
distribution, maintenance, etc point of view, it's a godsend.  It's a config
option, just like devfs and initrd, so just don't use it if you don't want
to.

One suggestion, make the config option have 2 choices to include it, one
which sets the ELF attribute to load it, the other which just puts it in the
file but doesn't load it.

Also, does it make sense to strip the kernel, reformat the symbols into
System.map, then put them back into the image?

Regards,

Jeremy

----- Original Message -----
From: "Ville Herva" <vherva@niksula.hut.fi>
To: "Mikael Starvik" <mikael.starvik@axis.com>; "'Randy.Dunlap'"
<rddunlap@osdl.org>; <linux-kernel@vger.kernel.org>;
<tinglett@vnet.ibm.com>; <torvalds@transmeta.com>
Sent: Tuesday, February 25, 2003 7:03 AM
Subject: Re: zImage now holds vmlinux, System.map and config in sections.
(fwd)


> I do appreciate that you find no use for this feature. You instructions
will
> work fine if one always compiles the kernel using the same discipline and
> and stores them under /boot on the same computer.
>
> Not everybody are always that careful. I know I'm not. I've copied tens of
> kernels to floppy ("cp bzImage /dev/fd0" because it's so easy to do), and
> lost track which one is which. I've copied kernels to other computers, and
> lost track which is which. I've made mistakes copying kernels to /boot,
and
> lost track which is which.
>
> I have been using Peter Breuer's proconfig patch and I have found it
useful.
> Just cat /proc/config, and there you have the config for the running
kernel
> - no matter if it was booted from a throw-away floppy, network or /boot.
> It only adds couple of kB to the bzImage, and I am ready to pay that
price.
>
> If you are not - well it is a config option for that very reason.

