Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267087AbSKMBa2>; Tue, 12 Nov 2002 20:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267088AbSKMBa2>; Tue, 12 Nov 2002 20:30:28 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:48907 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267087AbSKMBa1>; Tue, 12 Nov 2002 20:30:27 -0500
Date: Wed, 13 Nov 2002 01:37:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matthias Urlichs <smurf@noris.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4: scsi and BLK_STATS
Message-ID: <20021113013717.A3008@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthias Urlichs <smurf@noris.de>, linux-kernel@vger.kernel.org
References: <20021112172821.GA14195@play.smurf.noris.de> <20021113001530.A323@infradead.org> <20021113023059.K18881@noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021113023059.K18881@noris.de>; from smurf@noris.de on Wed, Nov 13, 2002 at 02:30:59AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 02:30:59AM +0100, Matthias Urlichs wrote:
> That may be a matter of style, but I would strongly prefer these to be
> 
> #define req_new_io(_a,_b,_c) do {} while(0)
> #define req_merge_io(_a)     do {} while(0)
> #define req_finished_io(_a)  do {} while(0)
> 
> instead ...

In kernelspace inlines are usually preferred over macros, that's why
I wrote it that way.  I must adimt that I don't really care a lot
personally..

> anyway, please disregard my patch and add
> 
> #include <linux/genhd.h>
> 
> in scsi/scsi_lib.c.  :-/

It already gets genhd.h through blk.h -> blkdev.h.. :)

