Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290375AbSAXV6M>; Thu, 24 Jan 2002 16:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290371AbSAXV57>; Thu, 24 Jan 2002 16:57:59 -0500
Received: from bigglesworth.mail.be.easynet.net ([212.100.160.67]:9235 "EHLO
	bigglesworth.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S290370AbSAXV4z>; Thu, 24 Jan 2002 16:56:55 -0500
Message-ID: <3C5082E3.C3A61B27@easynet.be>
Date: Thu, 24 Jan 2002 22:55:47 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Strange asm warning from bsetupt.s in 2.5.3-pre5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just finished to compile 2.5.3-pre5 and I noticed
the following  strange warning from as(1):
	as -o bsetup.o bsetup.s
	bsetup.s: Assembler messages:
	bsetup.s:1180: Warning: Value 0x37ffffff truncated to 0x37ffffff.
					  ~~~~~~		  ~~~~~~

It's comming from the small change introduced in setup.S:
	ramdisk_max:  .long __MAXMEM-1        # (Header version 0x0203 or later)


FYI as(1) version is:
	as --version
	GNU assembler 2.11.90.0.19

Cheers
-- 
Luc Van Oostenryck
