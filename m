Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSHASov>; Thu, 1 Aug 2002 14:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316855AbSHASov>; Thu, 1 Aug 2002 14:44:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15884 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316853AbSHASou>;
	Thu, 1 Aug 2002 14:44:50 -0400
Message-ID: <3D498495.6F8E4DDA@zip.com.au>
Date: Thu, 01 Aug 2002 11:57:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Steven Cole <scole@lanl.gov>
Subject: Re: Linux v2.4.19-rc5
References: <3D48F915.3FADA08F@zip.com.au> <1028213120.3085.88.camel@spc9.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> 
> ...
> I've never seen this on 2.4.19-rc3 and I've been beating on it pretty
> hard, running dbench 128 many times.  However, 2.5 is another story.
> 
> This might not be the best thread to report this, but since the subject
> came up, I'm getting the following message with recent 2.5.x kernels
> whenever I run relatively large numbers of dbench clients.
> 
> Buffer I/O error on device sd(8,8), logical block XXXXXXX
> 
> where logical block repeats 0-6 times.  This behavior is repeatable, but
> only occurs under fairly high load.  I ran dbench with increasing numbers
> of clients, with the following results:
> 
> dbench clients  Buffer I/O error messages
> >=48            0
> 52              1
> 56              0
> 64              0
> 80              11
> 96              9
> 112             7
> 128             4

Yup.  The printk is bogus - I thought I'd removed it a couple of
kernels ago.

It's a bit sad that an abandoned readahead attempt is indistinguishable
from a dead disk.

-
