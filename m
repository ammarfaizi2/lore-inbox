Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265574AbUFONxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265574AbUFONxp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 09:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265590AbUFONxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 09:53:44 -0400
Received: from aun.it.uu.se ([130.238.12.36]:16771 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265726AbUFONxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 09:53:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16590.65369.579162.568380@alkaid.it.uu.se>
Date: Tue, 15 Jun 2004 15:53:29 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Matthew Denner <matt@denner.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 45 minute boot time with 2.6.4/2.6.6-mm5 kernel on 1.7GHz laptop
In-Reply-To: <40CEFC9E.2030508@denner.demon.co.uk>
References: <40CEFC9E.2030508@denner.demon.co.uk>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Denner writes:
 > On Saturday I installed SuSE 9.1 Personal on my laptop and I'm beginning 
 > to wonder whether this was a bad idea.  It takes my laptop (a Pentium-M 
 > Centrino 1.7Ghz with 1GB DDR RAM and 40GB HDD) 45 minutes to boot (from 
 > selecting "linux" in GRUB to having the KDE interface up and running). 
 > It spends about 20-25 minutes in the boot procedure before it even gets 
 > to starting X.  Yesterday I managed to tidy my front room, put some 

Sounds a lot like a BIOS MTRR problem we've seen before, where
the BIOS fails to make the top-most part of physical RAM cacheable.

Send the contents of /proc/mtrr and the head of dmesg (the part
that shows the physical memory map) to LKML.
