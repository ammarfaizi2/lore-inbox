Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265248AbUETRgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUETRgy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 13:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUETRgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 13:36:54 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:29327 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265248AbUETRgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 13:36:53 -0400
Date: Thu, 20 May 2004 18:36:43 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Ian Molton <spyro@f2s.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: struct page changes in 2.6.6
In-Reply-To: <20040520182152.45fb2ce7.spyro@f2s.com>
Message-ID: <Pine.LNX.4.44.0405201828110.9431-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2004, Ian Molton wrote:
> 
> Im trying to find the reason struct page lost its 'list' field - arm26 depended on it right up to 2.6.5.

Search for the word "soap" in ChangeLog-2.6.6
and you'll find a very long and informative essay by akpm.

arch/arm26/machine/small_page.c has been converted to use page->lru
instead in 2.6.6, is that not working for you?  Or is there somewhere
else that needs changing?

I notice the comment in small_page.c says you're using
page->next_hash and pprev_hash - they went away long ago!

Hugh

