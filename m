Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVJQIwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVJQIwa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 04:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVJQIw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 04:52:29 -0400
Received: from web33315.mail.mud.yahoo.com ([68.142.206.130]:62340 "HELO
	web33315.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932216AbVJQIw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 04:52:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=IHgjicyE4m3ZUN3dRSquLsaxzY+ZHprGJkFW10RwpJNrpKphPbuJsKQiKEJe4Aphk3RdMmj2yNMkyCzCKPV7y/QeVJsiD6iUKU08fDZfz5+5PHEjRFP1TffGIa5P+HZfDr+v897dSJ1P2ugCffBSzP6wMvoOlZX9VGYWffT8pSE=  ;
Message-ID: <20051017085226.47541.qmail@web33315.mail.mud.yahoo.com>
Date: Mon, 17 Oct 2005 01:52:25 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: Re: A problem about DIRECT IO on ext3
To: Jens Axboe <axboe@suse.de>, Erik Mouw <erik@harddisk-recovery.com>
Cc: colin <colin@realtek.com.tw>, linux-kernel@vger.kernel.org
In-Reply-To: <20050831080744.GM4018@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Jens Axboe <axboe@suse.de> wrote:

> On Mon, Aug 29 2005, Erik Mouw wrote:
> > There are four prerequisites for direct IO:
> > - the file needs to be opened with O_DIRECT
> > - the buffer needs to be page aligned (hint: use
> getpagesize() instead
> >   of assuming that a page is 4k
> > - reads and writes need to happen *in* multiples
> of the soft block size
> > - reads and writes need to happen *at* multiples
> of the soft block size
> 
> Actually, the buffer only needs to be hard block
> size aligned, same goes
> for the chunk size used for reads/writes.
> 
> -- 
> Jens Axboe
> 
On 2.4 the open call succeeds with O_DIRECT
but read returns -EINVAL for any block size (512, 1024
..16384)

open("/tmp/midstress_idx10",
O_RDWR|O_CREAT|O_DIRECT|O_LARGEFILE, 01001101270) = 4
read(3, 0xbfffdc40, 16384) = -1 EINVAL (Invalid
argument)

how to correct this problem ?



		
__________________________________ 
Start your day with Yahoo! - Make it your home page! 
http://www.yahoo.com/r/hs
