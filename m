Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315201AbSEKWGS>; Sat, 11 May 2002 18:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315203AbSEKWGR>; Sat, 11 May 2002 18:06:17 -0400
Received: from host194.steeleye.com ([216.33.1.194]:18439 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S315201AbSEKWGR>; Sat, 11 May 2002 18:06:17 -0400
Message-Id: <200205112206.g4BM6Dp13365@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: mochel@osdl.org, davej@suse.de
cc: James.Bottomley@HansenPartnership.com, linux-kernel@vger.kernel.org
Subject: [PATCH] i386 arch subdivision into machine types for 2.5.15
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 May 2002 18:06:13 -0400
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This split is essentially the same as the one I did for 2.5.8 except that I've 
cleaned up setup_arch.h slightly (the other was, as I was told, "icky").  I 
didn't do any other alterations to setup.c because the projects list implies 
that Dave Jones and Patrick Mochel are going to be doing this, so I'll slide 
my changes in around this.

I've pulled visws.c out of i386/pci and put it in i386/visws.c, since it's 
really specific to visws and doing this also allows me to simplify the 
i386/pci/Makefile.

The other thing I haven't done (yet) is to document all the hooks and how they 
work; I'll try to do that shortly.

The 147k diff file (large because it has a lot of file moves) is at

http://www.hansenpartnership.com/voyager/files/arch-split-2.5.15.diff

There's also a bitkeeper repository with all this in at

http://linux-voyager.bkbits.net/arch-split-2.5

James Bottomley


