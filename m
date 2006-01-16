Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWAPHBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWAPHBH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 02:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWAPHBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 02:01:07 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:3032 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932184AbWAPHBG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 02:01:06 -0500
Date: Mon, 16 Jan 2006 09:00:56 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: [patch 04/10] slab: cache_estimate cleanup
In-Reply-To: <20060115183822.38b1e807.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0601160854530.12291@sbz-30.cs.Helsinki.FI>
References: <20060114122249.246354000@localhost> <20060114122415.163755000@localhost>
 <20060115183822.38b1e807.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pekka Enberg" <penberg@cs.helsinki.fi> wrote:
> > -	size_t wastage = PAGE_SIZE << gfporder;
> > -	size_t extra = 0;
> > -	size_t base = 0;
> > ...
> > +	size_t mgmt_size;
> > +	size_t slab_size = PAGE_SIZE << gfporder;

On Sun, 15 Jan 2006, Andrew Morton wrote:
> Can anyone think of a reason for using size_t in there instead of plain old
> unsigned int?

Not really but unsigned long would probably be safer.

			Pekka
