Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWDSBXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWDSBXl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 21:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWDSBXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 21:23:41 -0400
Received: from fmr20.intel.com ([134.134.136.19]:2012 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750931AbWDSBXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 21:23:40 -0400
Subject: Re: [PATCH 2/3] swsusp i386 mark special saveable/unsaveable pages
From: Shaohua Li <shaohua.li@intel.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200604190838.29247.ncunningham@cyclades.com>
References: <1144809501.2865.40.camel@sli10-desk.sh.intel.com>
	 <200604190838.29247.ncunningham@cyclades.com>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 09:22:01 +0800
Message-Id: <1145409721.19994.5.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 08:38 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Wednesday 12 April 2006 12:38, Shaohua Li wrote:
> > @@ -1400,6 +1401,111 @@ static void set_mca_bus(int x)
> >  static void set_mca_bus(int x) { }
> >  #endif
> >
> > +#ifdef CONFIG_SOFTWARE_SUSPEND
> > +static void __init mark_nosave_page_range(unsigned long start, unsigned
> > long end) +{
> > +	struct page *page;
> > +	while (start <= end) {
> 
> Should this be start < end? (End is usually the first byte of the next zone 
> IIUC).
Thanks for looking at it. Yes you are right. Before calling this
routine, I already decrement 1 for 'end', so the routine will have the
last page pfn.

Thanks,
Shaohua

