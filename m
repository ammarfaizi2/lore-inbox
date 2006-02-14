Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422874AbWBNXsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422874AbWBNXsv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422875AbWBNXsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:48:50 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:20682 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422874AbWBNXst
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:48:49 -0500
Subject: Re: [RFC][PATCH] map multiple blocks at a time in mpage_readpages()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Daniel Phillips <phillips@google.com>
Cc: christoph <hch@lst.de>, akpm@osdl.org, mcao@us.ibm.com,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <43F2680E.7060306@google.com>
References: <1139939347.4762.18.camel@dyn9047017100.beaverton.ibm.com>
	 <43F2680E.7060306@google.com>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 15:49:56 -0800
Message-Id: <1139960996.4762.34.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-14 at 15:30 -0800, Daniel Phillips wrote:
> Badari Pulavarty wrote:
> > +		for (i = 0; ; i++) {
> > +			if (i == nblocks) {
> > +				*map_valid = 0;
> > +				break;
> > +			} else if (page_block == blocks_per_page)
> > +				break;
> > +			blocks[page_block] = map_bh->b_blocknr + i;
> > +			page_block++;
> > +			block_in_file++;
> > +		}
> 
> Hi Badari, a tiny nit:
> 
> 		for (i = 0; ; i++) {
> 			if (i == nblocks) {
> 				*map_valid = 0;
> 				break;
> 			}
> 			if (page_block == blocks_per_page)
> 				break;
> 			blocks[page_block] = map_bh->b_blocknr + i;
> 			page_block++;
> 			block_in_file++;
> 		}
> 


Fixed. Wow !! People really do read others patches. Just kidding :)

Thanks,
Badari

