Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310560AbSCMNFt>; Wed, 13 Mar 2002 08:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310564AbSCMNFj>; Wed, 13 Mar 2002 08:05:39 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:53260 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S310560AbSCMNFf>; Wed, 13 Mar 2002 08:05:35 -0500
Date: Wed, 13 Mar 2002 14:05:23 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: Martin Dalecki <dalecki@evision-ventures.com>
Subject: 2.5.6: ide driver broken in PIO mode 
Message-ID: <Pine.LNX.4.21.0203131339050.26768-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I first noticed the problem on my Amiga, but I can reproduce it on an ia32
machine, when I turn off dma with hdparm. After a while the driver stops
working with:

hda: lost interrupt

After rebooting e2fsck has some serious damage to repair, so the driver
even writes garbage back to disk before stopping.
I can reproduce the problem pretty easily (some disk activity like from a
kernel compile is already enough) and it happens on two completely
different systems, so it should be reproducable on other systems too.

bye, Roman

