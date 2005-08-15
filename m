Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbVHOKZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbVHOKZu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 06:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbVHOKZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 06:25:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17933 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932578AbVHOKZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 06:25:50 -0400
Date: Mon, 15 Aug 2005 11:25:46 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 18/39] remap_file_pages protection support: add VM_FAULT_SIGSEGV
Message-ID: <20050815112546.G19811@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050812182145.DF52E24E7F3@zion.home.lan> <20050815104022.D19811@flint.arm.linux.org.uk> <43006AA6.1040405@yahoo.com.au> <20050815111548.F19811@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050815111548.F19811@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Mon, Aug 15, 2005 at 11:15:48AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 11:15:48AM +0100, Russell King wrote:
> On Mon, Aug 15, 2005 at 08:12:54PM +1000, Nick Piggin wrote:
> > Well there is now, and that is we are now using a bit in the 2nd
> > byte as flags. So I had to do away with -ve numbers there entirely.
> > 
> > You could achieve a similar thing by using another bit in that byte
> > #define VM_FAULT_FAILED 0x20
> > and make that bit present in VM_FAULT_OOM and VM_FAULT_SIGBUS, then
> > do an unlikely test for that bit in your handler and branch away to
> > the slow path.
> 
> That'll do as well, thanks.

Note that Ingo will not get replies from me anymore - Ingo is doing
sender callback checks on the From:/Sender: headers.  Since my joejob
protection ensures that I never receive bounces to those addresses,
such callbacks fail.  Hence his server rejects my messages.

I am not changing my policy on this - I get hammered with a tremendous
amount of such crap which tools like SA seem completely incapable of
dealing with, sorry.

(Note: this means that other folk, eg dwmw2, are in a similar position.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
