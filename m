Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266295AbSLTWq3>; Fri, 20 Dec 2002 17:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbSLTWq3>; Fri, 20 Dec 2002 17:46:29 -0500
Received: from mnh-1-23.mv.com ([207.22.10.55]:55044 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S266295AbSLTWq2>;
	Fri, 20 Dec 2002 17:46:28 -0500
Message-Id: <200212202258.RAA03444@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: John Reiser <jreiser@BitWagon.com>
Cc: linux-kernel@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       Julian Seward <jseward@acm.org>
Subject: Re: Valgrind meets UML 
In-Reply-To: Your message of "Fri, 20 Dec 2002 07:26:39 PST."
             <3E0336AF.6060607@BitWagon.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 20 Dec 2002 17:58:18 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jreiser@BitWagon.com said:
> Implementors of allocators can have bugs in the valgrind declarations
> they add. An "independent" check based on documented
> externally-visible behavior can help. 

The problem is that valgrind is going to look under the covers of the kernel
allocators and see the externally-visible requirements being violated.

Either you implement a globally correct description, which includes the 
externally visible description as a subset, or you somehow tell valgrind not
to complain about stuff inside the allocator.

The second sounds complicated, and anyway hides bugs in the allocator.

> Nested allocators (inner allocator grabs a large region, outer
> allocator performs sub-allocations of small pieces from the large
> region) can be troublesome. 

And are another reason for implementing a globally correct description.

				Jeff

