Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265150AbTLMQFr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 11:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265153AbTLMQFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 11:05:47 -0500
Received: from p508B6CC5.dip.t-dialin.net ([80.139.108.197]:51847 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S265150AbTLMQFq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 11:05:46 -0500
Date: Sat, 13 Dec 2003 17:05:36 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Peter Horton <pdh@colonel-panic.org>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: Possible shared mapping bug in 2.4.23 (at least MIPS/Sparc)
Message-ID: <20031213160536.GA13271@linux-mips.org>
References: <20031213114134.GA9896@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031213114134.GA9896@skeleton-jack>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 13, 2003 at 11:41:34AM +0000, Peter Horton wrote:

> The current MIPS 2.4 kernel (from CVS) currently allows fixed shared
> mappings to violate D-cache aliasing constraints.
> 
> The check for illegal fixed mappings is done in
> arch_get_unmapped_area(), but these mappings are granted in
> get_unmapped_area() and arch_get_unmapped_area() is never called.
> 
> A quick look at sparc and sparc64 seem to show the same problem.

Ehh...  <asm/pgtable.h> defines HAVE_ARCH_UNMAPPED_AREA therefore
get_unmapped_area calls the arch's version of arch_get_unmapped_area
instead of the generic version in mm/mmap.c

  Ralf
