Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265860AbTL3XyN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 18:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265864AbTL3XyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 18:54:13 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:61963 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S265860AbTL3Xx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 18:53:29 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: RFC - Kernel Process Firewall
Date: Tue, 30 Dec 2003 23:49:58 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bst2v6$i93$1@abraham.cs.berkeley.edu>
References: <3FEA7D2C.7080303@cs.wisc.edu>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1072828198 18723 128.32.153.228 (30 Dec 2003 23:49:58 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Tue, 30 Dec 2003 23:49:58 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

raj wrote:
>I have been working on a project called "Kernel Process Firewall (KPF)" 
>that is nearing completion.  The goal of the project is to provide users 
>the ability to trace, monitor and control the system calls made by any 
>process.

Some comments:

1) There's a great deal of related and prior work in this area.
Take a look, for instance, at Janus, consh, MapBox, SubDomain, Ostia, ...
http://www.cs.berkeley.edu/~daw/janus/
2) There are some real problems with using system call interception
for this purpose.  There are TOCTTOU races, synchronization issues, ...
http://www.stanford.edu/~talg/papers/pubs.html
3) Have you looked at the LSM (Linux Security Modules) project?
It looks to me like this is what you want to be using, and it avoids
the problems with system call interposition.
http://lsm.immunix.org/
