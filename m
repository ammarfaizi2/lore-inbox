Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSFQGhh>; Mon, 17 Jun 2002 02:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316770AbSFQGhg>; Mon, 17 Jun 2002 02:37:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64738 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316768AbSFQGhf>;
	Mon, 17 Jun 2002 02:37:35 -0400
Date: Mon, 17 Jun 2002 08:37:28 +0200
From: Jens Axboe <axboe@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Message-ID: <20020617063728.GQ1359@suse.de>
References: <200206152024.NAA02772@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200206152024.NAA02772@adam.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15 2002, Adam J. Richter wrote:
> >>         Can't I make a macro to do a table lookup from bio->bi_max?
> 
> >Not really.  If I do
> 
> >	bio_alloc(GFP_KERNEL, 27);
> 
> >then I'll get a 32-slot bvec.  But presumably, I don't
> >want to put more than 27 pages into it.
> 
> 	If you called bio_alloc with a smaller number, that would
> just be the result of a small IO that you knew could not generate
> more iovecs than that.  So, that scenario will not happen.

But the macro lookup would fail for bios not coming from bio_alloc()

-- 
Jens Axboe

