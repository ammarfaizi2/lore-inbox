Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262689AbSJRUZw>; Fri, 18 Oct 2002 16:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265200AbSJRUZw>; Fri, 18 Oct 2002 16:25:52 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:38926 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S262689AbSJRUZv>; Fri, 18 Oct 2002 16:25:51 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: can chroot be made safe for non-root?
Date: 18 Oct 2002 20:14:17 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <aopq2p$9pm$2@abraham.cs.berkeley.edu>
References: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net> <20021018190101.GE237@elf.ucw.cz>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1034972057 10038 128.32.153.211 (18 Oct 2002 20:14:17 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 18 Oct 2002 20:14:17 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek  wrote:
>> I am eager to be able to sandbox my processes on a system without the
>> help of suid-root programs (as I prefer to have none of these on my
>> system).
>
>You can do that using ptrace. subterfugue.sf.net.

ptrace() is ok, but it also has lots of disadvantages: performance,
expressiveness, security, assurance.  I've posted before on this mailing
list, at length, about them.  In short, ptrace() is not an ideal solution,
and a secure chroot() or other way to construct a jail/sandbox would
be better.  (LSM will be much better.)
