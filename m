Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129060AbQJ3JlJ>; Mon, 30 Oct 2000 04:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129083AbQJ3JlA>; Mon, 30 Oct 2000 04:41:00 -0500
Received: from chiara.elte.hu ([157.181.150.200]:46854 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129060AbQJ3Jkn>;
	Mon, 30 Oct 2000 04:40:43 -0500
Date: Mon, 30 Oct 2000 11:50:24 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030022024.B20023@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.21.0010301144430.3186-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2000, Jeff V. Merkey wrote:

> ds: and es: are both used in copy-to-user and copy-from-user and they
> get reloaded.

And they all share the same segment descriptor. Whats your point? ES is
the default target segment for string operations. DS is the default data
segment. Have you ever profiled how many cycles it takes to do a "mov
__KERNEL_DS, %es" in entry.S, before making your (ridiculous) claim? I
have.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
