Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbTEGTyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264247AbTEGTyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:54:52 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:27839 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264245AbTEGTyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:54:47 -0400
Date: Wed, 7 May 2003 22:06:47 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Jonathan Lundell <linux@lundell-bros.com>, root@chaos.analogic.com,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030507200647.GB3166@wohnheim.fh-wedel.de>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]> <3EB957FA.4080900@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EB957FA.4080900@us.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003 12:01:14 -0700, Dave Hansen wrote:
> Jonathan Lundell wrote:
> > One thing that would help (aside from separate interrupt stacks) 
> > would be a guard page below the stack. That wouldn't require any 
> > physical memory to be reserved, and would provide positive indication 
> > of stack overflow without significant runtime overhead.
> 
> x86 doesn't really have big physical shortages right now.  But, the
> _virtual_ shortages are significant.  The guard page just increases the
> virtual cost by 50%.

Different people have different constraints. :)

For me, physical memory is low while virtual memory is abundant.  But
even in your case, the guard page might be an acceptable evil during a
(hopefully short) transition time.

> The stack overflow checking in -mjb uses gcc's mcount mechanism to
> detect overflows.  It should get called on every single function call.

Nice trick.  Do you have better documentation on that machanism than
man gcc?  The paragraph to -p is quite short and I cannot make the
connection to the rest of the patch immediately.

Jörn

-- 
Optimizations always bust things, because all optimizations are, in
the long haul, a form of cheating, and cheaters eventually get caught.
-- Larry Wall 
