Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317100AbSEXGNk>; Fri, 24 May 2002 02:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317097AbSEXGNj>; Fri, 24 May 2002 02:13:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45800 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317096AbSEXGNi>;
	Fri, 24 May 2002 02:13:38 -0400
Date: Thu, 23 May 2002 22:57:10 -0700 (PDT)
Message-Id: <20020523.225710.127930704.davem@redhat.com>
To: katta@csee.wvu.edu
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Reg. asm-sparc64/processor.h
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1022196275.2591.4.camel@indus>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Shanti Katta <katta@csee.wvu.edu>
   Date: 23 May 2002 19:24:35 -0400

   On Wed, 2002-05-22 at 23:52, David S. Miller wrote:
   > 
   > If you want the 'u64' type, define __KERNEL__.  That is what
   > every platform does, protect the types without underscores with
   > a __KERNEL__ ifdef.

   In asm-sparc64/processor.h (2.4.18), in thread_struct structure, there
   are 3 fields:
           u64 *user_cntd0, *user_cntd1;
           u64 kernel_cntd0, kernel_cntd1;
           u64 pcr_reg; 
   
   which are defined without #ifdef __KERNEL__ . I guess, this is a bug,
   which needs fixing.

You shouldn't be including such kernel headers from userspace.
