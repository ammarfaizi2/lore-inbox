Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVLHTxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVLHTxm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 14:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVLHTxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 14:53:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53619 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932302AbVLHTxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 14:53:41 -0500
Date: Thu, 8 Dec 2005 20:54:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: set_page_dirty vs set_page_dirty_lock
Message-ID: <20051208195433.GY26185@suse.de>
References: <20051208190913.GA28482@mellanox.co.il> <Pine.LNX.4.61.0512081908530.11737@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512081908530.11737@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08 2005, Hugh Dickins wrote:
> It can be very inconvenient (I don't know what to do for drivers/scsi/sg.c
> than set_page_dirty and hope for the best, since it cannot wait for a lock
> where it needs to).  But I'm afraid you do have the very case where
> set_page_dirty_lock is appropriate.

See bio_set_pages_dirty() in fs/bio.c and the framework for handling
those (notably bio_dirty_fn()).

> Many would be pleased if we could manage without set_page_dirty_lock.

Indeed, would make life easier there as well..

-- 
Jens Axboe

