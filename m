Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265267AbUGSPyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbUGSPyo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 11:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbUGSPyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 11:54:44 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:27347 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265267AbUGSPyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 11:54:41 -0400
Subject: Re: [announce] HVCS for inclusion in 2.6 tree
From: Ryan Arnold <rsa@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16633.55727.513217.364467@cargo.ozlabs.ibm.com>
References: <1089819720.3385.66.camel@localhost>
	 <16633.55727.513217.364467@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Organization: IBM
Message-Id: <1090251975.30443.71.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Jul 2004 10:54:10 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-17 at 21:00, Paul Mackerras wrote:
> The arch/ppc64 stuff mostly looks OK - however I would prefer that you
> created a new arch/ppc64/kernel/hvcs.c (and include/asm-ppc64/hvcs.h)
> rather than tripling the size of the existing hvconsole.c.  There are
> a couple of whitespace nits (missing space after "if" in a couple of
> places), and this:

Paul, Thanks for the comments.  Maybe it would be better to avoid
repetition of file names and create include/asm-ppc64/hvcserver.h and
arch/ppc64/kernel/hvcserver.c?

> > +#define HVCS_LONG_INVALID	0xFFFFFFFFFFFFFFFF
> 
> would look better as either ~0UL or -1L (and I don't see why it really
> needs a #define).

Well, since the assigned variables are "unsigned long" I suppose ~OUL
would be more appropriate.

Ryan S. Arnold
IBM Corporation, Linux Technology Center

