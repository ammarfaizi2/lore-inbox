Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWJQPZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWJQPZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 11:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWJQPZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 11:25:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32393 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751118AbWJQPZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 11:25:05 -0400
Date: Tue, 17 Oct 2006 08:24:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC] typechecking for get_unaligned/put_unaligned
In-Reply-To: <20061017043726.GG29920@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org>
References: <20061017005025.GF29920@ftp.linux.org.uk>
 <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Oct 2006, Al Viro wrote:
> 
> Hrm...  I'm not sure that I buy that argument - we have relatively few
> callers of these suckers and I doubt that it will affect compile time
> in a measurable way.

I was more worried that it's getting included from other include files, 
and that the overhead is just the compiler front-end, whether used or not. 

But you're right, it seems like this is one of the well-behaved header 
files that isn't unnecessarily included everywhere ;)

So I have no real arguments in that case.

> FWIW, that reminds me - I ought to resurrect the patchset killing bogus 
> dependencies; I modified sparse to collect stats on how many times each 
> #include actually pulls a header during build, added those to data on 
> dependencies (from .cmd.*) and got interesting results.

Yeah, we tend to include a _ton_ of stuff that we probably don't need to.

		Linus
