Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSE0Adw>; Sun, 26 May 2002 20:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316471AbSE0Adv>; Sun, 26 May 2002 20:33:51 -0400
Received: from host194.steeleye.com ([216.33.1.194]:57611 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S316465AbSE0Adu>; Sun, 26 May 2002 20:33:50 -0400
Message-Id: <200205270033.g4R0Xfh02221@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: davej@suse.de, James.Bottomley@HansenPartnership.com
Subject: [PATCH] i386 arch subdivision into machine types for 2.5.18
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 26 May 2002 20:33:41 -0400
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
places it into a separate directory (sort of a simple example case).

This code is essentially just an up-port of the previously announced 2.5.15 
version.  In particular, I haven't added the extra documentation that I need 
to make the way the hooks work transparent to the interested user.  I'm 
currently marking time until Linus applies the Mochel setup/cpu split patches 
from the -dj tree and I can merge my code with it.

The 144k diff file is at:

http://www.hansenpartnership.com/voyager/files/arch-split-2.5.18.diff

There's also a bitkeeper repository with all this in at

http://linux-voyager.bkbits.net/arch-split-2.5

James Bottomley


