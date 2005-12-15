Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbVLOEx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbVLOEx4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 23:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161051AbVLOEx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 23:53:56 -0500
Received: from mgate03.necel.com ([203.180.232.83]:29353 "EHLO
	mgate03.necel.com") by vger.kernel.org with ESMTP id S1161050AbVLOExz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 23:53:55 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: Jakub Jelinek <jakub@redhat.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, dhowells@redhat.com,
       torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	<20051212161944.3185a3f9.akpm@osdl.org>
	<20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de>
	<20051213004257.0f87d814.akpm@osdl.org>
	<20051213084926.GN23384@wotan.suse.de>
	<20051213090429.GC27857@infradead.org>
	<20051213101141.GI31785@devserv.devel.redhat.com>
	<20051213101938.GA30118@infradead.org>
From: Miles Bader <miles.bader@necel.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Thu, 15 Dec 2005 13:53:11 +0900
In-Reply-To: <20051213101938.GA30118@infradead.org> (Christoph Hellwig's message of "Tue, 13 Dec 2005 10:19:38 +0000")
Message-Id: <buod5jz6jwo.fsf@dhapc248.dev.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:
> But serious, having to look all over the source instead of just a block
> beginning decreases code readability a lot.

My experience is quite the opposite.

Being forced to put declarations at the beginning of the block in
practice means that people simply separate declarations from the first
assignment.  That uglifies and bloats the code, and seems to often cause
bugs as well (because people seem to often not pay attention to what
happens to a variable between the declaration and first assignment;
having it simply _not exist_ before the first assignment helps quite a
bit).

-Miles
-- 
Run away!  Run away!
