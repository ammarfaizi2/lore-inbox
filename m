Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbQLRNxm>; Mon, 18 Dec 2000 08:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130371AbQLRNxd>; Mon, 18 Dec 2000 08:53:33 -0500
Received: from 62-6-231-82.btconnect.com ([62.6.231.82]:44292 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129562AbQLRNxS>;
	Mon, 18 Dec 2000 08:53:18 -0500
Date: Mon, 18 Dec 2000 13:24:53 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Peter Samuelson <peter@cadcamlab.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test13-pre3] rootfs boot param. support
In-Reply-To: <20001218064513.G3199@cadcamlab.org>
Message-ID: <Pine.LNX.4.21.0012181323410.840-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2000, Peter Samuelson wrote:

> 
> [Tigran Aivazian]
> > +/* this can be set at boot time, e.g. rootfs=ext2 
> > + * if set to invalid value or if read_super() fails on the specified
> > + * filesystem type then mount_root() will go through all registered filesystems.
> > + */
> > +static char rootfs[128] __initdata = "ext2";
> 
> Better that we not hard-code anything here.  If we want ext2 to be
> tried first, we should link it first, which we already do.
> 

no, because it would cause a "spurious" call to get_fs_type("") which we
don't want to happen (by default i.e. -- if user _really_ wants it
that is ok). The default of "ext2" is fine.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
