Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbTENJT7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 05:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbTENJT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 05:19:59 -0400
Received: from pat.uio.no ([129.240.130.16]:28905 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261365AbTENJT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 05:19:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16066.3376.21917.112570@charged.uio.no>
Date: Wed, 14 May 2003 11:32:32 +0200
To: Andrew Morton <akpm@digeo.com>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] htree nfs fix
In-Reply-To: <20030514021229.35e74ccd.akpm@digeo.com>
References: <16065.35997.348432.385925@charged.uio.no>
	<20030513174425.2bc49803.akpm@digeo.com>
	<16066.1778.401988.753875@charged.uio.no>
	<20030514021229.35e74ccd.akpm@digeo.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@digeo.com> writes:

    >> Either we have to agree that we break legacy 32-bit getdents()
    >> and treat all cookies as signed 32/64-bit, or we break
    >> getdents64(), and treat all cookies as unsigned. (This applies
    >> to both 2.5.x and 2.4.x)
    >>

     > Or we do nothing.

     > What would you recommend?

I frankly don't care. I consider the current situation to be a direct
result of glibc's abuse of getdents64() starting in glibc-2.2. If they
had used 32-bit interfaces for the 32-bit readdir() they way they did
in glibc-2.1 then there would be no 'NFS problem' for people to bitch
about.

Cheers,
  Trond
