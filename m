Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268998AbUIQQDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268998AbUIQQDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269013AbUIQQDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 12:03:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38310 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268998AbUIQP5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 11:57:41 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Len Brown <len.brown@intel.com>
Subject: Re: 2.6.9-rc2-mm1
Date: Fri, 17 Sep 2004 08:57:13 -0700
User-Agent: KMail/1.7
Cc: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <452548B29F0CCE48B8ABB094307EBA1C0651E9A9@USRV-EXCH2.na.uis.unisys.com> <1095403811.2046.51.camel@d845pe>
In-Reply-To: <1095403811.2046.51.camel@d845pe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409170857.13631.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 16, 2004 11:50 pm, Len Brown wrote:
> I'm not sure exactly that the patch above was trying to fix.  Looks like
> it is time to examine the latest ew7000 changes in detail.  But I think
> the patch has pointed out that this routine really should be returning 0
> for success and non zero for failure; and returning dev->irq was
> probably a latent bug all along.

Right, and I'd like success to be defined a little more broadly.  If dev->irq 
is already valid, we should just return 0 right away.  That would take care 
of platforms that already have the dev in question setup properly.

Thanks,
Jesse
