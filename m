Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289049AbSANU4D>; Mon, 14 Jan 2002 15:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289046AbSANUzp>; Mon, 14 Jan 2002 15:55:45 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:60060 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S289025AbSANUz3>;
	Mon, 14 Jan 2002 15:55:29 -0500
Date: Mon, 14 Jan 2002 15:55:27 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: David Lang <david.lang@digitalinsight.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, babydr@baby-dragons.com,
        linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <3C43445D.24D5415F@nortelnetworks.com>
Message-ID: <Pine.GSO.4.21.0201141546490.224-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jan 2002, Chris Friesen wrote:

> I haven't been following the initramfs stuff, but now I have a question. 
> Currently we're using initrd to store a kernel and compressed ramdisk bundled
> together as an ~7MB single file that gets netbooted by firmware in a card.  Will
> it be possible to bundle initramfs together with the kernel into a single file
> in this same manner?

<shrug> kernel unpacks to rootfs after init_vfs_caches().  It does
	populate_root(archive_start, archive_size);
followed by releasing that area.  That's it.  If you have these variables
set - it will work, no matter how did the archive get there.


