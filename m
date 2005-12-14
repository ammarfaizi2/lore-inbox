Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbVLNNbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbVLNNbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVLNNbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:31:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:205 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932514AbVLNNbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:31:11 -0500
Date: Wed, 14 Dec 2005 08:30:28 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Matthew Dobson <colpatch@us.ibm.com>
cc: linux-kernel@vger.kernel.org, andrea@suse.de,
       Sridhar Samudrala <sri@us.ibm.com>, pavel@suse.cz,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 1/6] Create Critical Page Pool
In-Reply-To: <439FCF4E.3090202@us.ibm.com>
Message-ID: <Pine.LNX.4.63.0512140829410.2723@cuia.boston.redhat.com>
References: <439FCECA.3060909@us.ibm.com> <439FCF4E.3090202@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.63.0512140829412.2723@cuia.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2005, Matthew Dobson wrote:

> Create the basic Critical Page Pool.  Any allocation specifying 
> __GFP_CRITICAL will, as a last resort before failing the allocation, try 
> to get a page from the critical pool.  For now, only singleton (order 0) 
> pages are supported.

How are you going to limit the number of GFP_CRITICAL
allocations to something smaller than the number of
pages in the pool ?

Unless you can do that, all guarantees are off...

-- 
All Rights Reversed
