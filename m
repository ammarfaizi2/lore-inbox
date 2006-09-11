Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbWIKVT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWIKVT4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbWIKVT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:19:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41926 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965053AbWIKVTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:19:54 -0400
Subject: Re: 2.6.18-rc6-mm1
From: Mark Haverkamp <markh@osdl.org>
To: Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060908011317.6cb0495a.akpm@osdl.org>
References: <20060908011317.6cb0495a.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 14:19:52 -0700
Message-Id: <1158009592.10005.24.camel@markh3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-08 at 01:13 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/
> 

compiling a kernel with allnoconfig produces the following error:

  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CHK     include/linux/compile.h
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
mm/built-in.o: In function `writeback_congestion_end':
(.text+0x5d3b): undefined reference to `blk_congestion_end'
make: *** [.tmp_vmlinux1] Error 1

The problem is that the block layer isn't configured and this is where
the blk_congestion_end symbol comes from.

This comes from the git-nfs.patch.


-- 
Mark Haverkamp <markh@osdl.org>

