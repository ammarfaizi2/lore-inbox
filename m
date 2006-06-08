Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWFHUVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWFHUVB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWFHUVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:21:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60098 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964963AbWFHUVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:21:00 -0400
Date: Thu, 8 Jun 2006 13:20:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nate Diller <nate.diller@gmail.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH] mm: tracking dirty pages -v6
In-Reply-To: <5c49b0ed0606081310q5771e8d1s55acef09b405922b@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0606081318161.5498@g5.osdl.org>
References: <20060525135534.20941.91650.sendpatchset@lappy> 
 <Pine.LNX.4.64.0606062056540.1507@blonde.wat.veritas.com> 
 <1149770654.4408.71.camel@lappy> <5c49b0ed0606081310q5771e8d1s55acef09b405922b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Jun 2006, Nate Diller wrote:
> 
> Does this mean that processes dirtying pages via mmap are now subject
> to write throttling?  That could dramatically change the performance
> for tasks with a working set larger than 10% of memory.

Exactly. Except it's not a "working set", it's a "dirty set".

Which is the whole (and only) point of the whole patch.

If you want to live on the edge, you can set the dirty_balance trigger to 
something much higher, it's entirely configurable if I remember correctly.

		Linus
