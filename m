Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268904AbUIQSZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268904AbUIQSZK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 14:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268919AbUIQSZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 14:25:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14479 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268904AbUIQSZG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 14:25:06 -0400
Date: Fri, 17 Sep 2004 14:03:28 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Remove LARGE_PAGE_SHIFT constant
Message-ID: <20040917170328.GB2179@logos.cnet>
References: <20040917011320.GA6523@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917011320.GA6523@zax>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 11:13:20AM +1000, David Gibson wrote:
> Andrew, please apply:
> 
> For historical reasons, ppc64 has ended up with two #defines for the
> size of a large (16M) page: LARGE_PAGE_SHIFT and HPAGE_SHIFT.  This
> patch removes LARGE_PAGE_SHIFT in favour of the more widely used
> HPAGE_SHIFT.

Nitpicking, "LARGE_PAGE_xxx" is used by x86/x86_64:

#define LARGE_PAGE_MASK (~(LARGE_PAGE_SIZE-1))
#define LARGE_PAGE_SIZE (1UL << PMD_SHIFT)

Wouldnt it be nice to keep consistency between archs?
