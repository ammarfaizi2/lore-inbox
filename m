Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbSLUQMc>; Sat, 21 Dec 2002 11:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSLUQMc>; Sat, 21 Dec 2002 11:12:32 -0500
Received: from franka.aracnet.com ([216.99.193.44]:18852 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261733AbSLUQMb>; Sat, 21 Dec 2002 11:12:31 -0500
Message-ID: <3E04939F.1020404@BitWagon.com>
Date: Sat, 21 Dec 2002 08:15:27 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@karaya.com>
CC: linux-kernel@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       Julian Seward <jseward@acm.org>
Subject: Re: Valgrind meets UML
References: <200212211607.LAA01515@ccure.karaya.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> jreiser@BitWagon.com said:
> 
>>In order to prevent races between valgrind for UML and kernel
>>allocators which valgrind does not "know", then the VALGRIND_*
>>declarations being added to kernel allocators should allow for
>>expressing the concept "atomically change state in both allocator and
>>valgrind".
> 
> 
> What are you talking about?
> 
> There are no atomicity problems between UML and valgrind.

If so, then you are fortunate.  But in the abstract, and more importantly
in the mind of the maintainer of a lock-free SMP allocator who is trying
to allow simultaneous allocation and valgrind of the allocator, then such
atomicity problems are real.  The VALGRIND_* statements should allow
the conscientious and meticulous maintainer to express the correct
semantics, even though the current implementation of valgrind for UML
might not [have to] take advantage of all of the properties of such a
precise description.  If nothing else, then such a maintainer will invent
his own VALGRIND_* usage to express simultaneous {allocator, valgrind}
state transitions precisely.

-- 
John Reiser, jreiser@BitWagon.com

