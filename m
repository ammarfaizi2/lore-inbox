Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265886AbRF2MtL>; Fri, 29 Jun 2001 08:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265881AbRF2MtB>; Fri, 29 Jun 2001 08:49:01 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:6483 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S265875AbRF2Msv>; Fri, 29 Jun 2001 08:48:51 -0400
Date: Fri, 29 Jun 2001 07:48:47 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200106291248.HAA02327@tomcat.admin.navo.hpc.mil>
To: blessonpaul@usa.net, linux-kernel@vger.kernel.org
Subject: Re: [Re: gcc: internal compiler error: program cc1 got fatal signal 11]
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> "This is almost always the result of flakiness in your hardware - either
> RAM (most likely), or motherboard (less likely).  "
>                          
>                               I cannot understand this. There are many other
> stuffs that I compiled with gcc without any problem. Again compilation is only
> a application. It  only parse and gernerates object files. How can RAM or
> motherboard makes different

It's most likely flackey memory.

Remember- a single bit that dropps can cause the signal 11. It doesn't have
to happen consistently either. I had the same problem until I slowed down
memory access (that seemd to cover the borderline chip).

The compiler uses different amounts of memory depending on the source file,
number of symbols defined (via include headers). When the multiple passes
occur simultaneously, there is higher memory pressure, and more of the
free space used. One of the pages may flake out. Compiling the kernel
puts more pressure on memory than compiling most applications.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
