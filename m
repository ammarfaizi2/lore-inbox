Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129756AbQK1Qhr>; Tue, 28 Nov 2000 11:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129591AbQK1Qhh>; Tue, 28 Nov 2000 11:37:37 -0500
Received: from 213-123-72-140.btconnect.com ([213.123.72.140]:14343 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129756AbQK1QhY>;
        Tue, 28 Nov 2000 11:37:24 -0500
Date: Tue, 28 Nov 2000 16:09:17 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: bug in count_open_files() or a strange granularity?
In-Reply-To: <Pine.GSO.4.21.0011281049400.9313-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0011281608460.1254-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000, Alexander Viro wrote:
> Besides, locking rules like that (you must hold the files->files_lock if
> doclose is 0 and you must NOT hold it is doclose is 1) are sick. We could
> make the function itself grab the spinlock, but then the return value
> becomes junk before the thing returns it.

Ok, you are right (about such policy being sick) -- I will think a bit
more. Thank you!

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
