Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268933AbUIQSlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268933AbUIQSlC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 14:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268937AbUIQSlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 14:41:02 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:35264 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268933AbUIQSk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 14:40:59 -0400
Subject: Re: [PPC64] Remove LARGE_PAGE_SHIFT constant
From: Dave Hansen <haveblue@us.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040917170328.GB2179@logos.cnet>
References: <20040917011320.GA6523@zax>  <20040917170328.GB2179@logos.cnet>
Content-Type: text/plain
Message-Id: <1095446429.4088.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 17 Sep 2004 11:40:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-17 at 10:03, Marcelo Tosatti wrote:
> On Fri, Sep 17, 2004 at 11:13:20AM +1000, David Gibson wrote:
> > Andrew, please apply:
> > 
> > For historical reasons, ppc64 has ended up with two #defines for the
> > size of a large (16M) page: LARGE_PAGE_SHIFT and HPAGE_SHIFT.  This
> > patch removes LARGE_PAGE_SHIFT in favour of the more widely used
> > HPAGE_SHIFT.
> 
> Nitpicking, "LARGE_PAGE_xxx" is used by x86/x86_64:
> 
> #define LARGE_PAGE_MASK (~(LARGE_PAGE_SIZE-1))
> #define LARGE_PAGE_SIZE (1UL << PMD_SHIFT)
> 
> Wouldnt it be nice to keep consistency between archs?

Actually, if everybody makes sure to define PMD_SHIFT, we should be able
to use common macros, right?

-- Dave

