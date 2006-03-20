Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030568AbWCTW3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030568AbWCTW3X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030562AbWCTW3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:29:22 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:11705 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1030558AbWCTW3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:29:20 -0500
Date: Mon, 20 Mar 2006 17:28:39 -0500
Message-Id: <200603202228.k2KMSdGD012961@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: "Xin Zhao" <uszhaoxin@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, "Al Viro" <viro@ftp.linux.org.uk>,
       mingz@ele.uri.edu, mikado4vn@gmail.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: Question regarding to store file system metadata in database 
In-reply-to: Your message of "Mon, 20 Mar 2006 14:36:51 EST."
             <4ae3c140603201136q7e61963dy635bb2c6047f0bc2@mail.gmail.com> 
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You may be interested in a project we have which ported a subset of the
Berkeley Database (BDB) to the Linux kernel.  BDB is much smaller than other
SQL-based DBMSs, and is thus a lot more suitable for embedding into kernels.

We called our port KBDB.  We built a simple transactional f/s on top of it,
called kbdbfs.  We also had a short project called EAFS, which is a
stackable f/s that adds EA/ACL support to any f/s it's layered on top of.

Recently we also implemented a full-blown transactional f/s using ptrace
methods.  You can find links to these projects, and in some cases papers and
software:

http://www.fsl.cs.sunysb.edu/project-kbdb.html
http://www.fsl.cs.sunysb.edu/project-amino.html
http://www.fsl.cs.sunysb.edu/project-goanna.html
http://www.fsl.cs.sunysb.edu/project-extattrfs.html

Erez.
