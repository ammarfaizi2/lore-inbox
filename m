Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269184AbUJFKIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269184AbUJFKIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 06:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269186AbUJFKIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 06:08:30 -0400
Received: from mail.humboldt.co.uk ([81.2.65.18]:20191 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S269184AbUJFKI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 06:08:29 -0400
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
From: Adrian Cox <adrian@humboldt.co.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Richard Earnshaw <Richard.Earnshaw@arm.com>, linux-kernel@vger.kernel.org,
       Catalin Marinas <Catalin.Marinas@arm.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20041005145140.E6910@flint.arm.linux.org.uk>
References: <20040927210305.A26680@flint.arm.linux.org.uk>
	 <20041001211106.F30122@flint.arm.linux.org.uk> <tnxllemvgi7.fsf@arm.com>
	 <1096931899.32500.37.camel@localhost.localdomain>
	 <loom.20041005T130541-400@post.gmane.org>
	 <20041005125324.A6910@flint.arm.linux.org.uk>
	 <1096981035.14574.20.camel@pc960.cambridge.arm.com>
	 <20041005141452.B6910@flint.arm.linux.org.uk>
	 <1096983608.14574.32.camel@pc960.cambridge.arm.com>
	 <20041005145140.E6910@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1097057299.5332.15.camel@newt>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 06 Oct 2004 11:08:20 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 14:51, Russell King wrote:
> On Tue, Oct 05, 2004 at 02:40:08PM +0100, Richard Earnshaw wrote:

> > Looking at the output of nm -fsysv shows that currently the mapping
> > symbols are being incorrectly typed (the EABI requires them to be
> > STT_NOTYPE, but the previous ELF specification -- not supported by GNU
> > utils -- required them to be typed by the data they addressed.  I'll
> > submit a patch for that shortly).
> 
> Ugg - in that case, we need to go with the "match the name" version
> until these changes in binutils have matured (== 2 or 3 years time.)

Why does the Linux ARM ABI have to have any relation to the ARM EABI?
The PowerPC has had two different ABIs for years, and it's not caused us
any trouble. Can't we just leave the behaviour of binutils alone when
configured for an arm-linux target, and put all feature churn into an
arm-eabi target?

- Adrian Cox
Humboldt Solutions Ltd.


