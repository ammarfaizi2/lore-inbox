Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbUJ0PVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbUJ0PVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUJ0PRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:17:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65200 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262465AbUJ0PPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:15:16 -0400
Message-ID: <417FBB6D.90401@pobox.com>
Date: Wed, 27 Oct 2004 11:14:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>, Jens Axboe <axboe@suse.de>
Subject: Re: news about IDE PIO HIGHMEM bug (was: Re: 2.6.9-mm1)
References: <58cb370e041027074676750027@mail.gmail.com>
In-Reply-To: <58cb370e041027074676750027@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> We have stuct page of the first page and a offset.
> We need to obtain struct page of the current page and map it.


Opening this question to a wider audience.

struct scatterlist gives us struct page*, and an offset+length pair. 
The struct page* is the _starting_ page of a potentially multi-page run 
of data.

The question:  how does one get struct page* for the second, and 
successive pages in a known-contiguous multi-page run, if one only knows 
the first page?

	Jeff


