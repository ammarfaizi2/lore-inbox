Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbTFBVfa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 17:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264069AbTFBVfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 17:35:30 -0400
Received: from pat.uio.no ([129.240.130.16]:13227 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264067AbTFBVf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 17:35:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16091.50722.851659.821544@charged.uio.no>
Date: Mon, 2 Jun 2003 23:48:18 +0200
To: Ion Badulescu <ionut@badula.org>
Cc: "Vivek Goyal" <vivek.goyal@wipro.com>, <indou.takao@jp.fujitsu.com>,
       <ezk@cs.sunysb.edu>, <viro@math.psu.edu>, <davem@redhat.com>,
       <nfs@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] Disabling Symbolic Link Content Caching in NFS Client
In-Reply-To: <200306022037.h52KbNVh012849@buggy.badula.org>
References: <2BB7146B38D9CA40B215AB3DAAE24C080BA4F3@blr-m2-msg.wipro.com>
	<200306022037.h52KbNVh012849@buggy.badula.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Ion Badulescu <ionut@badula.org> writes:

    >> 1. Make nfs_symlink_caching dynamically tunable using /proc and
    >> sysctl interface.

     > No. Do it on a per-mount basis, like the other OS's do.

As I said to Vivek in a private mail, it would be very nice to see
if this could be done by replacing hlfsd with namespace groups.

Al Viro has already done all the VFS layer work, which should be ready
and working in existing 2.4.20 and 2.5.x kernels. What is missing is
userland support for doing a CLONE_NEWNS, and then mounting the user's
home directory, mailspool,.... in the appropriate locations at login
time.

Cheers,
  Trond
