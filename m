Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVCRXRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVCRXRC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 18:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVCRXRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 18:17:02 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:36074 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262108AbVCRXQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 18:16:43 -0500
Subject: Re: [RFC][PATCH 5/6] sparsemem: more separation between NUMA and
	DISCONTIG
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20050318150826.4ca3ad14.akpm@osdl.org>
References: <E1DBisA-0000l4-00@kernel.beaverton.ibm.com>
	 <20050318150826.4ca3ad14.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 18 Mar 2005 15:16:17 -0800
Message-Id: <1111187778.9648.49.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-18 at 15:08 -0800, Andrew Morton wrote:
> Dave Hansen <haveblue@us.ibm.com> wrote:
> >
> >  There is some confusion with the SPARSEMEM patch between what
> >  is needed for DISCONTIG vs. NUMA.  For instance, the NODE_DATA()
> >  macro needs to be switched on NUMA, but not on FLATMEM.
> > 
> >  This patch is required if the previous patch is applied.
> 
> This patch breaks !CONFIG_NUMA ppc64:
> 
> include/linux/mmzone.h:387:1: warning: "NODE_DATA" redefined
> include/asm/mmzone.h:55:1: warning: this is the location of the previous definition
> 
> I'll hack around it for now.

I'll make sure to have it fixed properly in my copy.

Could I have a copy of your .config?  I'm keeping a growing collection.

-- Dave

