Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131399AbQK2RJW>; Wed, 29 Nov 2000 12:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131415AbQK2RJM>; Wed, 29 Nov 2000 12:09:12 -0500
Received: from 213-123-77-235.btconnect.com ([213.123.77.235]:18182 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S131399AbQK2RJD>;
        Wed, 29 Nov 2000 12:09:03 -0500
Date: Wed, 29 Nov 2000 16:40:29 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Hugh Dickins <hugh@veritas.com>, Andries Brouwer <aeb@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
In-Reply-To: <Pine.GSO.4.21.0011291051010.14112-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0011291636440.1306-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Alexander Viro wrote:
> Historically, on systems that allow write access to devices
> on r/o filesystems access() doesn't return EROFS for devices. Moreover, that's
> what one might reasonably expect and there are programs relying on that.
> Principle of minimal surprise and all such...

That is precisely the point I was making in my previous email. But both
that email and yours asnwer only one question:

a) should access(2) behave identical to open(2) (with switched uid)? The
answer is Yes.

but the main question still remains unanswered:

b) what should be the return of access(W_OK) (or, the same, open() for 
write with switched uid) for devices on a readonly-mounted filesystems?

Should the majority win? I.e. should we say OK, as we do now?

Regards,
Tigran


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
