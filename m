Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131611AbQLJVBX>; Sun, 10 Dec 2000 16:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132028AbQLJVBN>; Sun, 10 Dec 2000 16:01:13 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:11686 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131611AbQLJVBJ>;
	Sun, 10 Dec 2000 16:01:09 -0500
Date: Sun, 10 Dec 2000 15:30:41 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Miloslav Trmac <mitr@volny.cz>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] truncate () doesn't clear partial pages
In-Reply-To: <20001210210352.A764@linux.localdomain>
Message-ID: <Pine.GSO.4.21.0012101529470.4846-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Dec 2000, Miloslav Trmac wrote:

> Hi,
> vmtruncate () in test11 doesn't clear ends of partial pages. Patch is attached

It doesn't and it shouldn't. That's done in ->truncate(). Check ext2_truncate()
for example.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
