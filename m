Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317677AbSFLJjF>; Wed, 12 Jun 2002 05:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317678AbSFLJjE>; Wed, 12 Jun 2002 05:39:04 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:32260 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S317677AbSFLJjE>; Wed, 12 Jun 2002 05:39:04 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <roland@topspin.com>, "David S. Miller" <davem@redhat.com>
Cc: <oliver@neukum.name>, <wjhun@ayrnetworks.com>, <paulus@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Tue, 11 Jun 2002 19:29:20 +0200
Message-Id: <20020611172920.18340@smtp.adsl.oleane.com>
In-Reply-To: <52y9dl65aa.fsf@topspin.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This may use less memory than 1) or 2) above on some architectures but
>will use more than 1) on cache-coherent architectures.  It makes the
>code even more complex since now the code that allocates the dma
>buffer has to know which PCI device will use it (for example, in USB,
>the hub driver is separated from the HCD driver, which is who knows
>about the PCI bus).

What about an arch that can be both coherent or incoherent (the same
kernel binary would boot both) ?

I can also imagine quite a bunch of embedded stuffs where you may have
both coherent and non-coherent devices depending on the bus the live
on or on bridge bugs.

For your example, I don't buy it. You could well design the USB urb
allocation in such a way that they are passed down the controller of
a given device.

Ben.



