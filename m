Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264497AbRFYWaa>; Mon, 25 Jun 2001 18:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264521AbRFYWaV>; Mon, 25 Jun 2001 18:30:21 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:23340 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264497AbRFYWaO>; Mon, 25 Jun 2001 18:30:14 -0400
Date: Mon, 25 Jun 2001 18:30:13 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200106252230.f5PMUDE26001@devserv.devel.redhat.com>
To: roland@hellmouth.digitalvampire.org, linux-kernel@vger.kernel.org
Subject: Re: Linux and system area networks
In-Reply-To: <mailman.993492125.21454.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.993492125.21454.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd like to find out if anyone has thought about how Linux will handle
> some of the new network technologies people are starting to push.
> Specifically I'm talking about "System Area Networks," that is, things
> like Infiniband, as well as TCP/IP offload.

Infiniband is doing relatively well, as much as anything can
with Intel at the helm (see "Itanic"). This has nothing to
do with TCP/IP offload, which is an extremely stupid idea.
The whole thing stems from a desire by vendors to sell
"smart" (== very expensive) NICs.

RDMA in Infiniband is, in my view, a little more than
traditional DMA in any other advanced server I/O bus.
Sun UPA is packetized, for instance.

> The rough idea is that WSD is a new user space library that looks at
> sockets calls and decides if they have to go through the usual kernel
> network stack, or if they can be handed off to a "SAN service
> provider" which bypasses the network stack and uses hardware reliable
> transport and possibly RDMA.

That can be done in Linux just as easily, using same DLLs
(they are called .so for "shared object"). If you look
at Ashok Raj's Infi presentation, you may discern "user-level
sockets", if you look hard enough. I invite you to try, if
errors of others did not teach you anything.

> This means that all applications that use Winsock benefit from the
> advanced network hardware.  Also, it means that Windows is much easier
> for hardware vendors to support than other OSes.  For example,
> Alacritech's TCP/IP offload NIC only works under Windows.  Microsoft
> is also including Infiniband support in Windows XP and Windows 2002.

IMHO, Alacritech is about to join scores and scores of vendors
who tried that before. Customers understand very soon that
a properly written host based stack works much better in
the face of a changing environment: Faster CPUs, new CPUs
(IA-64), new network protocols (ECN). Besides, it is easy
to "accelerate" a bad network stack, but try to outdo a
well done stack.

> So I guess my question is whether anyone has started thinking about
> the architectural changes needed to make System Area Networking and
> TCP/IP offload easier under Linux.

Pretty much zero-copy that DaveM and Co. do addresses this.

-- Pete
