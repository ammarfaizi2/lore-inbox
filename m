Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130070AbQKQHKd>; Fri, 17 Nov 2000 02:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131793AbQKQHKX>; Fri, 17 Nov 2000 02:10:23 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:65291 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130070AbQKQHKL>; Fri, 17 Nov 2000 02:10:11 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux 2.2.18pre21
Date: 16 Nov 2000 22:40:00 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8v2js0$qpr$1@cesium.transmeta.com>
In-Reply-To: <E13u4XD-0001oe-00@the-village.bc.nu> <20001116171618.A25545@athlon.random> <20001116115249.A8115@wirex.com> <20001117003000.B2918@wire.cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001117003000.B2918@wire.cadcamlab.org>
By author:    Peter Samuelson <peter@cadcamlab.org>
In newsgroup: linux.dev.kernel
>
> 
> [jesse]
> > 1.  Your server closes all open directory file descriptors and chroots.
> > 2.  Someone manages to run some exploit code in your process space which--
> 
>   mkdir("foo")
>   chroot("foo")

BUG: you *MUST* chdir() into the chroot jail before it does you any
good at all!

I usually recommend:

mkdir("foo");
chdir("foo");
chroot(".");

> Bottom line: once you are in the chroot jail, you must drop root
> privileges, or you defeat the purpose.  Security-conscious coders know
> this; it's not Linux-specific behavior or anything.

Indeed.  They also know the above.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
