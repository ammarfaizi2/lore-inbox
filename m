Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264901AbTK3NYP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 08:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264907AbTK3NYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 08:24:15 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:56729 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264901AbTK3NX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 08:23:59 -0500
Message-ID: <3FC9EF65.8040807@colorfullife.com>
Date: Sun, 30 Nov 2003 14:23:49 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "john smith" <john.smith77@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel modul licensing issues
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John wrote:

>I have some licensing issues with the linux GPL and the implications
>on a project which incorporates partial non-GPL code which I want
>to release as linux kernel module.
>  
>
Wrong mailing list.
You must find a lawyer, and he'll answer your questions.

>I have implemented a proprietary algorithm in user space which I'm not
>allowed to release under the GPL. From a _technical_ point of view I
>could compile the code as kernel module which offers a certain API.
>Note that the kernel module would have only very limited dependency
>on the kernel, i.e. apart from memory allocation functions (kmalloc,
>kfree, vmalloc, vfree) and potentially some "locks" (spinlock, big
>reader lock or rcu) the code is totally independent from the kernel.
>
RCU is a patented algorithm - mention that to your lawyer. Your creation 
must not be derived from the kernel (because creating derived works is 
an exclusive right of the copyright owner, and you don't have and won't 
get a permission), and it must not infringe the RCU patents.

>As far as the interaction with the algorithm API is concerned the
>frontend submits kernel data structures to the algorithm module _but_ 
>since the algorithm has no declaration of kernel structures it does
>neither use nor modify the kernel data. It's just stored and returned
>to the user via certain API functions.
>
You have written an algorithm module that is tightly coupled to the 
Linux kernel, and you think it's not derived from the kernel, correct? 
As a non-lawyer, it'd say that's wrong.
"Derived work" is a legal term, your lawyer might be able to figure out 
if your combination is a derived work.
The drivers that are more or less accepted as not-derived run on 
multiple operating systems - e.g. the nvidia ethernet driver uses the 
same source code for Windows and Linux, and nvlib.o works on Linux and 
FreeBSD.

--
    Manfred
P.S.: You might need a team of lawyers: the definition of derived work 
differs from country to country.

