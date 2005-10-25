Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbVJYJuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVJYJuS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 05:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVJYJuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 05:50:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3226 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932117AbVJYJuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 05:50:16 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.61.0510241938100.6142@goblin.wat.veritas.com> 
References: <Pine.LNX.4.61.0510241938100.6142@goblin.wat.veritas.com>  <1130168619.19518.43.camel@imp.csi.cam.ac.uk> <1130167005.19518.35.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com> <7872.1130167591@warthog.cambridge.redhat.com> <9792.1130171024@warthog.cambridge.redhat.com> 
To: Hugh Dickins <hugh@veritas.com>
Cc: David Howells <dhowells@redhat.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add notification of page becoming writable to VMA ops 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 25 Oct 2005 10:49:42 +0100
Message-ID: <8049.1130233782@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:

> No, you need to pay attention to Nick's PageReserved removal, and
> my pte lock stuff, throughout do_wp_page - there shouldn't be any
> references to PageReserved or page_table_lock there now (and you'll
> need to recheck the mapping/locking/unlocking/unmapping).  Sorry,
> I don't have the time to spare to do it myself right now.

I attempted to 
