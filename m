Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131487AbQKQKxg>; Fri, 17 Nov 2000 05:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131881AbQKQKxZ>; Fri, 17 Nov 2000 05:53:25 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:35235 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131487AbQKQKxV>; Fri, 17 Nov 2000 05:53:21 -0500
Message-Id: <5.0.2.1.2.20001117102102.00af3a30@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Fri, 17 Nov 2000 10:23:46 +0000
To: Alexander Viro <viro@math.psu.edu>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.4.0-test11-pre6 ntfs compile error
Cc: Frank Davis <fdavis112@juno.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <Pine.GSO.4.21.0011170037010.14822-100000@weyl.math.psu.edu
 >
In-Reply-To: <384606296.974438172647.JavaMail.root@web395-wra.mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:38 17/11/2000, Alexander Viro wrote:
>On Fri, 17 Nov 2000, Frank Davis wrote:
> > Hello,
> >   I just try to compile 2.4.0-test11-pre6, and received the following 
> error (make modules):
> >
> > inode.c:1054 conflicting types for 'new_inode'
> > /usr/src/liunux/include/linux/fs.h:1153 previous declaration of 'new_inode'
>
>My fault. Hell knows how that part of patch didn't get into the posting
>(damnit, it was described there)...
>
>Fix:
>
>ed fs/ntfs/inode.c <<EOF
>%s/new_inode/ntfs_&/g
>w
>q
>EOF

Not fix enough, I am afraid. You are forgetting fs/ntfs/fs.c. - See the 
patch I just posted.

Anton


-- 
      "Education is what remains after one has forgotten everything he 
learned in school." - Albert Einstein
-- 
Anton Altaparmakov  Voice: +44-(0)1223-333541(lab) / +44-(0)7712-632205(mobile)
Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
Cambridge CB2 3BU    ICQ: 8561279
United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
