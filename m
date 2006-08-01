Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWHAVgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWHAVgh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWHAVgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:36:37 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:22400 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1750881AbWHAVgh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:36:37 -0400
Date: Tue, 1 Aug 2006 14:37:51 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@sous-sol.org>, jeremy@xensource.com,
       linux-kernel@vger.kernel.org, Christian.Limpach@cl.cam.ac.uk,
       clameter@sgi.com, ebiederm@xmission.com, kraxel@suse.de,
       hollisb@us.ibm.com, ian.pratt@xensource.com, rusty@rustcorp.com.au,
       zach@vmware.com
Subject: Re: [PATCH 7 of 13] Make __FIXADDR_TOP variable to allow it to make space for a hypervisor
Message-ID: <20060801213751.GA11244@sequoia.sous-sol.org>
References: <patchbomb.1154421371@ezr.goop.org> <b6c100bb5ca5e2839ac8.1154421378@ezr.goop.org> <20060801090330.GC2654@sequoia.sous-sol.org> <20060801073428.f543ba9f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801073428.f543ba9f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> On Tue, 1 Aug 2006 02:03:30 -0700
> Chris Wright <chrisw@sous-sol.org> wrote:
> 
> > * Jeremy Fitzhardinge (jeremy@xensource.com) wrote:
> > > -#define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
> > > +#define MAXMEM			(__FIXADDR_TOP-__PAGE_OFFSET-__VMALLOC_RESERVE)
> > 
> > In the native case we lose one page of lowmem now.
> 
> erm, isn't this the hunk which gave one of my machines a 4kb highmem zone?
> I have memories of reverting it.

Yes, that does sound quite familiar.  I couldn't find the thread, do you
recall any of the details?  I expect it's the same issue as the off by one
page I mentioned above.

thanks,
-chris
