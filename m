Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265604AbUFDE5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265604AbUFDE5K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 00:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265603AbUFDE5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 00:57:10 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:32918 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265604AbUFDE5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 00:57:03 -0400
Date: Thu, 3 Jun 2004 22:02:24 -0700
From: Paul Jackson <pj@sgi.com>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       Simon.Derr@bull.net, wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040603220224.73cd8d44.pj@sgi.com>
In-Reply-To: <20040603195409.11d4aec2.davem@redhat.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<20040603170725.4b3f8b34.akpm@osdl.org>
	<20040603194755.667e584b.pj@sgi.com>
	<20040603195409.11d4aec2.davem@redhat.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave wrote:
> Is it really that hard?

Well ...

Currently we have two implementations of cpumasks.  One (in the main
kernel presently) provides a flexible mechanism for arch-specific
optimizations and the use of alternative data types to represent
cpumasks.

The other (using the patch set I just submitted to Andrew) is one size
fits all generic only (except for arch specific bitmap implementations).

The generic only is quite a bit simpler - it has some 26 fewer kernel
source files, and it saves sparc64 some 1144 bytes of kernel text space,
as measured by Andrew.

I really don't want to go 'back' to the fancy version.  If a particular
architecture has specific additional needs, I'm certainly open to
hearing the justifications, tradeoffs and suggestions for ways to meet
those needs.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
