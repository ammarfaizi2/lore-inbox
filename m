Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317691AbSFLMPj>; Wed, 12 Jun 2002 08:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317692AbSFLMPi>; Wed, 12 Jun 2002 08:15:38 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:62980 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S317691AbSFLMPh>; Wed, 12 Jun 2002 08:15:37 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Oliver Neukum <oliver@neukum.name>, Roland Dreier <roland@topspin.com>,
        "David S. Miller" <davem@redhat.com>
Cc: <wjhun@ayrnetworks.com>, <paulus@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Tue, 11 Jun 2002 22:06:12 +0200
Message-Id: <20020611200612.9251@smtp.adsl.oleane.com>
In-Reply-To: <200206121402.53622.oliver@neukum.name>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If I understand both Davids correctly this is the solution.
>Buffers for dma must be allocated seperately using a special allocation
>function which is given the device so it can allocate correctly.
>David B wants a bus specific pointer to a function in the generic
>driver structure, right ?

Then let's have those as part of the generic device struct, with
the default ones pointing to the parent bus ones.

That way, a couple of generic ones could be set at the root of the
device tree for fully coherent or fully incoherent archs, and
bus drivers would have the ability to affect their child devices
ones.

Ben.


