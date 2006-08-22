Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWHVRpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWHVRpH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 13:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWHVRpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 13:45:06 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:49061 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751422AbWHVRpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 13:45:05 -0400
Date: Tue, 22 Aug 2006 13:42:33 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] arch/um/sys-i386/setjmp.S: useless #ifdef _REGPARM's?
Message-ID: <20060822174233.GA5471@ccure.user-mode-linux.org>
References: <20060821215641.GQ11651@stusta.de> <20060822022012.GA7070@ccure.user-mode-linux.org> <20060822160741.GB11651@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822160741.GB11651@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 06:07:41PM +0200, Adrian Bunk wrote:
> I didn't find a corresponding open bug in the gcc Bugzilla.
> 
> Can someone verify whether it's still present, and if yes, open a gcc 
> bug?

Yup, it's easy enough to check.

> It's set globally in arch/i386/Makefile:
>   cflags-$(CONFIG_REGPARM) += -mregparm=3

IIRC, there used to be functions explicitly declared as __regparam or
something, and that's what I was grepping for.  Does this turn every
function with three or fewer parameters into a regparam function?

> That's not pulled by UML, but if there are no outstanding problems with 
> regparm, we could both enable it uncomditionally on i386 and enable it
> on UML/i386.

That shouldn't be a problem.

				Jeff
