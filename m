Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751784AbWIYBU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbWIYBU7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 21:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWIYBU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 21:20:59 -0400
Received: from ozlabs.org ([203.10.76.45]:59041 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751784AbWIYBU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 21:20:58 -0400
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
In-Reply-To: <45172BCE.4010708@goop.org>
References: <1158925861.26261.3.camel@localhost.localdomain>
	 <1158925997.26261.6.camel@localhost.localdomain>
	 <1158926106.26261.8.camel@localhost.localdomain>
	 <1158926215.26261.11.camel@localhost.localdomain>
	 <1158926308.26261.14.camel@localhost.localdomain>
	 <1158926386.26261.17.camel@localhost.localdomain>
	 <4514663E.5050707@goop.org> <20060923081337.GA10534@muc.de>
	 <45172BCE.4010708@goop.org>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 11:20:53 +1000
Message-Id: <1159147253.26986.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-24 at 18:07 -0700, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> >> I managed to get all this done in head.S before going into C code; is 
> >> that not still possible?  Or is there a later patch to do this.
> >>     
> >
> > Why write in assembler what you can write in C?
> >   
> This stuff is very basic, and you could consider it as being part of the 
> kernel's C runtime model, and therefore can be expected to be available 
> everywhere.  In particular, the use of current is so prevalent that you 
> really can't call anything without having the PDA set up.

Yeah, I agree with Jeremy.  It's nice if we can just use it everywhere,
and he kindly explained to me that secondary CPUs we can do most of it
before the CPU bringup (ie. in C): we just have to load the gs register
in asm AFAICT.

I'll produce a patch, so we can see what we're talking about...

Thanks!
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

