Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVDLNb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVDLNb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVDLM7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:59:50 -0400
Received: from fmr17.intel.com ([134.134.136.16]:45741 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262421AbVDLMwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:52:10 -0400
Subject: Re: [PATCH 5/6]physical CPU hot add
From: Li Shaohua <shaohua.li@intel.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0504120609350.14171@montezuma.fsmlabs.com>
References: <1113283863.27646.432.camel@sli10-desk.sh.intel.com>
	 <Pine.LNX.4.61.0504120609350.14171@montezuma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1113310145.5155.12.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 12 Apr 2005 20:49:05 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 20:17, Zwane Mwaikambo wrote:
> On Tue, 12 Apr 2005, Li Shaohua wrote:
> 
> >  #ifdef CONFIG_HOTPLUG_CPU
> > +int __attribute__ ((weak)) smp_prepare_cpu(int cpu)
> > +{
> > +	return 0;
> > +}
> > +
> 
> Any way for you to avoid using weak attribute?
Just want to avoid more 'ifdef' or 'define empty routine for other
archs' staffs. Someone prefer 'weak' attribute. Either way is ok to me,
but if you think the former is better, I'd change it.

Thanks,
Shaohua

