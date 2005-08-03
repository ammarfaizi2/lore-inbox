Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVHCQnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVHCQnZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 12:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVHCQnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 12:43:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19333 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262333AbVHCQnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 12:43:23 -0400
Date: Wed, 3 Aug 2005 09:42:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Hugh Dickins <hugh@veritas.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <Pine.LNX.4.58.0508030933130.4370@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0508030942140.3258@g5.osdl.org>
References: <OF3BCB86B7.69087CF8-ON42257051.003DCC6C-42257051.00420E16@de.ibm.com>
 <Pine.LNX.4.58.0508020829010.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508021645050.4921@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508020911480.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508021809530.5659@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508021127120.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508022001420.6744@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508021244250.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508022150530.10815@goblin.wat.veritas.com>
 <42F09B41.3050409@yahoo.com.au> <Pine.LNX.4.58.0508030902380.3341@g5.osdl.org>
 <Pine.LNX.4.58.0508030933130.4370@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Aug 2005, Linus Torvalds wrote:
> 
> What makes us not get into an infinite loop there? 

Ahh, never mind, I didn't notice that we never set the "read" thing at 
all, so ptrace will never care if it's readable or not. No problem.

		Linus
