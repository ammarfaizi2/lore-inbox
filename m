Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131620AbQKZPXy>; Sun, 26 Nov 2000 10:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131602AbQKZPXp>; Sun, 26 Nov 2000 10:23:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13835 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S131620AbQKZPX3>;
        Sun, 26 Nov 2000 10:23:29 -0500
Date: Sun, 26 Nov 2000 14:52:53 +0000
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Tim Waugh <twaugh@redhat.com>, James A Sutherland <jas88@cam.ac.uk>,
        Andries Brouwer <aeb@veritas.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001126145253.U2272@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20001125235511.A16662@redhat.com> <Pine.LNX.4.21.0011261036001.1015-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0011261036001.1015-100000@penguin.homenet>; from tigran@veritas.com on Sun, Nov 26, 2000 at 10:37:07AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2000 at 10:37:07AM +0000, Tigran Aivazian wrote:
> On Sat, 25 Nov 2000, Tim Waugh wrote:
> > Why doesn't the compiler just leave out explicit zeros from the
> > 'initial data' segment then?  Seems like it ought to be tought to..
> 
> yes, taught to, _BUT_ never let this to be a default option, please.
> Because there are valid cases where a programmer things "this is in .data"

That's what __attribute__ ((section (".data"))) is for.

> and that means this should be in .data. Think of binary patching an object
> as one valid example (there may be others, I forgot).

can you think of any valid examples that apply to the kernel ?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
