Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130070AbQKQGJM>; Fri, 17 Nov 2000 01:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131757AbQKQGJC>; Fri, 17 Nov 2000 01:09:02 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:22680 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130070AbQKQGIz>;
	Fri, 17 Nov 2000 01:08:55 -0500
Date: Fri, 17 Nov 2000 00:38:53 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Frank Davis <fdavis112@juno.com>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.4.0-test11-pre6 ntfs compile error
In-Reply-To: <384606296.974438172647.JavaMail.root@web395-wra.mail.com>
Message-ID: <Pine.GSO.4.21.0011170037010.14822-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Nov 2000, Frank Davis wrote:

> Hello,
>   I just try to compile 2.4.0-test11-pre6, and received the following error (make modules):
> 
> inode.c:1054 conflicting types for 'new_inode'
> /usr/src/liunux/include/linux/fs.h:1153 previous declaration of 'new_inode'

My fault. Hell knows how that part of patch didn't get into the posting
(damnit, it was described there)...

Fix:

ed fs/ntfs/inode.c <<EOF
%s/new_inode/ntfs_&/g
w
q
EOF

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
