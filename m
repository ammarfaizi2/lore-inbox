Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422777AbWJRSw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422777AbWJRSw0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422780AbWJRSw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:52:26 -0400
Received: from livid.absolutedigital.net ([66.92.46.173]:20754 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S1422777AbWJRSwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:52:25 -0400
Date: Wed, 18 Oct 2006 14:52:21 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Linus Torvalds <torvalds@osdl.org>
cc: Albert Cahalan <acahalan@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com
Subject: Re: sysctl
In-Reply-To: <Pine.LNX.4.64.0610181129090.3962@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net>
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com>
 <Pine.LNX.4.64.0610181129090.3962@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006, Linus Torvalds wrote:

> There's apparently some library functions that has used it in the past, 
> and I've seen a few effects of that:
> 
> 	warning: process `wish' used the removed sysctl system call
> 
> but the users all had fallback positions, so I don't think anything 
> actually broke.

Agreed, nothing seems to have broken by removing it but the warnings sure 
are ugly. Is there any reason to have them? If a program relies on sysctl 
and the call fails the program should properly handle the error. That 
should be all the warning that's needed (i.e. report the broken program 
and get it fixed).

> (The situation may be different with older libraries, which is why it's 
> still an option to compile in sysctl. None of the machines I had access 
> to cared at all, though).

So leave it as is for now, default to off with option to compile in if 
EMBEDDED and then remove it completely in a few months?

  - C.
