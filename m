Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTFBVq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 17:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTFBVq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 17:46:59 -0400
Received: from pat.uio.no ([129.240.130.16]:41391 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264186AbTFBVq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 17:46:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16091.51200.292233.374385@charged.uio.no>
Date: Mon, 2 Jun 2003 23:56:16 +0200
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

     > Replacing a couple of time_after() calls with time_after_eq()
     > calls fixes the issue, at least for hlfsd.

BTW: the above does not suffice to eliminate all races. Two processes
owned by different users may still end up waiting on the same call to
nfs_symlink_filler() no matter how often you choose to update the
metadata.

Cheers,
 Trond
