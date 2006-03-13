Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWCMS7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWCMS7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWCMS7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:59:16 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:12985 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751487AbWCMS7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:59:15 -0500
Date: Mon, 13 Mar 2006 10:55:00 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: William Cohen <wcohen@nc.rr.com>
Cc: linux-kernel@vger.kernel.org, perfmon@napali.hpl.hp.com,
       perfctr-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: Re: [Perfctr-devel] 2.6.16-rc5 perfmon2 new code base + libpfm with Montecito support
Message-ID: <20060313185500.GB32683@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060308155311.GD13168@frankl.hpl.hp.com> <4415BC45.1010601@nc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4415BC45.1010601@nc.rr.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will,

On Mon, Mar 13, 2006 at 01:39:01PM -0500, William Cohen wrote:
> Hi Stephane,
> 
> I have been looking through the perfmon2 code to see how it is going to 
> work with OProfile. It looks like the ia64 oprofile support has not been 
> modified to work with the changes in perfmon2. Has the ia64 kernel been 
> built with perfmon2 and oprofile support? I don't have easy access to an 
> ia64, so I haven't been able to verify that the attached patch works. 
> However, I expect that the changes in the patch will be required for 
> OProfile to function with perfmon2.
> 
Good timing. I just fixed this today. Now it compiles fine on
IA64.  I also started looking into using the same technique on
i386. It is very easy. It looks like opcontrol or ophelp
would need to be updated. I think the trick is to make
sure that ophelp knows the PMU mapping used by perfmon2,
i.e., knows that PERFEVTSEL0 is PMC0 for instance.

-- 
-Stephane
