Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267805AbRG3Ua1>; Mon, 30 Jul 2001 16:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267806AbRG3UaR>; Mon, 30 Jul 2001 16:30:17 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:51205 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S267790AbRG3UaJ>; Mon, 30 Jul 2001 16:30:09 -0400
Date: Mon, 30 Jul 2001 13:29:57 -0700
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] initramfs patch
Message-ID: <20010730132957.A20284@bluemug.com>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0107300137550.16140-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0107300137550.16140-100000@weyl.math.psu.edu>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 30, 2001 at 02:05:55AM -0400, Alexander Viro wrote:
> 
> The thing unpacks cpio archive (currently - linked into the kernel image)
> on root ramfs and execs /init. After that we are in userland code. Said
> code (source in init/init.c and init/nfsroot.c) emulates the vanilla
> 2.4 behaviour. You can replace it with your own - that's just the default
> that gives (OK, is supposed to give) a backwards-compatible behaviour.

One thing that would make embedded systems developers very happy
is the ability to map a romfs or cramfs filesystem directly from
the kernel image, avoiding the extra copy necessitated by the cpio
archive.  Are there problems with this approach?

miket
