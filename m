Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbUKQCMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbUKQCMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 21:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbUKQCLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 21:11:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:44260 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262159AbUKQBuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 20:50:50 -0500
Date: Tue, 16 Nov 2004 17:50:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Making compound pages mandatory
In-Reply-To: <2315.1100630906@redhat.com>
Message-ID: <Pine.LNX.4.58.0411161746110.2222@ppc970.osdl.org>
References: <2315.1100630906@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Nov 2004, David Howells wrote:
> 
> Do you have any objection to compound pages being made mandatory, even without
> HUGETLB support?

I haven't really looked into it, so I cannot make an informed decision.  
How big is the overhead? And what's the _point_, since we don't seem to 
need them normally, but the code is there for people who _do_ need them? 

I don't generally like two paths, but quite frankly, I consider the
non-compound case the regular case right now. How expensive does the
compound pages end up being? Is it just one more pointer chase on every
get_page/put_page, or what? Does anybody have numbers for before/after 
that are otherwise comparable?

		Linus
