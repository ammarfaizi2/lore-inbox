Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315438AbSELWEd>; Sun, 12 May 2002 18:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSELWEc>; Sun, 12 May 2002 18:04:32 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:20986 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S315438AbSELWEb>; Sun, 12 May 2002 18:04:31 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15582.59104.448855.21882@wombat.chubb.wattle.id.au>
Date: Mon, 13 May 2002 08:04:16 +1000
To: Elladan <elladan@eskimo.com>
Cc: Jakob ?stergaard <jakob@unthought.net>,
        Kasper Dupont <kasperd@daimi.au.dk>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
In-Reply-To: <791836807@toto.iv>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "elladan" == elladan  <elladan@eskimo.com> writes:


elladan> It's perfectly legal for the shell to sit around with a file
elladan> open and pass it off to a child, even if the disk is full.

elladan> It's also perfectly legal for root to write to the fd, even
elladan> if the disk is full (for normal users).

elladan> It just happens that the suid program wasn't the one who
elladan> chose what file it was going to write stdout to - the shell
elladan> did.

This is why in SVr4, struct cred is cloned at open time, and passed
down to each VFS operation.

There's a choice of security modules here--- should the credentials
of the opener or the credentials of the writer determine the use of
the extra space?  I think in this case it ought to be the credentials
of the opener.  Also, I'm not sure that mount(8) should be a setuid
program. (I know it's convenient for floppy mounts, but I'd rather
they were handled by autofs)

Peter C
