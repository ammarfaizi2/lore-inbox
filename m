Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264771AbRFXViJ>; Sun, 24 Jun 2001 17:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264772AbRFXViD>; Sun, 24 Jun 2001 17:38:03 -0400
Received: from jalon.able.es ([212.97.163.2]:49033 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S264771AbRFXVhr>;
	Sun, 24 Jun 2001 17:37:47 -0400
Date: Sun, 24 Jun 2001 23:41:01 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: landley@webofficenow.com
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Timur Tabi <ttabi@interactivesi.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010624234101.A1619@werewolf.able.es>
In-Reply-To: <Pine.LNX.3.96.1010622162213.32091B-100000@artax.karlin.mff.cuni.cz> <0106220929490F.00692@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <0106220929490F.00692@localhost.localdomain>; from landley@webofficenow.com on Fri, Jun 22, 2001 at 15:29:49 +0200
X-Mailer: Balsa 1.1.6-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010622 Rob Landley wrote:
>
>I still consider the difference between threads and processes with shared 
>resources (memory, fds, etc) to be largely semantic.
>

They should not be the same. Processes are processes, and threads were designed
for situations where processes are too heavy. Other thing is that in new
kernels (for example, Linux) processes are being optimized (ie, vm fast
'cloning' via copy-on-write) or expanded with new features (Linux' clone+
CLONE_VM). But they are different beasts.

This remembers on other question I read in this thread (I tried to answer then
but I had broke balsa...). Somebody posted some benchmarks of linux
fork()+exec() vs Solaris fork()+exec(). That is comparing apples and
oranges. The clean battle should be linux fork-exec vs vfork-exec in Solaris,
because for in linux is really a vfork in solaris.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac17 #2 SMP Fri Jun 22 01:36:07 CEST 2001 i686
