Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268022AbRG3VOr>; Mon, 30 Jul 2001 17:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268025AbRG3VO2>; Mon, 30 Jul 2001 17:14:28 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:64773 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S268001AbRG3VOU>; Mon, 30 Jul 2001 17:14:20 -0400
Date: Mon, 30 Jul 2001 14:14:27 -0700
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] initramfs patch
Message-ID: <20010730141427.E20284@bluemug.com>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0107301646050.19391-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0107301646050.19391-100000@weyl.math.psu.edu>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 30, 2001 at 04:49:15PM -0400, Alexander Viro wrote:
> 
> On Mon, 30 Jul 2001, Mike Touloumtzis wrote:
> 
> > One thing that would make embedded systems developers very happy
> > is the ability to map a romfs or cramfs filesystem directly from
> > the kernel image, avoiding the extra copy necessitated by the cpio
> > archive.  Are there problems with this approach?
> 
> a) IIRC, both are read-only.

Hmmm, maybe we need ramfs-backed-by-romfs :-).  But a lot of people
in the embedded/consumer electronics space could get by just fine
with a read-only / and a ramfs or ramdisk on /tmp.

> b) what stops you from doing initramfs + romfs-on-initrd? It works.

-- Having the FS image compiled into the kernel allows a linker script
   to specify the alignment requirements for the FS.

-- initrd is a yucky special case.  What I'm advocating is just a
   standard way of addressing compiled-in filesystems using the normal
   /dev namespace.

miket
