Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbRGPIto>; Mon, 16 Jul 2001 04:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267242AbRGPItf>; Mon, 16 Jul 2001 04:49:35 -0400
Received: from weta.f00f.org ([203.167.249.89]:16004 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267241AbRGPIt1>;
	Mon, 16 Jul 2001 04:49:27 -0400
Date: Mon, 16 Jul 2001 20:49:32 +1200
From: Chris Wedgwood <cw@f00f.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010716204932.E11938@weta.f00f.org>
In-Reply-To: <200107160108.f6G18fJ299454@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107160108.f6G18fJ299454@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2001 at 09:08:41PM -0400, Albert D. Cahalan wrote:

    In a tree-structured filesystem, checksums on everything would
    only cost you space similar to the number of pointers you
    have. Whenever a non-leaf node points to a child, it can hold a
    checksum for that child as well.

    This gives a very reliable way to spot filesystem errors,
    including corrupt data blocks.

Actually, this is a really nice concept... have additional checksums
and such floating about. When filesystems get to several terabytes, it
would allws background consistency checking (as checking on boot would
be far to slow).

It would also allow the fs layer to fsck the filesystem _as_ data was
accessed if need be, which would be the case more often.



  --cw

