Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267385AbUJGPJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267385AbUJGPJd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 11:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUJGPJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 11:09:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:772 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264639AbUJGPCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 11:02:19 -0400
Date: Thu, 7 Oct 2004 16:02:13 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Richard Earnshaw <Richard.Earnshaw@arm.com>, linux-kernel@vger.kernel.org,
       Catalin Marinas <Catalin.Marinas@arm.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
Message-ID: <20041007160213.C8579@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Cox <adrian@humboldt.co.uk>,
	Richard Earnshaw <Richard.Earnshaw@arm.com>,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Sam Ravnborg <sam@ravnborg.org>
References: <20041001211106.F30122@flint.arm.linux.org.uk> <tnxllemvgi7.fsf@arm.com> <1096931899.32500.37.camel@localhost.localdomain> <loom.20041005T130541-400@post.gmane.org> <20041005125324.A6910@flint.arm.linux.org.uk> <1096981035.14574.20.camel@pc960.cambridge.arm.com> <20041005141452.B6910@flint.arm.linux.org.uk> <1096983608.14574.32.camel@pc960.cambridge.arm.com> <20041005145140.E6910@flint.arm.linux.org.uk> <1097057299.5332.15.camel@newt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1097057299.5332.15.camel@newt>; from adrian@humboldt.co.uk on Wed, Oct 06, 2004 at 11:08:20AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 11:08:20AM +0100, Adrian Cox wrote:
> On Tue, 2004-10-05 at 14:51, Russell King wrote:
> > On Tue, Oct 05, 2004 at 02:40:08PM +0100, Richard Earnshaw wrote:
> 
> > > Looking at the output of nm -fsysv shows that currently the mapping
> > > symbols are being incorrectly typed (the EABI requires them to be
> > > STT_NOTYPE, but the previous ELF specification -- not supported by GNU
> > > utils -- required them to be typed by the data they addressed.  I'll
> > > submit a patch for that shortly).
> > 
> > Ugg - in that case, we need to go with the "match the name" version
> > until these changes in binutils have matured (== 2 or 3 years time.)
> 
> Why does the Linux ARM ABI have to have any relation to the ARM EABI?
> The PowerPC has had two different ABIs for years, and it's not caused us
> any trouble. Can't we just leave the behaviour of binutils alone when
> configured for an arm-linux target, and put all feature churn into an
> arm-eabi target?

I'll suggest that Richard should answer this question.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
