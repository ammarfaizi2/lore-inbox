Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbTGAKav (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 06:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbTGAKau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 06:30:50 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:54559 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S261989AbTGAKat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 06:30:49 -0400
Date: Tue, 1 Jul 2003 11:46:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: 2.5.73-mm2
In-Reply-To: <20030701003958.GB20413@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0307011137001.1161-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jun 2003, William Lee Irwin III wrote:
> 
> It was suggested during my last round of OOM killer fixes that one of
> my patches, which just checked nr_free_buffer_pages() > 0, should also
> consider userspace (i.e. reclaimable at will) memory free.

If you pursued it, wouldn't your patch also need to change
nr_free_buffer_pages() to do what you think it does, count
the free lowmem pages?  It, and nr_free_pagecache_pages(),
and nr_free_zone_pages(), are horribly badly named.  They
count present_pages-pages_high, they don't count free pages:
okay for initialization estimates, useless for anything dynamic.

Hugh

p.s. any chance of some more imaginative Subject lines :-?

