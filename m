Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266876AbUIFSt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266876AbUIFSt0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 14:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268448AbUIFSt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 14:49:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:54733 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266876AbUIFStZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 14:49:25 -0400
Date: Mon, 6 Sep 2004 11:48:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
In-Reply-To: <20040906182330.GA79122@muc.de>
Message-ID: <Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org>
References: <20040831183655.58d784a3.pj@sgi.com> <20040904133701.GE33964@muc.de>
 <20040904171417.67649169.pj@sgi.com> <Pine.LNX.4.58.0409041717230.4735@ppc970.osdl.org>
 <20040904180548.2dcdd488.pj@sgi.com> <Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org>
 <20040904204850.48b7cfbd.pj@sgi.com> <Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org>
 <20040904211749.3f713a8a.pj@sgi.com> <20040904215205.0a067ab8.pj@sgi.com>
 <20040906182330.GA79122@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Sep 2004, Andi Kleen wrote:
> 
> The only change I would like to have is to check the excess bytes
> to make sure they don't contain some random value. They should
> be either all 0 or all 0xff. 

I hate the "byte at a time" interface.

That said, I think the "long at a time" interface we have now for bitmaps 
ends up being a compatibility problem, where the compat layer has to worry 
about big-endian 32-bit "long" lookign different from big-endian 64-bit 
"long".

So there are other issues here.

		Linus
