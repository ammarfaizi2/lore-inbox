Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbTENALS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 20:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbTENALS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 20:11:18 -0400
Received: from pat.uio.no ([129.240.130.16]:44764 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263732AbTENALR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 20:11:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16065.35997.348432.385925@charged.uio.no>
Date: Wed, 14 May 2003 02:23:57 +0200
To: akpm@digeo.com, tytso@mit.edu
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] htree nfs fix
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Get the facts right please: That rant was bullshit.

  NFS tries as hard as it can to interpret the cookie as a bag of
bits. It gets screwed in this by a VFS interface which treats the
32-bit getdents() as having unsigned 32-bit cookies, and the 64-bit
getdents64() as having signed 64-bit cookies.

To make matters worse, glibc comes along and assumes it can use
getdents64 as a substitute for getdents() without having to give any
thought to the problem of cookies.


If you're unhappy with the state of readdir, then fix the VFS/glibc.
At the moment it is simply not possible to write a consistent readdir
at the NFS level.

Trond
