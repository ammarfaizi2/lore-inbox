Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWFSPf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWFSPf2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964772AbWFSPf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:35:27 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46467 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964773AbWFSPf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:35:26 -0400
Date: Mon, 19 Jun 2006 08:35:09 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <npiggin@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>, Jens Axboe <axboe@suse.de>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [patch] rfc: fix splice mapping race?
In-Reply-To: <20060618094157.GD14452@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0606190826540.1184@schroedinger.engr.sgi.com>
References: <20060618094157.GD14452@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jun 2006, Nick Piggin wrote:

> In page migration, detect the missing mapping early and bail out if
> that is the case: the page is not going to get un-truncated, so
> retrying is just a waste of time.

Note that swap_page() has been removed in Andrew's tree.

We already check for the mapping being NULL before we get to 
swap_page by the way. See migrate_pages().

