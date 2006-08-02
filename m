Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWHBEQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWHBEQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 00:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWHBEQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 00:16:54 -0400
Received: from ozlabs.org ([203.10.76.45]:42946 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751124AbWHBEQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 00:16:54 -0400
Subject: Re: [PATCH 1 of 13] Add apply_to_page_range() which applies a
	function to a pte range
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Lameter <clameter@sgi.com>
Cc: Chris Wright <chrisw@sous-sol.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Gerd Hoffmann <kraxel@suse.de>, Hollis Blanchard <hollisb@us.ibm.com>,
       Ian Pratt <ian.pratt@xensource.com>, Zachary Amsden <zach@vmware.com>,
       npiggin@suse.de, Ian Wienand <ianw@gelato.unsw.edu.au>
In-Reply-To: <Pine.LNX.4.64.0608011421080.19146@schroedinger.engr.sgi.com>
References: <79a98a10911fc4e77dce.1154421372@ezr.goop.org>
	 <m1ejw0zmic.fsf@ebiederm.dsl.xmission.com>
	 <20060801211410.GH2654@sequoia.sous-sol.org>
	 <Pine.LNX.4.64.0608011421080.19146@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 14:16:50 +1000
Message-Id: <1154492211.2570.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 14:31 -0700, Christoph Lameter wrote:
> On Tue, 1 Aug 2006, Chris Wright wrote:
> 
> > We got the opposite feedback the first time we posted this function.
> > Xen has some users, and I believe there's a couple in-tree functions we could
> > convert easily w/out overhead issues.  It's generic and this is just the
> > infrastructure, I think we should leave it.
> 
> Th generic method was proposed a number of times in the past including 
> by Nick Piggin and more recently by the page table abstraction layer 
> posted by Ian Wienand. See also 
> 
> http://www.gelato.org/pdf/apr2006/gelato_ICE06apr_unsw.pdf
> http://www.gelato.org/pdf/may2005/gelato_may2005_ia64vm_chubb_unsw.pdf.
> http://lwn.net/Articles/124961/
> 
> Special functionality may be attached at various levels, and we are very 
> sensitive to changes in this area.

Hi Christoph,

	Thanks for the pointers, but as you've been debating for 18 months now,
no patches are in the -mm tree or obviously about to go in, and this new
helper function is orthogonal to your work, I don't think it's
reasonable to delay this patch.

	All we can reasonably do is push this function back into the xen part
of the kernel tree for now.

Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

