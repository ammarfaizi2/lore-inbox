Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132135AbQL3Bnj>; Fri, 29 Dec 2000 20:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132403AbQL3Bn3>; Fri, 29 Dec 2000 20:43:29 -0500
Received: from gadolinium.btinternet.com ([194.73.73.111]:58610 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S132135AbQL3BnT>; Fri, 29 Dec 2000 20:43:19 -0500
Date: Sat, 30 Dec 2000 01:07:38 +0000 (GMT)
From: Dave Gilbert <gilbertd@treblig.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: NFS oddity (2.4.0test13pre4ac2 server, 2.0.36/2.2.14 clients)
In-Reply-To: <14925.12964.995179.63899@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.10.10012300105100.26235-100000@tardis.home.dave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Dec 2000, Neil Brown wrote:

> On Friday December 29, gilbertd@treblig.org wrote:
> > On Sat, 30 Dec 2000, Neil Brown wrote:
> > 
> > > > So where did the gilbertd directory go ?
> 
> It suffered the curse of the 8-character file name....

Ah well spotted! It also happens to 12 byte names.

> Could you
>   gdb vmlinux
>   disassemble xdr_decode_string
>   disassemble memmove

A job for tomorrow.

> and see if the code looks right?
> 
> You might like to try:
> 
>  1/ move gilbertd to gilbertdd and see if you can then access it over
>     nfs.

Yep - it starts working.

>  2/ create a file called "ertdertd" and see if you get that when you
>     try to access gilbertd

Hehe yes; accessing gilbertd gives you the contents or ertdertd.


The server architecture is Alpha. (Client Sparc and x86).

Dave

-- 
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert      | Running GNU/Linux on       |  Happy  \ 
\   gro.gilbert @ treblig.org |  Alpha, x86, ARM and SPARC |  In Hex /
 \ ___________________________|___ http://www.treblig.org  |________/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
