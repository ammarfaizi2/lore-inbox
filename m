Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271843AbTHLStM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 14:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271890AbTHLStM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 14:49:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45765 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271843AbTHLStI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 14:49:08 -0400
Message-ID: <3F393697.8000508@pobox.com>
Date: Tue, 12 Aug 2003 14:48:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Nakajima, Jun" <jun.nakajima@intel.com>
CC: Zwane Mwaikambo <zwane@linuxpower.ca>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Subject: Re: Updated MSI Patches
References: <7F740D512C7C1046AB53446D3720017304AE94@scsmsx402.sc.intel.com>
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AE94@scsmsx402.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nakajima, Jun wrote:
> The issue with do_MSI() approach is that it's very similar to do_IRQ(),
> and we may have maintenance issues there. However, if we make a common

I agree


> do_MSI() code, that might be worth it, and I would expect much fewer
> architecture-dependent issues there, compared to do_IRQ (the common
> do_IRQ() hasn't happened yet as far as I know).

However, we have maintenance issues in this area as well :)

If you look at each architecture's implementation of do_IRQ, you can see 
each implementation is strikingly similar... except for some subtle 
differences.  So there are arguments both ways:  creating a common 
do_IRQ may add maintenance value...  but also create corner-case 
problems for the arch maintainers.

So, IMO, do_IRQ is one special case where copying code may be preferred 
over common code.

And I also feel the same way about do_MSI().  However, I have not looked 
at non-ia32 MSI implementations to know what sort of issues exist.

	Jeff



