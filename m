Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131712AbQLJSXQ>; Sun, 10 Dec 2000 13:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131576AbQLJSXG>; Sun, 10 Dec 2000 13:23:06 -0500
Received: from 62-6-231-238.btconnect.com ([62.6.231.238]:1030 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S131535AbQLJSWx>;
	Sun, 10 Dec 2000 13:22:53 -0500
Date: Sun, 10 Dec 2000 17:54:28 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] NR_RESERVED_FILES broken in 2.4 too
In-Reply-To: <Pine.LNX.4.21.0012101708270.1350-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0012101752140.1473-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2000, Tigran Aivazian wrote:
> enough. (ok, one could overcome the laziness and actually _read_ your
> patch to see what you _think_ is broken but surely it is better if you
> explain it yourself?).

This was not meant to say that I have not read your patch. Of course, I
have read it and already commented that you seem to be suggesting a new
policy for reserved file allocation, namely to allow touching the slab
cache for the sake of satisfying the root'd allocation requests. This,
imho, is unnecessary because the current design of
get_empty_filp() makes use of the freelist for this purpose -- there is no
need to extend or drop this constraint -- the simple check if freelist has
elements still, is quite sufficient.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
