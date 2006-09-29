Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161370AbWI2Sg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161370AbWI2Sg4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 14:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161381AbWI2Sg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 14:36:56 -0400
Received: from xenotime.net ([66.160.160.81]:35995 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161370AbWI2Sgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 14:36:55 -0400
Date: Fri, 29 Sep 2006 11:38:14 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Roger Gammans <roger@computer-surgery.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fs/bio.c - Hardcoded sector size ?
Message-Id: <20060929113814.db87b8d5.rdunlap@xenotime.net>
In-Reply-To: <20060928182238.GA4759@julia.computer-surgery.co.uk>
References: <20060928182238.GA4759@julia.computer-surgery.co.uk>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 19:22:38 +0100 Roger Gammans wrote:

> Hi
> 
> In bio_endio()  there is the follow line:- 
> 
> 	bio->bi_sector += (bytes_done >> 9);
> 
> and there is a similiar line assuming a 512byte sector in 
> __bio_add_page() .
> 
> Is this a bug as the the actual  block size  should be available
> from bio->bi_bdev->bd_block_size surely - or is some clever code
> where all block devices have to translate back to 512 byte sectors
> for bio s.

Does this answer it for you?

http://marc.theaimsgroup.com/?l=linux-kernel&m=115542872706154&w=2

---
~Randy
