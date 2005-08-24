Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVHXWCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVHXWCD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 18:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVHXWCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 18:02:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45292 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932301AbVHXWCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 18:02:00 -0400
Date: Wed, 24 Aug 2005 15:01:46 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>
Subject: Re: [UPDATED] Re: [PATCH 1/5] Add pagetable allocation notifiers
Message-ID: <20050824220146.GR7762@shell0.pdx.osdl.net>
References: <200508241841.j7OIf6q4001874@zach-dev.vmware.com> <20050824194816.GK7762@shell0.pdx.osdl.net> <430CE30F.7050408@vmware.com> <20050824211826.GO7762@shell0.pdx.osdl.net> <430CE9F2.4070605@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430CE9F2.4070605@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Done.  Looks like you want empty_zero_page write protected too.  That 
> seems like a fine idea to me unless something really wants to do atomic 
> 64-bit reads on it.

Thanks, I added this set (minus the 3/5, which I already have) to the
virt-2.6 tree.

> The -1 is quite useless when you're going to shift  >> 12 anyways to get 
> a frame number to index into mem_map, which is why they are not there.  
> Plus, it just seems scary if you got it wrong - let's say you had a not 
> present page - not that you could, but now you are freeing a misaligned 
> address in the _previous_ page.  I really don't like that -1 at all.  I 
> will clean it up, but it does certainly deserve another patch.

Heh, that's exactly what I was concerned with from the patch (being on
the wrong page).  Thanks for clearing up my confusion.


