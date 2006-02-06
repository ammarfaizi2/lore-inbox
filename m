Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWBFTWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWBFTWZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWBFTWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:22:25 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50924 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932304AbWBFTWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:22:22 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: [RFC][PATCH 0/20] Multiple instances of the process id namespace
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 12:19:30 -0700
Message-ID: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There have been several discussions in the past month about how
to do a good job of implementing a subset of user space that
looks like it has the system to itself.  Essentially making
chroot everything it could be.  This is my take on what
the implementation of a pid namespace should look like.


What follows is a real patch set that is sufficiently complete
to be used and useful in it's own right.  There are a few areas
of the kernel where the patchset does not reach, mostly these
cause the compile to fail.  In addition a good thorough review
still needs to be done.  This patchset does paint a picture
of how I think things should look.

>From the kernel community at large I am asking:
  Does the code look generally sane?

  Does the use of clone to create a new namespace instance look
  like the sane approach?


Hopefully this code is sufficiently comprehensible to allow a good
discussion to come out of this.

Thanks for your time,

Eric



p.s.  My apologies at the size of the CC list.  It is very hard to tell who
the interested parties are, and since there is no one list we all subscribe
to other than linux-kernel how to reach everyone in a timely manner.  I am
copying everyone who has chimed in on a previous thread on the subject.  If
you don't want to be copied in the future tell and I will take your name off
of my list.

