Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131016AbQKLXDg>; Sun, 12 Nov 2000 18:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbQKLXD1>; Sun, 12 Nov 2000 18:03:27 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:23314 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131142AbQKLXDS>; Sun, 12 Nov 2000 18:03:18 -0500
Date: Mon, 13 Nov 2000 00:03:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Tigran Aivazian <tigran@veritas.com>,
        "H. Peter Anvin" <hpa@transmeta.com>, Max Inux <maxinux@bigfoot.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Message-ID: <20001113000312.E11857@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0011111644110.1036-100000@saturn.homenet> <m1ofzmcne5.fsf@frodo.biederman.org> <20001112122910.A2366@athlon.random> <m1k8a9badf.fsf@frodo.biederman.org> <20001112163705.A4933@athlon.random> <m17l69atfw.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17l69atfw.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Nov 12, 2000 at 12:20:19PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2000 at 12:20:19PM -0700, Eric W. Biederman wrote:
> Actually it just occurred to me that this stack assess is buggy.  You haven't
> set up a stack yet so. [..]

Yes, ss and esp are inherit from the decompression code right now.

> [..]  Only the boot/compressed/head.S did and that location
> isn't safe to use.

It's 0x90000 here and that's safe. However I see it should been something like
0x1037a0 instead and it would overwrite 4 bytes of decompressed image, not
sure why it happens to be safe right now hmm.

About ss I'd still depend on the decompression code to give back the sane
segmented environment.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
