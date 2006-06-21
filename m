Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWFUQHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWFUQHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWFUQHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:07:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36559 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750767AbWFUQHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:07:05 -0400
Subject: Re: [RFC] [PATCH 0/8] Inode diet v2
From: Arjan van de Ven <arjan@infradead.org>
To: bidulock@openss7.org
Cc: Theodore Tso <tytso@thunk.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060621084217.B7834@openss7.org>
References: <20060621125146.508341000@candygram.thunk.org>
	 <20060621084217.B7834@openss7.org>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 18:06:50 +0200
Message-Id: <1150906010.3057.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You need to save 48 bytes per inode to fit one more into a slab with
> a 32 byte L1 cache slot; 120 bytes per inode, 64 byte L1 cache slot.
> And that's just a generic inode_cache object.  Something that is really
> used, like ext3_inode_cache or nfs_inode_cache is going to take more
> doing.  Moving a field from the generic inode to the filesystem specific
> inode acheives nothing.

for the inode slab it would very much make sense to tell the slab
allocator to not do any kind of cacheline alignment at all, just because
of the wasted space...

