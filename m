Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbUEFOnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUEFOnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 10:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUEFOnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 10:43:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:49097 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262388AbUEFOnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 10:43:04 -0400
Date: Thu, 6 May 2004 07:42:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>, Richard Henderson <rth@twiddle.net>
cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] get rid of "+m" constraint in i386 rwsems
In-Reply-To: <4955.1083844733@redhat.com>
Message-ID: <Pine.LNX.4.58.0405060740200.3271@ppc970.osdl.org>
References: <4955.1083844733@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 May 2004, David Howells wrote:
> 
> Here's a patch to remove the usage of a "+m" constraint in the i386 optimised
> rwsem implementation.

I think this is wrong, and I thought the gcc people (well, rth seemed to
imply it was a no-brainer) already agreed to support "+m" since:

 - it has long been documented
 - it should be trivial to expand _internally_ in gcc if some 
   implementation thing makes gcc prefer the "=m" / "m" combination.

Richard? 

If it's just a warning in 3.4, and later gcc's are supposed to make it ok 
again, then..

		Linus
