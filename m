Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262751AbVDHLqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbVDHLqr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 07:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbVDHLqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 07:46:47 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:25013 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262751AbVDHLqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 07:46:44 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2-mm2
Date: Fri, 8 Apr 2005 13:46:58 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20050408030835.4941cd98.akpm@osdl.org>
In-Reply-To: <20050408030835.4941cd98.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504081346.59282.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 8 of April 2005 12:08, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm2/
> 
> 
> - Although small, bk-audit.patch was causing conflits with a couple of
>   other projects.  Dropped for now.
> 
> - Greg is not using bk now, so bk-pci.patch, bk-i2c.patch,
>   bk-driver-core.patch and bk-usb.patch have been replaced with gregkh-*.patch
>   in -mm.
> 
> - Largeish x86_64 update

It does not compile on a uniprocessor x86-64:

  CC      arch/x86_64/kernel/process.o
  CC      arch/x86_64/kernel/semaphore.o
  CC      arch/x86_64/kernel/signal.o
  AS      arch/x86_64/kernel/entry.o
  CC      arch/x86_64/kernel/traps.o
  CC      arch/x86_64/kernel/irq.o
  CC      arch/x86_64/kernel/ptrace.o
  CC      arch/x86_64/kernel/time.o
  CC      arch/x86_64/kernel/ioport.o
  CC      arch/x86_64/kernel/ldt.o
  CC      arch/x86_64/kernel/setup.o
arch/x86_64/kernel/setup.c: In function `amd_detect_cmp':
arch/x86_64/kernel/setup.c:759: error: `cpu_core_id' undeclared (first use in this function)
arch/x86_64/kernel/setup.c:759: error: (Each undeclared identifier is reported only once
arch/x86_64/kernel/setup.c:759: error: for each function it appears in.)
make[1]: *** [arch/x86_64/kernel/setup.o] Error 1
make: *** [arch/x86_64/kernel] Error 2

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
