Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261421AbSJPV0T>; Wed, 16 Oct 2002 17:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbSJPV0T>; Wed, 16 Oct 2002 17:26:19 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:15633 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S261421AbSJPV0S>; Wed, 16 Oct 2002 17:26:18 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: can chroot be made safe for non-root?
Date: 16 Oct 2002 21:14:43 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <aokks3$955$1@abraham.cs.berkeley.edu>
References: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1034802883 9381 128.32.153.211 (16 Oct 2002 21:14:43 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 16 Oct 2002 21:14:43 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Buddington  wrote:
>Would it be reasonable to allow non-root processes to chroot(), if the
>chroot syscall also changed the cwd for non-root processes?

It might be reasonable.  It is a little bit tricky, as if you're not
careful, this can open up security holes.  However, one course project
in a class I taught two years ago proposed a way to safely allow non-root
processes to use chroot().  Look here:
  http://www.cs.berkeley.edu/~smcpeak/cs261/index.html

You might also be interested in the LSM project; in sandboxes like
SubDomain, Janus, SELinux, systrace, and the like; in privilege separation;
in OpenBSD's jail(); and similar topics.

>(who wishes there were better ways to run untrusted code)

Me, too.
