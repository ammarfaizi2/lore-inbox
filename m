Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262107AbTCRCAL>; Mon, 17 Mar 2003 21:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262120AbTCRCAL>; Mon, 17 Mar 2003 21:00:11 -0500
Received: from smtp07.iddeo.es ([62.81.186.17]:31998 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S262107AbTCRCAK>;
	Mon, 17 Mar 2003 21:00:10 -0500
Date: Tue, 18 Mar 2003 03:11:04 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: nfs and getattr
Message-ID: <20030318021104.GA28827@werewolf.able.es>
References: <20030318014700.GA28769@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030318014700.GA28769@werewolf.able.es>; from jamagallon@able.es on Tue, Mar 18, 2003 at 02:47:00 +0100
X-Mailer: Balsa 2.0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.18, J.A. Magallon wrote:
> A NFS client through 100Mb Ether takes a loooooooong time to read a database
> from the server, which the server itself reads in less than 10 seconds.
> The database is a scene description for render that basically 'includes'
> the same small set of files (around 10) many times, instanced all over the
> place...
> 
> Mount in client:
> 10.0.0.1:/home on /home type nfs (rw,nfsvers=2,noac,addr=10.0.0.1)
> 

More with a silly test:

#!/bin/bash

for i in $(seq 1000)
do
        cat $0 > /dev/null
done

annwn:~> time nfst
0.69user 1.49system 0:02.04elapsed 106%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (126416major+42508minor)pagefaults 0swaps
annwn:~> time bpsh 0 nfst
1.02user 1.86system 0:33.64elapsed 8%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (280major+30minor)pagefaults 0swaps

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre5-jam0 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))
