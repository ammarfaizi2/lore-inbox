Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262684AbTCPQR5>; Sun, 16 Mar 2003 11:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262686AbTCPQR5>; Sun, 16 Mar 2003 11:17:57 -0500
Received: from tartarus.telenet-ops.be ([195.130.132.46]:45457 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S262684AbTCPQR4>; Sun, 16 Mar 2003 11:17:56 -0500
From: "Simon Thornton" <simon@thornton.info>
To: <linux-kernel@vger.kernel.org>
Cc: "'Justin T. Gibbs'" <gibbs@scsiguy.com>
Subject: AIC79xx driver on kernel 2.4.19
Date: Sun, 16 Mar 2003 17:29:13 +0100
Message-ID: <000401c2ebd9$2eb5eb60$0501a8c0@diginfx.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm prob. missing something really simple but I'm having probs with the
AIC79xx driver and an adaptec 29320R adapter.

Kernel:	2.4.19
aic drvr:	aic79xx-1.1.0-source.tar.gz
drvr src:	Adaptec web site
SCSI Adapter:	Adaptec 29320R
			Drives connected to U2W, UW and narrow connectors
			connected to 32-bit PCI socket

The device presents itself as two adapters, the narrow/UW one (A) and the
U2W (B). The BIOS is set to use the B adapter to boot from. When the kernel
boots it ignores the BIOS preferences for boot order and binds scsi0 to
adapter A and scsi1 to adapter B. This is a problem as the main drives are
on the U2W adapter and the drives on the other adapter are generally
removable; net result is that I have to manually choose the boot device at
startup.

Quetions:

1. Is there anyway to make the kernel driver bind the adapters in a diff
order, .e.g: U2W as primary, UW/narrow as secondary, as in the BIOS
settings?

2. When I connect a "Maxtor Atlas 10K II U320" I get repeated debug screens
and it refuses to boot from the drive


any ideas?


Thanks,

Simon


