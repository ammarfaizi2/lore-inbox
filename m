Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264358AbUGRSMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUGRSMH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 14:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUGRSMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 14:12:07 -0400
Received: from ozlabs.org ([203.10.76.45]:43458 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264358AbUGRSME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 14:12:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16633.55727.513217.364467@cargo.ozlabs.ibm.com>
Date: Sun, 18 Jul 2004 12:00:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: Ryan Arnold <rsa@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [announce] HVCS for inclusion in 2.6 tree
In-Reply-To: <1089819720.3385.66.camel@localhost>
References: <1089819720.3385.66.camel@localhost>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan,

> I would like the attached HVCS driver considered for inclusion into the
> 2.6 mainline tree.  This is a ppc64 platform driver so I figured that
> maybe Paul MacKerras would like to sign off on the arch specific
> segments of this driver before inclusion.

The arch/ppc64 stuff mostly looks OK - however I would prefer that you
created a new arch/ppc64/kernel/hvcs.c (and include/asm-ppc64/hvcs.h)
rather than tripling the size of the existing hvconsole.c.  There are
a couple of whitespace nits (missing space after "if" in a couple of
places), and this:

> +#define HVCS_LONG_INVALID	0xFFFFFFFFFFFFFFFF

would look better as either ~0UL or -1L (and I don't see why it really
needs a #define).

Regards,
Paul.
