Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbUK1S3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbUK1S3X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbUK1S3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:29:15 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:6290 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261553AbUK1S2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:28:46 -0500
Subject: Re: mmap and multiple memory chucks allocated by kmalloc()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: lan mu <mu8lan2003@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041127000414.74351.qmail@web50506.mail.yahoo.com>
References: <20041127000414.74351.qmail@web50506.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101662725.16761.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 28 Nov 2004 17:25:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-11-27 at 00:04, lan mu wrote:
> Can I use the kmalloc to allocate 5 memory chucks
> (4096*30) and then use remap_page_range() to map those
> 5 chucks one by one? it not seems to work. Anyone can
> tell me if it's feasible? or I have to use vmalloc?

If they don't need to be linear you can allocate individual pages and
use a do_no_page function. See the sound/oss/via82cxxx driver

