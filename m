Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUDSQL1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUDSQL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:11:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64272 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261231AbUDSQL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:11:26 -0400
Date: Mon, 19 Apr 2004 17:11:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-390@vm.marist.edu, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (s390)
Message-ID: <20040419171122.D29446@flint.arm.linux.org.uk>
Mail-Followup-To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-390@vm.marist.edu,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <OF97AEF891.DC06EC8E-ONC1256E7B.00576CE3-C1256E7B.00578DF9@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF97AEF891.DC06EC8E-ONC1256E7B.00576CE3-C1256E7B.00578DF9@de.ibm.com>; from schwidefsky@de.ibm.com on Mon, Apr 19, 2004 at 05:56:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 05:56:19PM +0200, Martin Schwidefsky wrote:
> > This patch cleans up needless includes of asm/pgalloc.h from the
> > arch/s390/ subtree.  This has not been compile tested, so
> > needs the architecture maintainers (or willing volunteers) to
> > test.
> 
> Doesn't compile. s390_ksyms needs pgalloc.h for the definition of diag10.
> The other includes of pgalloc.h can be removed without a problem.

Alternatively, could the diag10() prototype be moved somewhere else
(tlbflush or cacheflush?)  Is diag10 a tlb or cache function?  It
isn't clear from the code what diag10() does.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
