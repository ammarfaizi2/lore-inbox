Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261714AbSKHJ2v>; Fri, 8 Nov 2002 04:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261718AbSKHJ2u>; Fri, 8 Nov 2002 04:28:50 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49930 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261714AbSKHJ2u>; Fri, 8 Nov 2002 04:28:50 -0500
Date: Fri, 8 Nov 2002 09:35:16 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module loader against 2.5.46: 9/9
Message-ID: <20021108093516.A15440@flint.arm.linux.org.uk>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
References: <25206.1036586620@ocs3.intra.ocs.com.au> <20021108003238.B01AD2C04C@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021108003238.B01AD2C04C@lists.samba.org>; from rusty@rustcorp.com.au on Thu, Nov 07, 2002 at 10:08:24PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 10:08:24PM +1100, Rusty Russell wrote:
> That explains it: I didn't think you were insane 8).  Thanks, I'll
> move it to some other name which just does the "add symbols to oops"
> minimum.

I doubt that we need all of the kallsyms data in the kernel as well (unless
you're using kdb.)

One of the things on my todo list is to look into a kallsyms replacement
that allows cross-compilation (and actually allows kallsyms to work at
all on ARM.)

ARM requires the ELF architecture private flags to be set correctly to link
two objects together.  So there's two problems with the current setup:

1. can't cross-compile with kallsyms
2. can't natively compile with kallsyms on architectures that require
   the private flags to be set correctly.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

