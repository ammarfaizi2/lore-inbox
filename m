Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVKCHb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVKCHb2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 02:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVKCHb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 02:31:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63806 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750733AbVKCHb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 02:31:27 -0500
Date: Thu, 3 Nov 2005 08:31:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BLOCK] Unify the seperate read/write io stat fields into arrays
Message-ID: <20051103073148.GT26049@suse.de>
References: <200511021704.jA2H4X4u027306@hera.kernel.org> <20051102183820.GA30291@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102183820.GA30291@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02 2005, Chris Wedgwood wrote:
> I wouldn't mind a comment with that:
> 
> >  struct disk_stats {
> > -	unsigned read_sectors, write_sectors;
> > -	unsigned reads, writes;
> > -	unsigned read_merges, write_merges;
> > -	unsigned read_ticks, write_ticks;
> 	/* Element 0 is for reads, 1 for writes */
> > +	unsigned sectors[2];
> > +	unsigned ios[2];
> > +	unsigned merges[2];
> > +	unsigned ticks[2];
> >  	unsigned io_ticks;
> >  	unsigned time_in_queue;
> >  };

Then send me such a comment patch :-)

-- 
Jens Axboe

