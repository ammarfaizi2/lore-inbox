Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbTFLHRU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 03:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264776AbTFLHRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 03:17:20 -0400
Received: from pat.uio.no ([129.240.130.16]:63913 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264770AbTFLHRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 03:17:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16104.11307.369303.408983@charged.uio.no>
Date: Thu, 12 Jun 2003 00:30:51 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] First casuality of hlist poisoning in 2.5.70
In-Reply-To: <Pine.LNX.4.44.0306112206430.29133-100000@home.transmeta.com>
References: <16103.48257.400430.785367@charged.uio.no>
	<Pine.LNX.4.44.0306112206430.29133-100000@home.transmeta.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Note: As far as NFS is concerned, d_move() should always assume that
the dentry is unhashed. Even if we ensure that we rehash, someone else
could in theory trigger a call to d_revalidate() that causes the
dentry to be dropped before we get to d_move().

Cheers,
  Trond
