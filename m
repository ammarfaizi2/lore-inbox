Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278683AbRJ1Vme>; Sun, 28 Oct 2001 16:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278685AbRJ1VmY>; Sun, 28 Oct 2001 16:42:24 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:28601 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278683AbRJ1VmR>;
	Sun, 28 Oct 2001 16:42:17 -0500
Date: Sun, 28 Oct 2001 16:42:50 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: alain@linux.lu
cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10 
In-Reply-To: <200110282040.f9SKe6M02113@hitchhiker.org.lu>
Message-ID: <Pine.GSO.4.21.0110281628380.24880-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Oct 2001, Alain Knaff wrote:

> Appended to this mail is the "long live the struct block_device"
> patch. It includes the stuff covered in the last patch as well. The
> issue of stopping transfers in progress is not yet addressed.

Actually, both issues are not addressed.  With your patch bdev will
happily live after rmmod.  Please, wait a bit with that stuff.  I'll
post a variant tonight - still need to verify that it deals correctly
with cases like SCSI (disk going away without unregister_blkdev()).

