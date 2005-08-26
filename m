Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751592AbVHZWzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbVHZWzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 18:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbVHZWze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 18:55:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47512 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751591AbVHZWze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 18:55:34 -0400
Date: Fri, 26 Aug 2005 15:55:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Rik van Riel <riel@redhat.com>,
       Ray Fucillo <fucillo@intersystems.com>, linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
In-Reply-To: <Pine.LNX.4.61.0508261917360.8477@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.58.0508261554260.3317@g5.osdl.org>
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au>
 <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com>
 <430E6FD4.9060102@yahoo.com.au> <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org>
 <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508261052330.3317@g5.osdl.org>
 <Pine.LNX.4.61.0508261917360.8477@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Aug 2005, Hugh Dickins wrote:
>
> Well, I still don't think we need to test vm_file.  We can add an
> anon_vma test if you like, if we really want to minimize the fork
> overhead, in favour of later faults.  Do we?

I think we might want to do it in -mm for testing. Because quite frankly, 
otherwise the new fork() logic won't get a lot of testing. Shared memory 
isn't that common.

		Linus
