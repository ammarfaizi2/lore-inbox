Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbWFTLCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbWFTLCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWFTLCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:02:53 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:64472 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932595AbWFTLCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:02:52 -0400
Date: Tue, 20 Jun 2006 06:02:36 -0500
From: Robin Holt <holt@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: Jes Sorensen <jes@sgi.com>, Robin Holt <holt@sgi.com>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Hugh Dickins <hugh@veritas.com>, Carsten Otte <cotte@de.ibm.com>,
       bjorn_helgaas@hp.com
Subject: Re: [patch] do_no_pfn
Message-ID: <20060620110236.GA3099@lnx-holt.americas.sgi.com>
References: <yq0psh5zenq.fsf@jaguar.mkp.net> <200606201048.10545.ak@suse.de> <4497BBFE.6000703@sgi.com> <200606201135.53824.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606201135.53824.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 11:35:53AM +0200, Andi Kleen wrote:
> 
> > One struct page for a random single page here, another for a single
> > random page there. And the risk that someone will start walking the
> > pages and dereference and cause data corruption. As explained before,
> > it's a bad idea.
> 
> Note sure what your point is. Why should they cause memory corruption?
> 
> Allowing struct page less VM is worse. If you add that then people
> will use it for other stuff, and eventually we got a two class
> VM. All not very good.

You already have that.  You already stated the mapping of device memory.
The only thing we are asking to do is have a block of device memory
which has its pfn inserted at first touch.  The device is essentially
available on each node.  It is not something the generic parts of the
VM need to manage.  What benefit are we going to get from having
struct page * behind the pages when the struct page need to be marked
as reserved and uncached?

Thanks,
Robin
