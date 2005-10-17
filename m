Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVJQI6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVJQI6K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 04:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVJQI6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 04:58:10 -0400
Received: from web33305.mail.mud.yahoo.com ([68.142.206.120]:22188 "HELO
	web33305.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932211AbVJQI6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 04:58:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QklnzJ7qAdKH0RgNc0I0MnXyv8isfYmHpwA/pSAgNpXhS84uVSdpZAnJgeE0aYhYNLDqB1pFQWQbJ074DyZcnFiUSeQkM3xUkPLV/y1qETemRXVRKdSjGgK2NuE6c2M6iY4W494N1P6iz7MfsVvyLxgTNeUCZUiJrJBnK/dZ8dk=  ;
Message-ID: <20051017085808.17660.qmail@web33305.mail.mud.yahoo.com>
Date: Mon, 17 Oct 2005 01:58:08 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: Re: A problem about DIRECT IO on ext3
To: li nux <lnxluv@yahoo.com>, Jens Axboe <axboe@suse.de>,
       Erik Mouw <erik@harddisk-recovery.com>
Cc: colin <colin@realtek.com.tw>, linux-kernel@vger.kernel.org
In-Reply-To: <20051017085226.47541.qmail@web33315.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- li nux <lnxluv@yahoo.com> wrote:

> 
> 
> --- Jens Axboe <axboe@suse.de> wrote:
> 
> > On Mon, Aug 29 2005, Erik Mouw wrote:
> > > There are four prerequisites for direct IO:
> > > - the file needs to be opened with O_DIRECT
> > > - the buffer needs to be page aligned (hint: use
> > getpagesize() instead
> > >   of assuming that a page is 4k
> > > - reads and writes need to happen *in* multiples
> > of the soft block size
> > > - reads and writes need to happen *at* multiples
> > of the soft block size
> > 
> > Actually, the buffer only needs to be hard block
> > size aligned, same goes
> > for the chunk size used for reads/writes.
> > 
> > -- 
> > Jens Axboe
> > 
On 2.4 the open call succeeds with O_DIRECT
but read returns -EINVAL for any block size (512,
 1024  ..16384)
 
 open("/tmp/midstress_idx10",
 O_RDWR|O_CREAT|O_DIRECT|O_LARGEFILE, 01001101270) =
 3
 read(3, 0xbfffdc40, 16384) = -1 EINVAL (Invalid
 argument)
 
 how to correct this problem ?
 


	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
