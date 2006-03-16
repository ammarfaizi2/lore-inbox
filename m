Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWCPQZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWCPQZC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWCPQZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:25:01 -0500
Received: from xenotime.net ([66.160.160.81]:20935 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750818AbWCPQZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:25:00 -0500
Date: Thu, 16 Mar 2006 08:27:00 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: brian@visionpro.com, linux-kernel@vger.kernel.org
Subject: Re: remap_page_range() vs. remap_pfn_range()
Message-Id: <20060316082700.dc18cb1e.rdunlap@xenotime.net>
In-Reply-To: <1142524255.3041.50.camel@laptopd505.fenrus.org>
References: <14CFC56C96D8554AA0B8969DB825FEA0970C7D@chicken.machinevisionproducts.com>
	<1142524255.3041.50.camel@laptopd505.fenrus.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006 16:50:55 +0100 Arjan van de Ven wrote:

> On Thu, 2006-03-16 at 07:42 -0800, Brian D. McGrew wrote:
> > I've seen the change in the kernel for this call so I changed my device
> > drive to use the new call and now every time I access the device the
> > machine gets really unstable and crashes after a minute or so.
> 
> you forgot to post the URL to your source code, so how can we help you?

You changed the function name and didn't change any parameters?

The page parameter must also be modified to become
a <pfn> parameter, e.g., change <page> to
  page >> PAGE_SHIFT

however, yes, any other help would need source code.

---
~Randy
