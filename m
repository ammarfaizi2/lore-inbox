Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRACXlm>; Wed, 3 Jan 2001 18:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbRACXld>; Wed, 3 Jan 2001 18:41:33 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:2063 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129267AbRACXl1>; Wed, 3 Jan 2001 18:41:27 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: gcc2.96 + prerelease BUG at inode.c:372
Date: 3 Jan 2001 15:40:23 -0800
Organization: Transmeta Corporation
Message-ID: <930d97$83s$1@penguin.transmeta.com>
In-Reply-To: <200101031919.f03JJQU13197@interno.emmenet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200101031919.f03JJQU13197@interno.emmenet.it>,
Diego Liziero  <pmcq@interno.emmenet.it> wrote:
>
>->1: The sound module for my mad16 based card plays the bytes swapped
>     (the same module recompiled with egcs-2.91.66 works fine).

Could you try to figure this one out a bit more? This sounds like a real
compiler issue, whether it is because egcs just happens to get the right
result for bogus kernel source, of whether gcc-2.96 has problems..

>->2: after two day under heavy load I've got the following BUG:
>     (I don't know if it's related to the compiler, that's why I'm reporting
>     this.)

Unrelated. This one is a known bug that hits if you are a bit unlucky
with a race on deleting the pages from the inode page-lists. Fixed in
the current prerelease patches on ftp.kernel.org.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
