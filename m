Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267198AbUHDCHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267198AbUHDCHk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267193AbUHDCHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:07:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:48849 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267211AbUHDCHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:07:32 -0400
Date: Tue, 3 Aug 2004 19:07:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@redhat.com>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040803190730.A1924@build.pdx.osdl.net>
References: <20040803221121.GN2241@dualathlon.random> <Pine.LNX.4.44.0408032120570.5948-100000@dhcp83-102.boston.redhat.com> <20040804015350.GS2241@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040804015350.GS2241@dualathlon.random>; from andrea@suse.de on Wed, Aug 04, 2004 at 03:53:50AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrea Arcangeli (andrea@suse.de) wrote:
> On Tue, Aug 03, 2004 at 09:21:34PM -0400, Rik van Riel wrote:
> > This is exactly why named hugetlb files are NOT included
> > in this accounting, only the ones created through the SHM
> > interface are.
> 
> but you're allowing everybody to alloc all RAM in hugetlb files with
> the change in the previos patch posted by Arjan (you're currently posted
> incremental patches against Arjan's patch at the top of the thread I
> hope), so you must definitely apply "this" accounting to hugetlb files
> too or it's still insecure as far as I can tell.

I think it's no different from current behaviour.  Which for fs based
allocations is only guarded by fsuid and max_huge_pages.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
