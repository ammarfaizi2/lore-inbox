Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131640AbQK2TQr>; Wed, 29 Nov 2000 14:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131796AbQK2TQ1>; Wed, 29 Nov 2000 14:16:27 -0500
Received: from 213-123-77-235.btconnect.com ([213.123.77.235]:40711 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S131640AbQK2TQR>;
        Wed, 29 Nov 2000 14:16:17 -0500
Date: Wed, 29 Nov 2000 18:47:46 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <Pine.LNX.4.10.10011291036180.11951-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0011291844410.1803-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Linus Torvalds wrote:
> Ehh, this is a stupid question, but I've had that happen too, and it
> turned out my /tmp filesystem was full, and it runs out of space only with
> certain large link cases (never anything else, because all the other
> stages of compilation are done with -pipe and do not use /tmp files).
> 
> I'm embarrassed to even mention this, but I'v ebeen confused myself.
> 

No, I did check my /tmp, I can assure you. Well, no, I did _not_ but I do
not have a separate /tmp. I like huge root filesystems (until recently,
when I realized that I most often corrupt/work in /usr/src so it's now
separate and there are multiple roots for disaster recovery) so checking
that root was OK implied /tmp was OK.

Also, running out of space in /tmp can hardly cause a bunch of ext2
messages about freeing blocks not in datazone etc.

Regards,
Tigran

PS. I do have another filesystem which is separate from root, i.e. /boot,
again shared amongst all roots but I doubt ld(1) is storing anything in
/boot :)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
