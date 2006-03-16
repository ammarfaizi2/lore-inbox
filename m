Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752452AbWCPTc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbWCPTc2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 14:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWCPTc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 14:32:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14315 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751192AbWCPTc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 14:32:27 -0500
Message-ID: <4419BD64.5070705@ce.jp.nec.com>
Date: Thu, 16 Mar 2006 14:32:52 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Maule <maule@sgi.com>
CC: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       shaohua.li@intel.com
Subject: Re: [PATCH] (-mm) drivers/pci/msi: explicit declaration of msi_register
References: <44172F0E.6070708@ce.jp.nec.com> <20060314134535.72eb7243.akpm@osdl.org> <44176502.9050109@ce.jp.nec.com> <20060315235544.GA6504@suse.de> <44198210.6090109@ce.jp.nec.com> <20060316181934.GM13666@sgi.com>
In-Reply-To: <20060316181934.GM13666@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thanks for the reply.

Mark Maule wrote:
>>There is another problem that CONFIG_IA64_GENERIC still doesn't
>>build due to error in SGI SN specific code.
>>It needs additional fix.
> 
> Ok, looking back at some of my original patches, it seems like the
> declaration of msi_ops got moved from pci.h to and some forward declarations
> in ia64/msi.h were removed.  This patch corrects the build problems.

But,

Greg said:
> these are core pci things that no one else should care about.

Andrew said:
> a declaration for msi_register(), in drivers/pci/pci.h.
 > We don't want to add a duplicated declaration like this.

I think the idea already gets objections.

> The reason for putting struct msi_ops in pci.h is so that msi code that
> resides outside of drivers/pci can use the declaration without having to
> reach down into drivers/pci.

The code in arch/ia64/sn/pci/msi.c looks much like
drivers/pci/msi-apic.c.
Why don't you move them to drivers/pci/msi-sgi-sn.c or something?

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.
