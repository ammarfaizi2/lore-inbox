Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129645AbRBCAHY>; Fri, 2 Feb 2001 19:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbRBCAHE>; Fri, 2 Feb 2001 19:07:04 -0500
Received: from jalon.able.es ([212.97.163.2]:62423 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129356AbRBCAG5>;
	Fri, 2 Feb 2001 19:06:57 -0500
Date: Sat, 3 Feb 2001 01:06:49 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: "H . Peter Anvin" <hpa@transmeta.com>
Cc: Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] tmpfs for 2.4.1
Message-ID: <20010203010649.E3014@werewolf.able.es>
In-Reply-To: <20010123205315.A4662@werewolf.able.es> <m3lmrqrspv.fsf@linux.local> <95csna$vb6$1@cesium.transmeta.com> <m3puh1que4.fsf@linux.local> <20010202215254.C2498@werewolf.able.es> <3A7B1EDC.DA2588BA@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A7B1EDC.DA2588BA@transmeta.com>; from hpa@transmeta.com on Fri, Feb 02, 2001 at 21:55:56 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.02 H. Peter Anvin wrote:
> "J . A . Magallon" wrote:
> > 
> > On 02.02 Christoph Rohland wrote:
> > > "H. Peter Anvin" <hpa@zytor.com> writes:
> > >
> > > > What happened with this being a management tool for shared memory
> > > > segments?!
> > >
> > > Unfortunately we lost this ability in the 2.4.0-test series. SYSV shm
> > > now works only on an internal mounted instance and does not link the
> > > directory entry to the deleted state of the segment.
> > >
> > 
> > Mmmmmm, does this mean that mounting /dev/shm is no more needed ?
> > One step more towards easy 2.2 <-> 2.4 switching...
> > 
> 
> In some ways it's kind of sad.  I found the /dev/shm interface to be
> rather appealing :)
> 

I did not get the chance to deal too much with it, but apart from moving
functionality from userspace (ipcs) to kernel (ls), what were/could be the
benefits of /dev/shm ?. Can you create a shared memory segment by simply
creating a file there, or it is just a picture of what is in kernelspace?.

First time I saw that I thought: what could happen if /dev/shm is shared
in a cluster ? or, lets suppose that /dev/shm is a logical volume made by
addition of some nfs mounted volumes, one of each node, so one piece of
the shm fs is local and other remote...kinda DSM/NUMA...?

(just too much marijuana late at night...)

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac1 #2 SMP Fri Feb 2 00:19:04 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
