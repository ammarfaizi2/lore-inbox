Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130031AbQKNVaa>; Tue, 14 Nov 2000 16:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130378AbQKNVaU>; Tue, 14 Nov 2000 16:30:20 -0500
Received: from hera.cwi.nl ([192.16.191.1]:38324 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130031AbQKNVaH>;
	Tue, 14 Nov 2000 16:30:07 -0500
Date: Tue, 14 Nov 2000 22:00:05 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_EISA note in Documentation/Configure.help
Message-ID: <20001114220005.B25349@veritas.com>
In-Reply-To: <00111317072200.00727@localhost.localdomain> <20001114205950.A25349@veritas.com> <3A119F29.2BD8E7C@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A119F29.2BD8E7C@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, Nov 14, 2000 at 03:23:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2000 at 03:23:05PM -0500, Jeff Garzik wrote:
> Andries Brouwer wrote:
> > However, CONFIG_EISA is almost completely superfluous, is not
> > required at compile time, can easily be tested at run time,
> > in other words adding such an option is a very stupid thing to do.
> 
> Each driver's entry in Config.in should be dependent on its
> CONFIG_{ISA,EISA,PCI,SBUS,...} defines that indicate what buses are
> defined on this particular architecture.

No, it should not. I see no CONFIG_VLB in your list above.
CONFIG_EISA should not be there either.

I said that it is very stupid to pose this question to the user
who configures the kernel. There are far too many config variables
already, and nothing in the kernel needs to know the answer.

That EISA basically is ISA, as far as the kernel is concerned.
That zero code depends on the variable. That nothing is gained
by knowing that the system is supposed to be EISA rather than ISA.
[I discussed the very little that we do not do yet, but might do.]

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
