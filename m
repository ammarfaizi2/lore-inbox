Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131086AbRAHRtx>; Mon, 8 Jan 2001 12:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131483AbRAHRtn>; Mon, 8 Jan 2001 12:49:43 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24326 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131086AbRAHRtc>; Mon, 8 Jan 2001 12:49:32 -0500
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
To: viro@math.psu.edu (Alexander Viro)
Date: Mon, 8 Jan 2001 17:50:28 +0000 (GMT)
Cc: mason@suse.com (Chris Mason), alan@redhat.com (Alan Cox),
        stefan@hello-penguin.com (Stefan Traby), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0101081153150.4061-100000@weyl.math.psu.edu> from "Alexander Viro" at Jan 08, 2001 12:35:17 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FgRD-00050e-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         if (pos + count > inode->i_sb->s_maxbytes)
>         {
>                 count = inode->i_sb->s_maxbytes - count;
>                 goto out;
>         }
>  
> looks funny - goto out means that new (and rather meaningless) value of
> count goes to hell. Shouldn't we remove that line and s/- count/- pos/

I already fixed that in my tree. We also send signals in a couple of spots
we shouldnt tht I fixed


Alan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
