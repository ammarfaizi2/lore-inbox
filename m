Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbQLBSUs>; Sat, 2 Dec 2000 13:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbQLBSUi>; Sat, 2 Dec 2000 13:20:38 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:4070 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129511AbQLBSUb>;
	Sat, 2 Dec 2000 13:20:31 -0500
Date: Sat, 2 Dec 2000 12:50:02 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>,
        Jonathan Hudson <jonathan@daria.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <20001202173959.A10166@vana.vc.cvut.cz>
Message-ID: <Pine.GSO.4.21.0012021242570.28923-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Dec 2000, Petr Vandrovec wrote:

> Nothing new (was it meant to run remove_inode_queue() conditionaly inside 
> buffer_mapped() branch? ed did it that way). First is list of buffers at 
> time of destroy_inode, then process. If you want full oops trace, it is 

what list of buffers? ->i_dirty_buffers one?

> available at http://platan.vc.cvut.cz/oops3.txt, but last part is always 
> iput. For now I'm back on test9, as I lost inetd.conf again :-( Someone 
> should shoot sendmail Debian maintainer... Running update-inetd at startup 
> is really bad idea, as fsck then usually removes both old and new inetd.conf, 
> so I'm back on inetd.conf from 25 Aug 1999 :-(((
> 
> Fields printed from buffer_head are b_next, b_blocknr, b_size, b_list,
> b_count, b_state and b_inode. (oops now I see that I left
> remove_inode_queue(bh) in printing loop (I copied it from
> invalidate_inode_buffers()), but it should not hurt, I believe. Dirty buffers
> should find its way to disk anyway, or not?)

When you delete the inode? Why would they? Petr, could you send me the
diff between the variant you've run and pristine 12-pre3? I'ld really
like to see what exactly was doing the printks...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
