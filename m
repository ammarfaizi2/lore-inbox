Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270138AbRHWTVp>; Thu, 23 Aug 2001 15:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270168AbRHWTVf>; Thu, 23 Aug 2001 15:21:35 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56073 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270138AbRHWTV0>; Thu, 23 Aug 2001 15:21:26 -0400
Subject: Re: Filling holes in ext2
To: adrian@humboldt.co.uk (Adrian Cox)
Date: Thu, 23 Aug 2001 20:23:42 +0100 (BST)
Cc: akpm@zip.com.au (Andrew Morton), linux-kernel@vger.kernel.org
In-Reply-To: <3B8556B6.7040700@humboldt.co.uk> from "Adrian Cox" at Aug 23, 2001 08:17:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15a04s-0004QE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is that the on-disk metadata now says that that disk block 
> is part of the file. So as the page is not up-to-date, the next read 
> operation will go to the disk and fetch that block of garbage into the 
> page cache.

So in actual fact the bug is the file system committing metadata too early
from prepare not commit

Alan
