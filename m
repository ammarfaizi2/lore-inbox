Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261614AbSJ2HW1>; Tue, 29 Oct 2002 02:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261622AbSJ2HW1>; Tue, 29 Oct 2002 02:22:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22758 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261614AbSJ2HW1>;
	Tue, 29 Oct 2002 02:22:27 -0500
Date: Tue, 29 Oct 2002 08:28:40 +0100
From: Jens Axboe <axboe@suse.de>
To: Stephen Cameron <steve.cameron@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44-ac3, cciss, more scatter gather elements
Message-ID: <20021029072840.GM2937@suse.de>
References: <20021028171016.A903@zuul.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028171016.A903@zuul.cca.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28 2002, Stephen Cameron wrote:
> Jens Axboe wrote:
> [...]
> > It's not a kernel limit. If you queue limits are all beyond 64 entries,
> > what you typically see is that you just hit what mpage will fill in for
> > you. One thing that should give you max number of sg entries is plain
> > and simple:
> > 
> > 	dd if=/dev/zero of=some_file bs=4096k
> 
> What about 
> 
> 	dd if=/dev/cciss/c0d1p1 of=/dev/null bs=4096k

It's much better to do it with writes, you know the io scheduler will
stack those up in a long line, all max size. Reads are more difficult to
predict.

-- 
Jens Axboe

