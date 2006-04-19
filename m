Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWDSCys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWDSCys (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 22:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWDSCyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 22:54:47 -0400
Received: from fmr20.intel.com ([134.134.136.19]:21729 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750725AbWDSCyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 22:54:47 -0400
Subject: Re: [PATCH 2/3] swsusp i386 mark special saveable/unsaveable pages
From: Shaohua Li <shaohua.li@intel.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200604191208.49386.ncunningham@cyclades.com>
References: <1144809501.2865.40.camel@sli10-desk.sh.intel.com>
	 <200604191141.51492.ncunningham@cyclades.com>
	 <1145411499.19994.12.camel@sli10-desk.sh.intel.com>
	 <200604191208.49386.ncunningham@cyclades.com>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 10:53:32 +0800
Message-Id: <1145415212.19994.15.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 12:08 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Wednesday 19 April 2006 11:51, Shaohua Li wrote:
> > On Wed, 2006-04-19 at 11:41 +1000, Nigel Cunningham wrote:
> > > Oh, and while we're on the topic, if only part of a page is NVS, what's
> > > the right behaviour? My e820 table has:
> > >
> > > BIOS-e820: 000000003dff0000 - 000000003dffffc0 (ACPI data)
> > > BIOS-e820: 000000003dffffc0 - 000000003e000000 (ACPI NVS)
> >
> > If only part of a page is NVS, my patch will save the whole page. Any
> > other idea?
> 
> A device model driver that handles saving just the part of the page, using 
> preallocated buffers to avoid the potential allocation problems? (The whole 
> page could then safely be Nosave).
The allocation might not be a problem, this just needs one or two extra
pages. A problem is if just part of the page is NVS, could we touch
other part (save/restore) the page.

Thanks,
Shaohua

