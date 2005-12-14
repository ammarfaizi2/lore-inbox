Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVLNKyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVLNKyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 05:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbVLNKyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 05:54:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25816 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932093AbVLNKyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 05:54:39 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <439F6EAB.6030903@yahoo.com.au> 
References: <439F6EAB.6030903@yahoo.com.au>  <439E122E.3080902@yahoo.com.au> <dhowells1134431145@warthog.cambridge.redhat.com> <22479.1134467689@warthog.cambridge.redhat.com> 
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 14 Dec 2005 10:54:16 +0000
Message-ID: <13613.1134557656@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> atomic_cmpxchg should be available on all platforms.

Two points:

 (1) If it's using spinlocks, then it's pointless to use atomic_cmpxchg.

 (2) atomic_t is a 32-bit type, and on a 64-bit platform I will want a 64-bit
     type so that I can stick the owner address in there (I've got a second
     variant not yet released).

David
