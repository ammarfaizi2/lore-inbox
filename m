Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131117AbQLILb6>; Sat, 9 Dec 2000 06:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131156AbQLILbt>; Sat, 9 Dec 2000 06:31:49 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:36868 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S131117AbQLILbc>; Sat, 9 Dec 2000 06:31:32 -0500
Date: Sat, 9 Dec 2000 13:49:12 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI bridge setup weirdness
Message-ID: <20001209134912.B1463@jurassic.park.msu.ru>
In-Reply-To: <20001208155128.A2926@jurassic.park.msu.ru> <19341102080252.6877@192.168.1.2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <19341102080252.6877@192.168.1.2>; from bh40@calva.net on Fri, Dec 08, 2000 at 03:31:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 03:31:08PM +0100, Benjamin Herrenschmidt wrote:
> The problem I have (and this is why I don't setup host resources
> properly on multi-host PPCs yet) is that some hosts can have several
> non-contiguous ranges (especially with memory, IO is usually a single
> contiguous range).

What about creating dummy resources covering "holes" between those
ranges and claiming them on the parent bus? Resource allocation code
will put everything in the right places in this case.

Ivan.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
