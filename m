Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129308AbQKSXBH>; Sun, 19 Nov 2000 18:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbQKSXA6>; Sun, 19 Nov 2000 18:00:58 -0500
Received: from [210.149.136.62] ([210.149.136.62]:52609 "EHLO
	research.imasy.or.jp") by vger.kernel.org with ESMTP
	id <S129308AbQKSXAr>; Sun, 19 Nov 2000 18:00:47 -0500
Date: Mon, 20 Nov 2000 07:30:12 +0900
Message-Id: <200011192230.eAJMUC202514@research.imasy.or.jp>
From: Taisuke Yamada <tai@imasy.or.jp>
To: aeb@veritas.com
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org, tai@imasy.or.jp
Subject: Re: [PATCH] Large "clipped" IDE disk support for 2.4 when using old BIOS
In-Reply-To: Your message of "Sun, 19 Nov 2000 18:24:31 +0100".
    <20001119182431.A1226@veritas.com>
X-Mailer: mnews [version 1.22PL4] 2000-05/28(Sun)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > With this patch, you will be able to use disk capacity above
> > 32GB (or 2GB/8GB depending on how clipping take effect), and
> > still be able to boot off from the disk because you can leave
> > the "clipping" turned on.
> 
> I suppose you know that no kernel patch is required (since
> setmax.c does the same from user space). Did you try setmax?

I know of its existence, but thought patch solution is better
than userland solution and made one. Unless it is included in
the kernel, it's going to cause trouble on every system with
old BIOS. After all, disk geometry detection is what the kernel
should do, not userland program.

> to me it seems a bit too early to come with kernel patches.

But yes, you have the point here. This still needs more testing
to see if it works with every 32GB+ drive. By the way, how did
your drives behave? I have tested my code with IBM and Maxtor,
and both supported this READ NATIVE MAX - SET MAX combination
without any problem.

> I think I already sent you setmax.c, but in case my memory
> is confused let me include it here again. This is for 2.4.

Actually, this is the first time to have setmax.c, but I have
already made one myself to test my code. Your past discussion
was pretty much informative :-).

--
Taisuke Yamada <tai@imasy.or.jp>
PGP fingerprint = 6B 57 1B ED 65 4C 7D AE  57 1B 49 A7 F7 C8 23 46
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
