Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129177AbQKLQds>; Sun, 12 Nov 2000 11:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQKLQdi>; Sun, 12 Nov 2000 11:33:38 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:65394 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129177AbQKLQdZ>; Sun, 12 Nov 2000 11:33:25 -0500
Date: Sun, 12 Nov 2000 17:33:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Tigran Aivazian <tigran@veritas.com>,
        "H. Peter Anvin" <hpa@transmeta.com>, Max Inux <maxinux@bigfoot.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Message-ID: <20001112173324.G4933@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0011111644110.1036-100000@saturn.homenet> <m1ofzmcne5.fsf@frodo.biederman.org> <20001112122910.A2366@athlon.random> <m1k8a9badf.fsf@frodo.biederman.org> <20001112163705.A4933@athlon.random> <20001112164417.A10464@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001112164417.A10464@gruyere.muc.suse.de>; from ak@suse.de on Sun, Nov 12, 2000 at 04:44:17PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2000 at 04:44:17PM +0100, Andi Kleen wrote:
> The current simulator seems to be buggy in that it checks the SS,DS segments
>that were pushed as part of the interrupt stack on iretd [..]

That's the first thing I thought too indeed 8), but it maybe because at
iret time the CPU doesn't know if it will have to return to compatibility mode
or not. If we feed the ss/ds with a 32bit compatibility mode data segment all
should work right as well (this should be verified on the simulator though).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
