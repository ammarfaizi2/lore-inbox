Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbTGAKhZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 06:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTGAKhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 06:37:25 -0400
Received: from holomorphy.com ([66.224.33.161]:9902 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262008AbTGAKhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 06:37:21 -0400
Date: Tue, 1 Jul 2003 03:51:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.73-mm2
Message-ID: <20030701105134.GE26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030701003958.GB20413@holomorphy.com> <Pine.LNX.4.44.0307011137001.1161-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307011137001.1161-100000@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jun 2003, William Lee Irwin III wrote:
>> It was suggested during my last round of OOM killer fixes that one of
>> my patches, which just checked nr_free_buffer_pages() > 0, should also
>> consider userspace (i.e. reclaimable at will) memory free.

On Tue, Jul 01, 2003 at 11:46:34AM +0100, Hugh Dickins wrote:
> If you pursued it, wouldn't your patch also need to change
> nr_free_buffer_pages() to do what you think it does, count
> the free lowmem pages?  It, and nr_free_pagecache_pages(),
> and nr_free_zone_pages(), are horribly badly named.  They
> count present_pages-pages_high, they don't count free pages:
> okay for initialization estimates, useless for anything dynamic.
> Hugh
> p.s. any chance of some more imaginative Subject lines :-?

Well, I was mostly looking for getting handed back 0 when lowmem is
empty; I actually did realize they didn't give entirely accurate counts
of free lowmem pages.


-- wli
