Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVDWPLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVDWPLE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 11:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVDWPLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 11:11:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:33177 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261605AbVDWPK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 11:10:59 -0400
Date: Sat, 23 Apr 2005 17:10:48 +0200
From: Andi Kleen <ak@suse.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Rohit Seth <rohit.seth@intel.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Increase number of e820 entries hard limit from 32 to 128
Message-ID: <20050423151048.GE7715@wotan.suse.de>
References: <20050422181441.A18205@unix-os.sc.intel.com> <Pine.LNX.4.58.0504221851140.2344@ppc970.osdl.org> <20050422193250.A18512@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050422193250.A18512@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2005 at 07:32:50PM -0700, Venkatesh Pallipadi wrote:
> On Fri, Apr 22, 2005 at 06:51:59PM -0700, Linus Torvalds wrote:
> > On Fri, 22 Apr 2005, Venkatesh Pallipadi wrote:
> > > The specifications that talk about E820 map doesn't have an upper limit
> > > on the number of E820 entries. But, today's kernel has a hard limit of 32.
> > > With increase in memory size, we are seeing the number of E820 entries
> > > reaching close to 32. Patch below bumps the number upto 128. 
> > 
> > Hmm. Anything that changes setup.S tends to have bootloader dependencies. 
> > I worry whether this one does too..
> > 
> 
> The setup.S change in this patch should be OK. As it is adding to the 
> existing zero-page and keeping it within one page. I tested it on systems 
> with grub, adding some dummy E820 entries and it worked fine.

The last time I tried to extend the zero page (with a longer command line)
it broke lilo on systems with EDID support and CONFIG_EDID enabled.
Make sure you test that case.

-Andi

