Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKXC7v>; Thu, 23 Nov 2000 21:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130854AbQKXC7m>; Thu, 23 Nov 2000 21:59:42 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:1297 "HELO
        note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
        id <S129153AbQKXC7a>; Thu, 23 Nov 2000 21:59:30 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alexander Viro <viro@math.psu.edu>
Date: Fri, 24 Nov 2000 13:29:13 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14877.53881.182935.597766@notabene.cse.unsw.edu.au>
Cc: "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tigran Aivazian <tigran@veritas.com>
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: message from Alexander Viro on Thursday November 23
In-Reply-To: <Pine.GSO.4.21.0011231134250.10872-100000@weyl.math.psu.edu>
        <Pine.GSO.4.21.0011231205550.11219-100000@weyl.math.psu.edu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
        LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
        8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 23, viro@math.psu.edu wrote:
> 
> 
> On Thu, 23 Nov 2000, Alexander Viro wrote:
> 
> > On Thu, 23 Nov 2000, Neil Brown wrote:
> > 
> > > which enabled ext2_notify_change, however ext2_notify_change has a
> > > bug.
> > > It sets attributes from iattr->ia_attr_flags even
> > > if ATTR_ATTR_FLAG is NOT SET in iattr->ia_valid.
> > 
> > Arrrgh. Could you try that:
> 
> OK, I really need more coffee - wrong patch. My apologies. Correct (OK,
> intended) one follows:

Hmmm. either you need more coffee, or I need a new compiler.
I'm using 2.95.2, and there seems to be some question marks over that.

Unfortunately debian/potato doesn't seem to offer anything else
(Except 2.7.2), so I'll try to download and compile egcs-1.1.2 and see
how that works.

I ran my test script, which builds a variety of raid5 arrays with
varying numbers of drives and chunk sizes, and runs mkfs/bonnie/dbench
on each array, and it got through about 8 file systems but choked on
the 9th by trying to allocate lots of blocks in the system zone (after
running for about an hour). 

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
