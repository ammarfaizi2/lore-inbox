Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131609AbRBASxb>; Thu, 1 Feb 2001 13:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131610AbRBASxV>; Thu, 1 Feb 2001 13:53:21 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:45902 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131609AbRBASxI>; Thu, 1 Feb 2001 13:53:08 -0500
Date: Thu, 1 Feb 2001 13:51:38 -0500 (EST)
From: <bcrl@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Christoph Hellwig <hch@caldera.de>, "Stephen C. Tweedie" <sct@redhat.com>,
        Steve Lord <lord@sgi.com>, <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
 /notify + callback chains
In-Reply-To: <E14ONdD-0004gz-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0102011321470.3872-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Alan Cox wrote:

> Linus list of reasons like the amount of state are more interesting

The state is required, not optional, if we are to have a decent basis for
building asyncronous io into the kernel.

> Networking wants something lighter rather than heavier. Adding tons of
> base/limit pairs to kiobufs makes it worse not better

I'm still not seeing what I consider valid arguments from the networking
people regarding the use of kiobufs as the interface they present to the
VFS for asynchronous/bulk io.  I agree with their needs for a light weight
mechanism for getting small io requests from userland, and even the need
for using lightweight scatter gather lists within the network layer
itself.  If the statement is that map_user_kiobuf is too heavy for use on
every single io, sure.  But that is a seperate issue.

		-ben


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
