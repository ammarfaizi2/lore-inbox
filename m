Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317944AbSGKXXX>; Thu, 11 Jul 2002 19:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317946AbSGKXXW>; Thu, 11 Jul 2002 19:23:22 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:32220 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S317944AbSGKXXV>;
	Thu, 11 Jul 2002 19:23:21 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200207112326.QAA04331@csl.Stanford.EDU>
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
To: andrew.grover@intel.com (Grover, Andrew)
Date: Thu, 11 Jul 2002 16:26:07 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7F9A@orsmsx111.jf.intel.com> from "Grover, Andrew" at Jul 11, 2002 03:32:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > From: Dawson Engler [mailto:engler@csl.Stanford.EDU] 
> > ---------------------------------------------------------
> > [BUG]  all other case arms call __sti(); however, it may be 
> > that safe_halt
> >        does something weird.
> > /u2/engler/mc/oses/linux/2.5.8/drivers/acpi/acpi_processor.c:5
> 
> #define safe_halt() __asm__ __volatile__("sti; hlt": : :"memory")
> 
> I think we're OK for now. I doubt safe_halt will change, but if it does I'll
> fix this issue.

ah.   missed the sti.  thanks!
