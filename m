Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLNSB1>; Thu, 14 Dec 2000 13:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129314AbQLNSBR>; Thu, 14 Dec 2000 13:01:17 -0500
Received: from host156.207-175-42.redhat.com ([207.175.42.156]:7945 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129267AbQLNSBI>; Thu, 14 Dec 2000 13:01:08 -0500
Date: Thu, 14 Dec 2000 12:30:42 -0500 (EST)
From: Elliot Lee <sopwith@redhat.com>
To: <orbit-list@gnome.org>
cc: <linux-kernel@vger.kernel.org>, <korbit-cvs@lists.sourceforge.net>
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <s3r93bb4y6.fsf@bigfoot.com.cmm>
Message-ID: <Pine.LNX.4.30.0012141143560.23712-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Dec 2000, Michael Livshin wrote:

> this might be because the Bell Labs folks don't like RPC in general
> when network latencies become involved?  I'm guessing.
>
> 'cause CORBA is still pretty much objectified RPC, as far as I know.
> I don't think you want to abstract the network out just like that when
> dealing with kernels.

OK, since everyone seems to want to argue about this on orbit-list for
some reason, my $0.02:
	CORBA/IIOP is saner than SunRPC in a lot of ways, and it's not too
	horribly more complicated to implement a barebones ORB than a
	barebones SunRPC impl.

	Comments about CORBA being too slow are nonsense - it's just that
	a few crackheads have tried to stick ORBit in the kernel as a
	global IPC mechanism, which it really is not suitable for. CORBA
	has its place, and a GIOP mapping to a kernel-friendly IPC
	mechanism (instead of TCP/IP) would certainly make it more useful
	in the kernel, but generic mechanisms such as CORBA cannot by
	definition be as fast as IPC mechanisms optimized for a specific
	task.

	People like Al Viro, who haven't written GNOME programs of any
	size and certainly don't have mounds of in-depth knowledge of it,
	should probably shut up about about its API & design. :)

TTFN,
-- Elliot
No new ideas for my .sig, and Alan told me my old one was an urban myth, so just
ignore this.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
