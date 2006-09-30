Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751942AbWI3U3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbWI3U3a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 16:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbWI3U3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 16:29:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60546 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751936AbWI3U33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 16:29:29 -0400
Date: Sat, 30 Sep 2006 13:28:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, Chandra Seetharaman <sekharan@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Jan Beulich <jbeulich@novell.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
In-Reply-To: <20060930202117.GO29920@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0609301326320.3952@g5.osdl.org>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
 <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org> <20060930202117.GO29920@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Sep 2006, Al Viro wrote:
> 
> Oh, so _that_ is what it is supposed to do?  I've seen it when it went
> in, tried to read, barfed and chalked it up to KDB or itanic braindamage
> (both have turds of that genre).  Didn't realize that lockdep used it too...

Well, anything that shows or needs a back-trace. By definition, it's 
pretty much just debug code.

I sure as hell hope we don't have any actual _semantics_ that depend on 
back-traces, like the broken asynchronous C++ exception handling code etc 
that people have in user space (what a total brain-damage _that_ is!).

		Linus
