Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVF2HpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVF2HpG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVF2Hnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:43:35 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:19105 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262472AbVF2Hmk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:42:40 -0400
References: <iit0gm.lxobpl.5z2b9jduhy9fvx6tjxrco46v4.refire@cs.helsinki.fi>
            <iit0h1.q7pnex.bkir3xysppdufw6d9h65boz37.refire@cs.helsinki.fi>
            <20050628163114.6594e1e1.akpm@osdl.org>
            <1120018821.9658.4.camel@localhost>
            <20050629070814.GC16850@infradead.org>
In-Reply-To: <20050629070814.GC16850@infradead.org>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: freevxfs: minor cleanups
Date: Wed, 29 Jun 2005 10:42:39 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42C250EF.00000B88@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 07:20:21AM +0300, Pekka Enberg wrote:
> > The rationale for this is that since NULL is not guaranteed to be zero
> > by the C standard, memset() doesn't really initialize pointers properly.

On Wed, 2005-06-29 at 08:08 +0100, Christoph Hellwig wrote:
> For all the machines we care it does. If a maintainer refuses to acccept
> that he or she is stupid.

I agree that pointer initialization is not really an issue but I do prefer 
the C99 struct initializers over an kcalloc(1, sizeof(*p)) call. 

Is this something you don't want for freevxfs or filesystems in general? 
Should it be removed from NTFS as well? 

			Pekka 
