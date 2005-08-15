Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbVHOKPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbVHOKPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 06:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbVHOKPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 06:15:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21005 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932611AbVHOKPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 06:15:54 -0400
Date: Mon, 15 Aug 2005 11:15:48 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: blaisorblade@yahoo.it, akpm@osdl.org, jdike@addtoit.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, mingo@elte.hu
Subject: Re: [patch 18/39] remap_file_pages protection support: add VM_FAULT_SIGSEGV
Message-ID: <20050815111548.F19811@flint.arm.linux.org.uk>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	blaisorblade@yahoo.it, akpm@osdl.org, jdike@addtoit.com,
	linux-kernel@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net, mingo@elte.hu
References: <20050812182145.DF52E24E7F3@zion.home.lan> <20050815104022.D19811@flint.arm.linux.org.uk> <43006AA6.1040405@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <43006AA6.1040405@yahoo.com.au>; from nickpiggin@yahoo.com.au on Mon, Aug 15, 2005 at 08:12:54PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 08:12:54PM +1000, Nick Piggin wrote:
> Well there is now, and that is we are now using a bit in the 2nd
> byte as flags. So I had to do away with -ve numbers there entirely.
> 
> You could achieve a similar thing by using another bit in that byte
> #define VM_FAULT_FAILED 0x20
> and make that bit present in VM_FAULT_OOM and VM_FAULT_SIGBUS, then
> do an unlikely test for that bit in your handler and branch away to
> the slow path.

That'll do as well, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
