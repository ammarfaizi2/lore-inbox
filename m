Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136705AbREATqj>; Tue, 1 May 2001 15:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136710AbREATqa>; Tue, 1 May 2001 15:46:30 -0400
Received: from www.linux.org.uk ([195.92.249.252]:46342 "EHLO www.linux.org.uk")
	by vger.kernel.org with ESMTP id <S136705AbREATqR>;
	Tue, 1 May 2001 15:46:17 -0400
Date: Tue, 1 May 2001 20:45:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
Message-ID: <20010501204543.B3541@flint.arm.linux.org.uk>
Mail-Followup-To: Russell King <rmk@flint.arm.linux.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <OF7A9C6B22.E1638E60-ON85256A3F.004EADC7@urscorp.com> <9cmrcv$20e$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9cmrcv$20e$1@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, May 01, 2001 at 10:22:39AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2001 at 10:22:39AM -0700, Linus Torvalds wrote:
> I bet that the patch will be smaller too. It's a simple case of
>  - do the ioremap() _once_ at bootup, save the result in a static
>    variable somewhere.
>  - implement the (one-liner) isa_readx/isa_writex functions.
> 
> On many architectures you don't even need to do the ioremap, as it's
> always available (same as on x86).

Talking around this issue, is there any chance of getting the
official use of the first parameter to ioremap documented in
Documentation/IO-mapping.txt please?  There appears to be
confusion as to whether it is:

a) PCI bus address
b) CPU untranslated address

Currently, IO-mapping.txt seems to imply (a), but I believe that
a lot of people on lkml will disagree with that.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

