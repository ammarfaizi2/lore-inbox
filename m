Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbTCPR7n>; Sun, 16 Mar 2003 12:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262710AbTCPR7n>; Sun, 16 Mar 2003 12:59:43 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:7691 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S262708AbTCPR7m>; Sun, 16 Mar 2003 12:59:42 -0500
Date: Sun, 16 Mar 2003 11:10:07 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Simon Thornton <simon@thornton.info>, linux-kernel@vger.kernel.org
Subject: Re: AIC79xx driver on kernel 2.4.19
Message-ID: <2856520000.1047838207@aslan.scsiguy.com>
In-Reply-To: <000401c2ebd9$2eb5eb60$0501a8c0@diginfx.org>
References: <000401c2ebd9$2eb5eb60$0501a8c0@diginfx.org>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> I'm prob. missing something really simple but I'm having probs with the
> AIC79xx driver and an adaptec 29320R adapter.
> 
> Kernel:	2.4.19
> aic drvr:	aic79xx-1.1.0-source.tar.gz
> drvr src:	Adaptec web site

This is way out of date.  Try pulling sources, RPMs, Driver Update
Diskettes, etc from:

http://people.FreeBSD.org/~gibbs/linux/SRC/
http://people.FreeBSD.org/~gibbs/linux/RPM/aic79xx
http://people.FreeBSD.org/~gibbs/linux/DUD/aic79xx

> SCSI Adapter:	Adaptec 29320R
> 			Drives connected to U2W, UW and narrow connectors
> 			connected to 32-bit PCI socket
> 
> The device presents itself as two adapters, the narrow/UW one (A) and the
> U2W (B). The BIOS is set to use the B adapter to boot from.
>
> When the kernel
> boots it ignores the BIOS preferences for boot order and binds scsi0 to
> adapter A and scsi1 to adapter B. This is a problem as the main drives are
> on the U2W adapter and the drives on the other adapter are generally
> removable; net result is that I have to manually choose the boot device at
> startup.
> 
> Quetions:
> 
> 1. Is there anyway to make the kernel driver bind the adapters in a diff
> order, .e.g: U2W as primary, UW/narrow as secondary, as in the BIOS
> settings?

I will have to go find the serial eeprom spec again and see if the
primary boot channel is specified.  If it is, this is an easy feature
to add.  I already do something similar for the aic7xxx driver.

> 2. When I connect a "Maxtor Atlas 10K II U320" I get repeated debug screens
> and it refuses to boot from the drive

What firmware is on the Atlas 10K?  If it is not >= B440 (which is not
even the latest available) it will likely fail spectacularly.

--
Justin

