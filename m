Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313596AbSD3PCv>; Tue, 30 Apr 2002 11:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSD3PCu>; Tue, 30 Apr 2002 11:02:50 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:3258 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S313596AbSD3PCt>; Tue, 30 Apr 2002 11:02:49 -0400
Date: Tue, 30 Apr 2002 15:22:12 +0100
From: =?ISO-8859-1?Q?Jos=E9?= Fonseca <j_r_fonseca@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Subject: How to write portable MMIO code?
Message-ID: <20020430142212.GR18163@localhost>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel developers,

I'm currently trying to get the Mach64 DRI driver to run on PowerPC. It's 
mostly working but there are some strange behaviors (DMA works, MMIO not 
really unless you make long waits when submiting, etc.). This is most 
likely related with the MMIO programming macros in the kernel module.

My question is: How to code MMIO to be portable across all platforms, 
i.e., taking in consideration the endian format and memory caches?

I've search thorougly the answer to this question but found 
incomplete/contraditory answers:

  - should one use readl/writel or dereference the address directly?
  - is the use of readl/writel macros suficient to account for endian 
correctness or it's also needed to use the cpu_to_le32/le32_to_cpu macros?
  - should one in general (i.e., assuming the worst case) do wmb() on 
writes, and mb() on reads?

Although I appreciate answers concerning future developments on this 
matter, I need an answer to the current stable kernel release.


Regards,

José Fonseca


PS: Please CC me as I'm not subscribed.
