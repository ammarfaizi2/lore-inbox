Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131166AbQLJRlU>; Sun, 10 Dec 2000 12:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131210AbQLJRlL>; Sun, 10 Dec 2000 12:41:11 -0500
Received: from 62-6-231-238.btconnect.com ([62.6.231.238]:51717 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S131166AbQLJRlG>;
	Sun, 10 Dec 2000 12:41:06 -0500
Date: Sun, 10 Dec 2000 17:12:40 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] NR_RESERVED_FILES broken in 2.4 too
In-Reply-To: <Pine.LNX.4.30.0012101803390.5455-100000@fs129-190.f-secure.com>
Message-ID: <Pine.LNX.4.21.0012101708270.1350-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just retested under test12-pre7 and confirm my previous findings
i.e. there is no problem with get_empty_filp(), at least of the kind you
describe.

The definition of reserved file structures for root is -- those which are
taken from the freelist until it is not empty. In this sense it works and
I don't see why you think this definition is useless (it was like that for
ages, at least for the entire duration of 2.4.x kernels).

In brief -- it works, no patching is needed, unless you found some other
problem (e.g. you mentioned something about allocating more than NR_FILES
on SMP -- what do you mean?) which you are not explaining clearly.

You just say "it is broken and here is the patch" but that, imho, is not
enough. (ok, one could overcome the laziness and actually _read_ your
patch to see what you _think_ is broken but surely it is better if you
explain it yourself?). The current state of get_empty_filp() is simple and
readable -- how can it be broken?

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
