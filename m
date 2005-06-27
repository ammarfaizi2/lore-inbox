Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVF0Ttz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVF0Ttz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVF0TsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:48:01 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:45465 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261328AbVF0Tqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:46:38 -0400
Message-ID: <42C0578F.7030608@namesys.com>
Date: Mon, 27 Jun 2005 12:46:23 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Markus T?rnqvist <mjt@nysv.org>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>, Steve Lord <lord@xfs.org>
Subject: Re: reiser4 plugins
References: <42BB7B32.4010100@slaphack.com> <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl> <20050627092138.GD11013@nysv.org> <20050627124255.GB6280@thunk.org>
In-Reply-To: <20050627124255.GB6280@thunk.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve, there is a remark about XFS below which you are going to be more
expert on.

Theodore Ts'o wrote:

>Most Linux users are using PC-class hardware.  And Ted's First Law of
>PC-Class Hardware is: "Most of it is crap".  And then there's Ted's
>Second Law, "Too many system administrators don't do backups".  This
>is because most system admins are users who've never been trained to
>be a sysadmin, or who haven't (yet) had weeks or months of works
>disappear after a hardware failure.  
>  
>
The above I agree with.  Your words below though are irresponsible.

I get users who tell me that ext* is crap and fsck.ext2 corrupted their
filesystem and thats why they use ReiserFS.  A difference between us is
that I tell them that with all the major linux filesystems (I include
XFS and JFS in this)  it is by this time far more likely to be hardware
that caused corruption than the filesystem software, whereas I guess you
tell them something else.

Describing us as trashing data at the slightest sign of trouble is
irresponsible.  We do block journaling not logical journaling, but there
is absolutely nothing inherently wrong with logical journaling, and no
reason why it could not be just as robust if that is what XFS uses, so I
suspect the rest of your remarks about XFS are unlikely to be sound.

I would say much more, but I am trying to avoid flames this week.

Ted, please try to consider that maybe your competitors also do a fairly
good job at the mundane but important aspects of filesystem work, and
lets all avoid FUDing each others work.  Both ext* and XFS are excellent
filesystems, and Linux is lucky to have 3 of the 4 best filesystems
available for it.

It will be interesting to see though whether Dominic Giampaolo beats all
three of us in the next five years.  He probably won't have the
performance, but he sure might have the semantic features, and he is
very bright.  If MS ever makes good use of the talent they have been
hiring, we'll have a hard time there also.  We may get lucky on that
though.....;-)

>So it's a matter of matching the filesystem to the needs of the user.
>If you have a filesystem which is blazingly fast, but which at the
>slightest sign of trouble, trashes your data, versus one which is fast
>but perhaps not-so-fast as the other filesystem, but which is much
>more reliable, which would you choose?  
>
>XFS has similar issues where it assumes that hardware has powerfail
>interrupts, and that the OS can use said powerfail interrupt to stop
>DMA's in its tracks on an power failure, so that you don't have
>garbage written to key filesystem data structures when the memory
>starts suffering from the dropping voltage on the power bus faster
>than the DMA engine or the disk drives.  So XFS is a great filesystem
>--- but you'd better be running it on a UPS, or on a system which has
>power fail interrupts and an OS that knows what to do.  Ext3, because
>it does physical block journalling, does not suffer from this problem.
>(Yes, Resierfs uses logical journalling as well, so it suffers from
>the same problem.)
>
>So perhaps it's not the job of the FS vendor to be responsible for
>crap hardware or lazy sysadmins that don't do backups.  But a system
>administrator who knows that he doesn't do backups frequently enough,
>or is running on cheap, crap hardware, would be wise to consider
>carefully which filesystem he/she wants to use given the systems
>configuration and his backup habits.  
>
>Me, I'll go for the robust filesystem, just on general principles.  As
>a friend from the large-scale enterprise storage world once put it,
>"Performance is Job 2.  Robustness is Job #1."  (Of course, if you
>want to put your fragile filesystem on a multi-million dollar
>enterprise storage system such as an IBM Shark or an EMC Symmetrix
>box, I'm sure IBM or EMC will be happy to sell you one.  :-)
>
>							- Ted
>
>
>  
>

