Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129901AbQLEISM>; Tue, 5 Dec 2000 03:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130159AbQLEISC>; Tue, 5 Dec 2000 03:18:02 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:51958 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129901AbQLEIRz>; Tue, 5 Dec 2000 03:17:55 -0500
Message-ID: <3A2C9E74.A7B2407@uow.edu.au>
Date: Tue, 05 Dec 2000 18:51:16 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, Alan Cox <alan@redhat.com>,
        Christoph Rohland <cr@sap.com>, Rik van Riel <riel@conectiva.com.br>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: test12-pre5
In-Reply-To: <Pine.LNX.4.10.10012041906510.2047-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Ok, this contains one of the fixes for the dirty inode buffer list (the
> other fix is pending, simply because I still want to understand why it
> would be needed at all). Al?

I've run the same test suite against vanilla test12-pre5 on two machines for
five hours. On ext2/IDE/SMP+UP it's solid.

I'll test Al's latest bforget_inode patch overnight, but that's already
been through the wringer once.

> Also, it has the final installment of the PageDirty handling, and now
> officially direct IO can work by just marking the physical page dirty and
> be done with it. NFS along with all filesystems have been converted, the
> one hold-out still being smbfs.
> 
> Who works on smbfs these days? I see two ways of fixing smbfs now that
> "writepage()" only gets an anonymous page and no "struct file" information
> any more (this also fixes the double page unlock that Andrew saw).
                                                        ^^^^^^
                                                        Mike Galbraith.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
