Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbWGHVd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbWGHVd0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 17:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbWGHVd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 17:33:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13969 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030405AbWGHVdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 17:33:25 -0400
Date: Sat, 8 Jul 2006 14:26:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>,
       Stephane Eranian <eranian@hpl.hp.com>
cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: use thread_info flags for debug regs and IO 
 bitmaps
In-Reply-To: <200607071155_MC3-1-C45F-B7C2@compuserve.com>
Message-ID: <Pine.LNX.4.64.0607081425430.3869@g5.osdl.org>
References: <200607071155_MC3-1-C45F-B7C2@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jul 2006, Chuck Ebbert wrote:
>
> From: Stephane Eranian <eranian@hpl.hp.com>
> 
> Use thread info flags to track use of debug registers and IO bitmaps.
>  
> 	- add TIF_DEBUG to track when debug registers are active
>  	- add TIF_IO_BITMAP to track when I/O bitmap is used
>  	- modify __switch_to() to use the new TIF flags

Can you explain what the advantages of this are?

I don't see it. It's just creating new state to describe state that we 
already had, and as far as I can tell, it's just a way to potentially have 
more new bugs thanks to the new state getting out of sync with the old 
one?

		Linus
