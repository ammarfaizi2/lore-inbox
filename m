Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbTJDJW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 05:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbTJDJW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 05:22:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61968 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261963AbTJDJW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 05:22:26 -0400
Date: Sat, 4 Oct 2003 10:22:21 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, Andi Kleen <ak@muc.de>,
       Joe Korty <joe.korty@ccur.com>, linux-kernel@vger.kernel.org
Subject: Re: mlockall and mmap of IO devices don't mix
Message-ID: <20031004102221.A18928@flint.arm.linux.org.uk>
Mail-Followup-To: Andi Kleen <ak@colin2.muc.de>,
	Ingo Oeser <ioe-lkml@rameria.de>, Andi Kleen <ak@muc.de>,
	Joe Korty <joe.korty@ccur.com>, linux-kernel@vger.kernel.org
References: <CFYv.787.23@gated-at.bofh.it> <m34qyp7ae4.fsf@averell.firstfloor.org> <200310041047.56705.ioe-lkml@rameria.de> <20031004091703.GB23306@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031004091703.GB23306@colin2.muc.de>; from ak@colin2.muc.de on Sat, Oct 04, 2003 at 11:17:03AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 11:17:03AM +0200, Andi Kleen wrote:
> > This check is only done, if it is a valid pfn (pfn_valid()) of a present
> > pte.
> 
> pfn_valid is useless, it doesn't handle all IO holes on x86 for examples.

Sounds like pfn_valid() is buggy on x86.  It's supposed to definitively
indicate whether the PFN is a valid page of ram (and has a valid struct
page entry.)  If it doesn't do that, the architecture implementation is
wrong.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
