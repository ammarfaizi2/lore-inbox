Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130858AbQJaXhf>; Tue, 31 Oct 2000 18:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130872AbQJaXh0>; Tue, 31 Oct 2000 18:37:26 -0500
Received: from chiara.elte.hu ([157.181.150.200]:52231 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130858AbQJaXhW>;
	Tue, 31 Oct 2000 18:37:22 -0500
Date: Wed, 1 Nov 2000 01:47:20 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: Pavel Machek <pavel@suse.cz>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <39FF5332.7C862223@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0011010136000.18143-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 31 Oct 2000, Jeff V. Merkey wrote:

> Odd.  When I profile Linux with EMON, I see tons of them.  Anywhere code
> does
> 
> mov    eax, addr
> mov    [addr], ebx

AGIs were a real problem on P5 class Intel CPUs. On P6 core CPUs, most
forms of addresses (except memory writes) do not generate any AGIs. And
the AGI on P6 cores does not keep up the pipeline, unless you reuse the
same address. (which would be stupid in most cases) I bet Crusoe's have no
AGIs at all. Do you see the trend in CPU design?

	Ingo



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
