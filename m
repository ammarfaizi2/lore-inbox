Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261718AbTCGS4S>; Fri, 7 Mar 2003 13:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261705AbTCGS4S>; Fri, 7 Mar 2003 13:56:18 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:9477 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261718AbTCGS4R>; Fri, 7 Mar 2003 13:56:17 -0500
Date: Fri, 7 Mar 2003 19:06:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030307190648.A13594@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <UTC200303071849.h27Ineg11598.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200303071849.h27Ineg11598.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Mar 07, 2003 at 07:49:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 07:49:40PM +0100, Andries.Brouwer@cwi.nl wrote:
> The following patch does the following:
> 
> - static const char *blkdevs[MAX_BLKDEV]; disappears
> - get_blkdev_list, (un)register_blkdev, __bdevname
>   are moved from block_dev.c to genhd.c
> - the third "fops" parameter of register_blkdev was unused;
>   now removed everywhere
> - zillions of places had printk("cannot get major") upon
>   error return from register_blkdev; removed all of these
>   and inserted a single printk in register_blkdev.

IMHO that's a bad change, (un)register_blkdev should just go away
completly.

