Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265837AbUBPTpi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 14:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265851AbUBPTpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 14:45:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:16092 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265837AbUBPTpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 14:45:34 -0500
Date: Mon, 16 Feb 2004 11:45:29 -0800 (PST)
From: Judith Lebzelter <judith@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: OSDL tiobench Sequential Reads improved with AS due to read-ahead
 changes
In-Reply-To: <3FF00FDA.8050703@cyberone.com.au>
Message-ID: <Pine.LNX.4.33.0402160924450.24135-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello;

I have compiled the results for tiobench with Anticipatory Scheduler for
before and after the addition of the readahead-revert-lazy-readahead patch
in the 2.6.1-mm4 kernel.   I have found our SCSI systems showed up to 50%
improvement in Sequential Reads on ext2.  (2-CPU/MegaRAID/RAID0/5disks and
4-CPU/AACRAID/RAID0/5disks).  Here are the plots:

http://developer.osdl.org/judith/tiobench/big_jump_SR_24CPU/sr.html

Oddly, random reads also show slight improvement:

http://developer.osdl.org/judith/tiobench/big_jump_SR_24CPU/rr.html

Our 2CPU/MegaRAID particularly has been underperforming in the past, but
now is much more comparable to 'deadline'.  Here are plots of the current
-mm and mailine kernels:

http://developer.osdl.org/judith/tiobench/2CPU_big_jump_SR/sr.html

Thanks;

Judith Lebzelter
OSDL



