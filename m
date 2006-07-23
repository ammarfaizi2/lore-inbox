Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWGWFrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWGWFrK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 01:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWGWFrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 01:47:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11399 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750781AbWGWFrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 01:47:08 -0400
Message-ID: <44C30E33.2090402@redhat.com>
Date: Sun, 23 Jul 2006 01:50:43 -0400
From: Rik van Riel <riel@redhat.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: linux-mm <linux-mm@kvack.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: inactive-clean list
References: <1153167857.31891.78.camel@lappy>
In-Reply-To: <1153167857.31891.78.camel@lappy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> This patch implements the inactive_clean list spoken of during the VM summit.
> The LRU tail pages will be unmapped and ready to free, but not freeed.
> This gives reclaim an extra chance.

This patch makes it possible to implement Martin Schwidefsky's
hypervisor-based fast page reclaiming for architectures without
millicode - ie. Xen, UML and all other non-s390 architectures.

That could be a big help in heavily loaded virtualized environments.

The fact that it helps prevent the iSCSI memory deadlock is a
huge bonus too, of course :)

-- 
The answer is 42.  What is *your* question?
