Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264717AbRFZMgz>; Tue, 26 Jun 2001 08:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264851AbRFZMgp>; Tue, 26 Jun 2001 08:36:45 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:52538 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S264717AbRFZMgc>; Tue, 26 Jun 2001 08:36:32 -0400
Date: Tue, 26 Jun 2001 07:36:30 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200106261236.HAA79784@tomcat.admin.navo.hpc.mil>
To: roland@topspincom.com, linux-kernel@vger.kernel.org
Subject: Re: Linux and system area networks
Cc: Pete Zaitcev <zaitcev@redhat.com>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> >>>>> "Pete" == Pete Zaitcev <zaitcev@redhat.com> writes:
> 
>     Roland> The rough idea is that WSD is a new user space library
>     Roland> that looks at sockets calls and decides if they have to go
>     Roland> through the usual kernel network stack, or if they can be
>     Roland> handed off to a "SAN service provider" which bypasses the
>     Roland> network stack and uses hardware reliable transport and
>     Roland> possibly RDMA.
> 
>     Pete> That can be done in Linux just as easily, using same DLLs
>     Pete> (they are called .so for "shared object"). If you look at
>     Pete> Ashok Raj's Infi presentation, you may discern "user-level
>     Pete> sockets", if you look hard enough. I invite you to try, if
>     Pete> errors of others did not teach you anything.
> 
> I think you misunderstood the point.  Microsoft is providing this WSD
> DLL as a standard part of W2K now.  This means that hardware vendors
> just have to write a SAN service provider, and all Winsock-using
> applications benefit transparently.  No matter how good your TCP/IP
> implementation is, you still lose (especially in latency) compared to
> using reliable hardware transport.  Oracle-with-VI and DAFS-vs-NFS
> benchmarks show this quite clearly.

You do loose in security. You can't use IPSec over such a device without
some drastic overhaul.

> Linux has nothing to compare to Winsock Direct.  I agree, one could
> put an equivalent in glibc, or one could take advantage of Linux's
> relatively low system call latency and put something in the kernel.
> The unfortunate consequence of this is that SAN (system area network)
> hardware vendors are not going to support Linux very well.
> 
> BTW, do you have a pointer to Ashok Raj's presentation?

That would be usefull. We had a presentation here, but it did not
show any great detail (mostly marketing drivel "it will be faster/more
efficient/less overhead.." but nothing about security).
 
>     Roland> This means that all applications that use Winsock benefit
>     Roland> from the advanced network hardware.  Also, it means that
>     Roland> Windows is much easier for hardware vendors to support
>     Roland> than other OSes.  For example, Alacritech's TCP/IP offload
>     Roland> NIC only works under Windows.  Microsoft is also including
>     Roland> Infiniband support in Windows XP and Windows 2002.
> 
>     Pete> IMHO, Alacritech is about to join scores and scores of
>     Pete> vendors who tried that before. Customers understand very
>     Pete> soon that a properly written host based stack works much
>     Pete> better in the face of a changing environment: Faster CPUs,
>     Pete> new CPUs (IA-64), new network protocols (ECN). Besides, it
>     Pete> is easy to "accelerate" a bad network stack, but try to
>     Pete> outdo a well done stack.
> 
> OK, how about an Infiniband network with a TCP/IP gateway at the edge?
> Have we thought about how Linux servers should use the gateway to talk
> to internet hosts?  Surely there's no point in running TCP/IP inside
> the Infiniband network, so there needs to be some concept of "socket
> over Infiniband."

One of the problems I haven't seen explained is how the address translation
between TCP/IP and any SAN. Much less how security is going to be controled.
Personally, I think it will end up equivalent to TCP/IP over fibre channel...

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
