Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVDFVCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVDFVCO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 17:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbVDFVCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 17:02:13 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:33731 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262319AbVDFVCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 17:02:05 -0400
Subject: Re: [PATCH 1/4] create mm/Kconfig for arch-independent memory
	options
From: Dave Hansen <haveblue@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <42544D7E.1040907@linux-m68k.org>
References: <E1DIViE-0006Kf-00@kernel.beaverton.ibm.com>
	 <42544D7E.1040907@linux-m68k.org>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 14:01:59 -0700
Message-Id: <1112821319.14584.28.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-06 at 22:58 +0200, Roman Zippel wrote:
> Dave Hansen wrote:
> > --- memhotplug/mm/Kconfig~A6-mm-Kconfig	2005-04-04 09:04:48.000000000 -0700
> > +++ memhotplug-dave/mm/Kconfig	2005-04-04 10:15:23.000000000 -0700
> > @@ -0,0 +1,25 @@
> > +choice
> > +	prompt "Memory model"
> > +	default FLATMEM
> > +	default SPARSEMEM if ARCH_SPARSEMEM_DEFAULT
> > +	default DISCONTIGMEM if ARCH_DISCONTIGMEM_DEFAULT
> 
> Does this really have to be a user visible option and can't it be
> derived from other values? The help text entries are really no help at all.

I hope that this selection will replace the current DISCONTIGMEM prompts
in the individual architectures.  That way, you won't get a net increase
in the number of prompts.  However, I do realize that architectures
without DISCONTIG see a new, relatively useless menu/prompt.

Is there a way to hide an entire "choice" menu?  If there is, we can
certainly hide it when there's only one possible choice.

-- Dave

