Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSFVPxn>; Sat, 22 Jun 2002 11:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316106AbSFVPxm>; Sat, 22 Jun 2002 11:53:42 -0400
Received: from host194.steeleye.com ([216.33.1.194]:60433 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S314459AbSFVPxm>; Sat, 22 Jun 2002 11:53:42 -0400
Message-Id: <200206221553.g5MFrZF03680@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Cc: davej@suse.de, James.Bottomley@HansenPartnership.com
Subject: [PATCH 2.5.24] i386 arch subdivision into machine types
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 22 Jun 2002 11:53:35 -0400
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This code rearranges the arch/i386 directory structure to allow for sliding 
additional non-pc hardware in here in an easily separable (and thus easily 
maintainable) fashion.  The idea is that all the code for the particular 
problem hardware should be able to go in a separate directory with only 
additional build options in config.in.

The current patch really only pulls out the visws code from the core and 
places it into a separate directory (sort of a simple example case).  It also 
creates a generic directory (for standard x86 PCs) with all of the hooks 
documented.

The current patch moves mpparse.c back into arch/i386/kernel with it's own 
subordinate config option and upports to 2.5.24.

http://www.hansenpartnership.com/voyager/files/arch-split-2.5.24.diff

There's also a bitkeeper repository with all this in at

http://linux-voyager.bkbits.net/arch-split-2.5

James Bottomley


