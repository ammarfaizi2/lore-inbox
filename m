Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129605AbQJ2Rb5>; Sun, 29 Oct 2000 12:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130356AbQJ2Rbr>; Sun, 29 Oct 2000 12:31:47 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:44439 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129605AbQJ2Rbf>;
	Sun, 29 Oct 2000 12:31:35 -0500
Date: Sun, 29 Oct 2000 12:31:33 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: davej@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops in block_read_full_page() in test10-pre6
In-Reply-To: <39FC5D78.E872F18A@haque.net>
Message-ID: <Pine.GSO.4.21.0010291229240.27484-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Oct 2000, Mohammad A. Haque wrote:

> I JUST got the same oops. But daylight savings happened 9 or so hours
> ago here.

Known problem, fix being tested. Basically, it's the same as mmap/truncate
races, with do_generic_file_read() in place of filemap_nopage(). I wonder
what made it visible only now - it's actually pretty old.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
