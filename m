Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130901AbQKZLGI>; Sun, 26 Nov 2000 06:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130900AbQKZLFt>; Sun, 26 Nov 2000 06:05:49 -0500
Received: from 194-73-188-238.btconnect.com ([194.73.188.238]:26628 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129722AbQKZLFp>;
        Sun, 26 Nov 2000 06:05:45 -0500
Date: Sun, 26 Nov 2000 10:37:07 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Tim Waugh <twaugh@redhat.com>
cc: James A Sutherland <jas88@cam.ac.uk>, Andries Brouwer <aeb@veritas.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <20001125235511.A16662@redhat.com>
Message-ID: <Pine.LNX.4.21.0011261036001.1015-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2000, Tim Waugh wrote:

> On Sat, Nov 25, 2000 at 10:53:00PM +0000, James A Sutherland wrote:
> 
> > Which is silly. The variable is explicitly defined to be zero
> > anyway, whether you put this in your code or not.
> 
> Why doesn't the compiler just leave out explicit zeros from the
> 'initial data' segment then?  Seems like it ought to be tought to..

yes, taught to, _BUT_ never let this to be a default option, please.
Because there are valid cases where a programmer things "this is in .data"
and that means this should be in .data. Think of binary patching an object
as one valid example (there may be others, I forgot).

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
