Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130111AbQJ0MF3>; Fri, 27 Oct 2000 08:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbQJ0MFU>; Fri, 27 Oct 2000 08:05:20 -0400
Received: from zeus.kernel.org ([209.10.41.242]:44036 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130131AbQJ0MFL>;
	Fri, 27 Oct 2000 08:05:11 -0400
Subject: Re: missing mxcsr initialization
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 27 Oct 2000 12:42:03 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), andrea@suse.de (Andrea Arcangeli),
        dledford@redhat.com (Doug Ledford), paubert@iram.es (Gabriel Paubert),
        mingo@redhat.com, gareth@valinux.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10010262229330.864-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 26, 2000 10:35:25 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13p7te-0004MB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Go back. Read ym email. Realize that you do this ONCE. At setup time.

(I've got about 2000 to read after this jaunt so I may have missed some)

> You can even split SEP into SEPOLD and SEPNEW, and _always_ just test one
> bit. You should not have to test stepping levels in normal use: that
> invariably causes problems when there are more than one CPU that has some
> feature.

Agree

> 	if (vendor == intel && stepping < 5) {
> 		...
> 	}
> 
> and it appears to work again, until it turns out that Cyrix has the same
> issue, and then it ends up being the test from hell, where different
> vendor tests all clash, and it gets increasingly difficult to add a new
> thing later on sanely. 

And you end up with mtrr.c

> No thank you. We'll just require fixed feature flags. Which can be turned
> on as the features are enabled.

That seems sensible

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
