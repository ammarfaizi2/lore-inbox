Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131813AbRAFPyH>; Sat, 6 Jan 2001 10:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131936AbRAFPx5>; Sat, 6 Jan 2001 10:53:57 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:26628
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S131813AbRAFPxu>; Sat, 6 Jan 2001 10:53:50 -0500
Date: Sun, 7 Jan 2001 04:53:46 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alexander Viro <viro@math.psu.edu>,
        Stefan Traby <stefan@hello-penguin.com>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
Message-ID: <20010107045346.B696@metastasis.f00f.org>
In-Reply-To: <Pine.GSO.4.21.0101060015540.25336-100000@weyl.math.psu.edu> <E14EvNX-0001Ac-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14EvNX-0001Ac-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Jan 06, 2001 at 03:35:32PM +0000
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 03:35:32PM +0000, Alan Cox wrote:

    BTW Al: We have another general vfs/fs problem to handle - which
    is exceeding max file sizes on limited file systems. Pretty much
    nobody is getting it right. Ext2 can be tricked to go past the
    limit, sys5 1k sits there emitting printk messages etc.

Which filesystems have limits other than 2^31 bytes?

I ask this because I was looking at LFS compliance and the way we
currently do things now isn't very smart. Only ext2 checks of
O_LARGEFILE at present (well, their is perhaps good reason for this
as it is one of the fre that supports multiGB files) whereas I think
this check should be done in the VFS.




  --cw

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
