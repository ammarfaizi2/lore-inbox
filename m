Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbQKIAKJ>; Wed, 8 Nov 2000 19:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129100AbQKIAJv>; Wed, 8 Nov 2000 19:09:51 -0500
Received: from jalon.able.es ([212.97.163.2]:7370 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129111AbQKIAIz>;
	Wed, 8 Nov 2000 19:08:55 -0500
Date: Thu, 9 Nov 2000 01:08:48 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Anthony Chatman <anthony@edge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nvidia GeForce2 kernel driver - kernel 2.4.0 test-10
Message-ID: <20001109010848.A709@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <3A08F5E9.61F424A0@ihug.co.nz> <3A092269.9020501@edge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A092269.9020501@edge.net>; from anthony@edge.net on Wed, Nov 08, 2000 at 10:52:41 +0100
X-Mailer: Balsa 1.0.pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Nov 2000 10:52:41 Anthony Chatman wrote:
> Speaking of Nvidia, I have a Nvidia GeForce2, and had problems loading 
> the NV kernel module with a patched test10 kernel (i was running test9 
> before).  I took a look at the test10 patch, and noticed the following 2 
> lines were taken out of  <linux_dir>/include/linux/wrapper.h:
> 
> #define mem_map_inc_count(p) atomic_inc(&(p->count))
> #define mem_map_dec_count(p) atomic_dec(&(p->count))
> 
> I added those two defines back into wrapper.h and then was able to load 

I think you should never do that. Those macros are outdated and were
removed from kernel. Patch NVdriver instead. Patch is attached.

BTW: does your board run ok on 2.4 ? I have a TNT2 and have not been able
to get it working on a 2.4-smp. In 2.2-smp works fine. I don't know what
is bad...In a recent strace (with test10), it seemed to be hanged on a
poll() call...

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
