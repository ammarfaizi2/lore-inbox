Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267256AbTBXQ7a>; Mon, 24 Feb 2003 11:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbTBXQ7a>; Mon, 24 Feb 2003 11:59:30 -0500
Received: from mons.uio.no ([129.240.130.14]:9449 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267256AbTBXQ73>;
	Mon, 24 Feb 2003 11:59:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15962.20933.457919.169668@charged.uio.no>
Date: Mon, 24 Feb 2003 18:09:25 +0100
To: maneesh@in.ibm.com
Cc: Janet Morgan <janetmor@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.62 Oops during nfs mount
In-Reply-To: <20030224123622.GB1103@in.ibm.com>
References: <3E56E58D.6B047A23@us.ibm.com>
	<20030224123622.GB1103@in.ibm.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Maneesh Soni <maneesh@in.ibm.com> writes:

     > Hi Janet,

     > Following patch should fix this problem. I think Trond can say
     > whether it is correct or not. In my opinion rpc_rmdir should
     > test for negative dentry after lookup_hash() returns, like
     > rpc_unlink() does.

No. You are 'fixing' a symptom of a more fundamental
bug/misunderstanding: lookup_path("") returns no error, and is
sometimes causing us to remove the top level directory.
See the 2-line patch I posted yesterday. It should fix the Oops you
are reporting.

Cheers,
  Trond
