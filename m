Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbUDTQy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUDTQy1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 12:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUDTQy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 12:54:27 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:34473 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S262351AbUDTQyZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 12:54:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-390@vm.marist.edu,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (s390)
Date: Tue, 20 Apr 2004 18:53:25 +0200
User-Agent: KMail/1.6.1
References: <OF97AEF891.DC06EC8E-ONC1256E7B.00576CE3-C1256E7B.00578DF9@de.ibm.com> <20040419171122.D29446@flint.arm.linux.org.uk>
In-Reply-To: <20040419171122.D29446@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404201853.37947.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 April 2004 18:11, Russell King wrote:
> Alternatively, could the diag10() prototype be moved somewhere else
> (tlbflush or cacheflush?)  Is diag10 a tlb or cache function?  It
> isn't clear from the code what diag10() does.

Think of it as some sort of madvise(,,MADV_DONTNEED) or free() in
hardware. I guess the next best place to put it is <asm/system.h>.

	Arnd <><
