Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317578AbSGEVLR>; Fri, 5 Jul 2002 17:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317580AbSGEVLQ>; Fri, 5 Jul 2002 17:11:16 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:12929 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S317578AbSGEVLP>; Fri, 5 Jul 2002 17:11:15 -0400
Date: Fri, 5 Jul 2002 17:13:38 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Alan Cox <alan@www.linux.org.uk>
cc: Christer Weinigel <wingel@acolyte.hack.org>,
       <linux-kernel@vger.kernel.org>, David Hinds <dhinds@sonic.net>,
       Martin Mares <mj@ucw.cz>
Subject: Re: Cyrix IRQ routing is wrong?
In-Reply-To: <E17QZv9-00041u-00@www.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207051652390.8401-101000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1426500069-1025902719=:8401"
Content-ID: <Pine.LNX.4.44.0207051659160.8401@marabou.research.att.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1426500069-1025902719=:8401
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0207051659161.8401@marabou.research.att.com>

Hi, Alan!

On Fri, 5 Jul 2002, Alan Cox wrote:

> > So I have to switch that code around on most GX1 boards that I use or
> > I'll get a lot of messages about IRQ routing conflicts.
> 
> I've tested multiple boards too - what BIOS are yours ? 

I'm not Christer, but I'll reply :-)
These are some strings extracted from the BIOS for EM-350A:

Award Modular BIOS v4.51PG
EM-350A Ver.B 11-21-2000
11/21/2000-GXm-Cx5530-2A434L7JC-00

Attached is a tarball with /proc/interrupts, output of "lspci -vxxx" and 
dump_irq, all taken on EM-350A.

The brigde is 5530. i.e. the one that is documented in 
http://www.national.com/ds/CS/CS5530.pdf

I also checked http://www.national.com/ds/CS/CS5530A.pdf, and it also says 
that INTA is controlled by the bits 0:3 of the register 0x5c.

-- 
Regards,
Pavel Roskin

--8323328-1426500069-1025902719=:8401
Content-Type: APPLICATION/X-GZIP; NAME="em-350a.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0207051658391.8401@marabou.research.att.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="em-350a.tar.gz"

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
--8323328-1426500069-1025902719=:8401--
