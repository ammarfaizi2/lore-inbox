Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129970AbQKIW4V>; Thu, 9 Nov 2000 17:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130205AbQKIW4L>; Thu, 9 Nov 2000 17:56:11 -0500
Received: from jalon.able.es ([212.97.163.2]:5348 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129970AbQKIW4H>;
	Thu, 9 Nov 2000 17:56:07 -0500
Date: Thu, 9 Nov 2000 23:55:59 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Andrea Pintori <1997s112@educ.disi.unige.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.2.17 bug found
Message-ID: <20001109235559.A747@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <Pine.LNX.3.91.1001109171915.5142B-100000@aries>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.3.91.1001109171915.5142B-100000@aries>; from 1997s112@educ.disi.unige.it on Thu, Nov 09, 2000 at 16:20:22 +0100
X-Mailer: Balsa 1.0.pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 09 Nov 2000 16:20:22 Andrea Pintori wrote:
> I've a Debian dist, Kernel 2.2.17, no patches, all packages are stable.
> 
> here what I found:
> 
> [/tmp] mkdir old
> [/tmp] chdir old
> [/tmp/old] mv . ../new
> [/tmp/old]                    (should be /tmp/new !!)

No, bash cwd is still "/tmp/old".

> [/tmp/old] mkdir fff
> error: cannot write...
> [tmp/old] ls > fff
> error: cannot write...
> [/tmp/old] ls -la
> total 0                         (?)

Right, "/tmp/old" does not exist, so nothing can be done with it.

> [/tmp/old] cd ..
> [/tmp] ls -la
> *****************       ./
> *****************       ../
> *****************       new/
> 
> Does anybody knew this bug?

Is not a bug, I have also seen that int SGI IRIX. Try it in an NFS mounted
disk. I don't remember exactly, but even you can ls it. Things on file
system caches and so on...

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
