Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVKWQfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVKWQfs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVKWQfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:35:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37810 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751253AbVKWQfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:35:47 -0500
Date: Wed, 23 Nov 2005 08:35:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <christoph@lameter.com>
cc: Andrew Morton <akpm@osdl.org>, Rohit Seth <rohit.seth@intel.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
 conditions
In-Reply-To: <Pine.LNX.4.62.0511222238530.2084@graphe.net>
Message-ID: <Pine.LNX.4.64.0511230834160.13959@g5.osdl.org>
References: <20051122161000.A22430@unix-os.sc.intel.com>
 <20051122213612.4adef5d0.akpm@osdl.org> <Pine.LNX.4.62.0511222238530.2084@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Nov 2005, Christoph Lameter wrote:

> On Tue, 22 Nov 2005, Andrew Morton wrote:
> 
> > +extern int drain_local_pages(void);
> 
> drain_cpu_pcps?

Please no.

If there is something I _hate_ it's bad naming. And "pcps" is a totally 
unintelligible name.

Write it out. If a function is so trivial that you can't be bothered to 
write out what the name means, that function shouldn't exist at all. 
Conversely, if it's worth doing, it's worth writing out a name.

		Linus
