Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbVIAQDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbVIAQDk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 12:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbVIAQDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 12:03:40 -0400
Received: from usbb-lacimss1.unisys.com ([192.63.108.51]:3603 "EHLO
	usbb-lacimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1030218AbVIAQDj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 12:03:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Hotplug_sig] [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
Date: Thu, 1 Sep 2005 11:03:16 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D11@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Hotplug_sig] [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
Thread-Index: AcWvDitwOiZbcosRQjO/E9ktBssSiwAADPpw
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Nathan Lynch" <nathanl@austin.ibm.com>
Cc: <shaohua.li@intel.com>, <akpm@osdl.org>, <zwane@arm.linux.org.uk>,
       <hotplug_sig@lists.osdl.org>, <linux-kernel@vger.kernel.org>,
       <lhcs-devel@lists.sourceforge.net>, <ak@suse.de>
X-OriginalArrivalTime: 01 Sep 2005 16:03:17.0395 (UTC) FILETIME=[AA725630:01C5AF0E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Protasevich, Natalie wrote:
> > > > +#ifdef CONFIG_HOTPLUG_CPU
> > > > +	if (cpu_online(cpu)) {
> > > > +#else
> > > >  	if (cpu_online(cpu) || !cpu_present(cpu)) {
> > > > +#endif
> > > >  		ret = -EINVAL;
> > > >  		goto out;
> > > >  	}
> > > 
> > > Why this change?  I think the cpu_present check is needed for
> > > ppc64 since it has non-present cpus in sysfs.
> > > 
> > 
> > The new processor was never brought up, its bit is only set in 
> > cpu_possible_map, but not in present map.
> 
> If a cpu is physically present and is capable of being 
> onlined it should be marked in cpu_present_map, please.  This 
> change would break ppc64; can you rework it?
>
OK, that has to be reworked then. That's what probably Shaohua meant
when mentioned that cpu_present_map has to be cleaned up... 
Thanks,
--Natalie
