Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbULBEkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbULBEkt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 23:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbULBEkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 23:40:49 -0500
Received: from thunk.org ([69.25.196.29]:29340 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261554AbULBEkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 23:40:42 -0500
Date: Wed, 1 Dec 2004 23:40:34 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Imanpreet Singh Arora <imanpreet@gmail.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What if?
Message-ID: <20041202044034.GA8602@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Imanpreet Singh Arora <imanpreet@gmail.com>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41AE5BF8.3040100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AE5BF8.3040100@gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 05:34:08AM +0530, Imanpreet Singh Arora wrote:
> 
>    I realize most of the unhappiness lies with C++ compilers being 
> slow. Also the fact that a lot of Hackers around here are a lot more 
> familiar with C, rather than C++. However other than that what are the  
> _implementation_  issues that you hackers might need to consider if it 
> were to be implemented in C++. 

The suckitude of C++ compilers is only part of the issues.

> My question is regarding how will kernel 
> deal with C++ doing too much behind the back, Calling constructors, 
> templates exceptions and other. What are the possible issues of such an 
> approach while writing device drivers?  What sort of modifications do 
> you reckon might be needed if such a move were to be made?

The way the kernel will deal with C++ language being a complete
disaster (where something as simple as "a = b + c + d +e" could
involve a dozen or more memory allocations, implicit type conversions,
and overloaded operators) is to not use it.  Think about the words of
wisdom from the movie Wargames: "The only way to win is not to play
the game".

					- Ted
