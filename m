Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbUJ0SpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbUJ0SpC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUJ0Som
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:44:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46798 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262618AbUJ0SeF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:34:05 -0400
Message-ID: <417FEA09.6080502@pobox.com>
Date: Wed, 27 Oct 2004 14:33:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>, Jens Axboe <axboe@suse.de>
Subject: Re: news about IDE PIO HIGHMEM bug
References: <58cb370e041027074676750027@mail.gmail.com> <417FBB6D.90401@pobox.com> <1246230000.1098892359@[10.10.2.4]> <1246750000.1098892883@[10.10.2.4]> <20041027180816.GA32436@infradead.org>
In-Reply-To: <20041027180816.GA32436@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
>>To repeat what I said in IRC ... ;-)
>>
>>Actually, you could check this with the pfns being the same when >> MAX_ORDER-1.
>>We should be aligned on a MAX_ORDER boundary, I think.
>>
>>However, pfn_to_page(page_to_pfn(page) + 1) might be safer. If rather slower.
> 
> 
> I think this is the wrong level of interface exposed.  Just add two hepler
> kmap_atomic_sg/kunmap_atomic_sg that gurantee to map/unmap a sg list entry,
> even if it's bigger than a page.

Why bother mapping anything larger than a page, when none of the users 
need it?

	Jeff



P.S. In your scheme you would need four helpers; you forgot kmap_sg() 
and kunmap_sg().
