Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130779AbQKZVSf>; Sun, 26 Nov 2000 16:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131604AbQKZVSP>; Sun, 26 Nov 2000 16:18:15 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:60428 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S130779AbQKZVSF>; Sun, 26 Nov 2000 16:18:05 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] removal of "static foo = 0"
Date: 26 Nov 2000 12:47:53 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8vrstp$o7d$1@cesium.transmeta.com>
In-Reply-To: <14880.29022.261932.284497@somanetworks.com> <E13ztNR-0001ew-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E13ztNR-0001ew-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
> 
> That isnt what Andries is arguing about. Read harder. Its semantic differences
> rather than code differences.
> 
> 	static int a=0;
> 
> says 'I thought about this. I want it to start at zero. I've written it this
> way to remind of the fact'
> 
> Sure it generates the same code
> 

The problem is that it doesn't.  One could argue this is a gcc bug or
rather missed optimization.

One can, of course, also write:

    static int a /* = 0 */;

... to make it clear to human programmers without making gcc make bad
code.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
