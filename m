Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265468AbUABKJX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 05:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265473AbUABKJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 05:09:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50355 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265468AbUABKJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 05:09:19 -0500
Date: Fri, 2 Jan 2004 11:09:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Peter Osterlund <petero2@telia.com>, Andrew Morton <akpm@osdl.org>,
       packet-writing@suse.com, linux-kernel@vger.kernel.org
Subject: Re: ext2 on a CD-RW
Message-ID: <20040102100909.GG5523@suse.de>
References: <Pine.LNX.4.44.0401020022060.2407-100000@telia.com> <20040101162427.4c6c020b.akpm@osdl.org> <m2llorkuhn.fsf@telia.com> <1073034412.4429.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073034412.4429.1.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02 2004, Arjan van de Ven wrote:
> On Fri, 2004-01-02 at 02:30, Peter Osterlund wrote:
> 
> > The packet writing code has the restriction that a bio must not span a
> > packet boundary. (A packet is 32*2048 bytes.) If the page when mapped
> > to disk starts 2kb before a packet boundary, merge_bvec_fn therefore
> > returns 2048, which is less than len, which is 4096 if the whole page
> > is mapped, so the bio_add_page() call fails.
> 
> devicemapper has similar restrictions for raid0 format; in that case
> it's device-mappers job to split the page/bio. Just as it is UDF's task
> to do the same I suspect...

It has nothing to do with UDF, it's a driver problem (API breakage).

-- 
Jens Axboe

