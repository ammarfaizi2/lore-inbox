Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbQLAR5p>; Fri, 1 Dec 2000 12:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129571AbQLAR5f>; Fri, 1 Dec 2000 12:57:35 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:42767 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S129385AbQLAR50>; Fri, 1 Dec 2000 12:57:26 -0500
Date: Fri, 1 Dec 2000 17:26:39 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: "Theodore Y Ts'o" <tytso@mit.edu>
cc: linux-kernel@vger.kernel.org, vpnd@sunsite.auc.dk
Subject: /dev/random probs in 2.4test(12-pre3)
Message-ID: <Pine.LNX.4.10.10012011720050.23462-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It looks like the random driver in 2.4test will return a
short read, rather than blocking.  This is breaking vpnd
(http://sunsite.dk/vpnd/) which breaks with "failed to
gather random data" or similar.

Here's a sample strace:

open("/dev/random", O_RDONLY)           = 3
read(3, "q\321Nu\204\251^\234i\254\350\370\363\"\305\366R\2708V"..., 72) = 29
close(3)                                = 0

Have the semantics of the device changed, or is vpnd doing
something wrong?

Matthew.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
