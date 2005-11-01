Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVKAMpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVKAMpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 07:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVKAMpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 07:45:30 -0500
Received: from mail.enyo.de ([212.9.189.167]:8172 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1750779AbVKAMp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 07:45:29 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 3ware 9550SX problems - mke2fs incredibly slow writing last third of inode tables
References: <BEDEA151E8B1D6CEDD295442@[192.168.100.25]>
Date: Tue, 01 Nov 2005 13:45:19 +0100
In-Reply-To: <BEDEA151E8B1D6CEDD295442@[192.168.100.25]> (Alex Bligh's message
	of "Sun, 30 Oct 2005 21:10:56 +0000")
Message-ID: <87oe54cza8.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alex Bligh:

> All seems to go well until I try and do mke2fs. This appears to work,
> and tries to write the inode tables. However, at (about) 3400 inodes
> (of 11176), it slows to a crawl, writing one table every 10 seconds.
> strace shows it is still running, and no errors are being reported.
> However, it seems very sick.

In my experience, the 3ware SATA controllers which are not NCQ-capable
have very, very lousy write performance with some drives, unless you
enable the write cache (which is, of course, a bit dangerous without
UPS or battery backup on the controller).
