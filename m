Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWA3RRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWA3RRR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWA3RRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:17:17 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:18831 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964800AbWA3RRP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:17:15 -0500
Message-ID: <43DE4A1D.4050501@us.ibm.com>
Date: Mon, 30 Jan 2006 12:17:17 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Greg KH <greg@kroah.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: [PATCH 2.6.12.6-xen] sysfs attributes for xen
References: <43DAD4DB.4090708@us.ibm.com>	 <1138637931.19801.101.camel@localhost.localdomain>	 <43DE45A4.6010808@us.ibm.com> <1138640666.19801.106.camel@localhost.localdomain>
In-Reply-To: <1138640666.19801.106.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> In the final version, there will be available Xen headers, and the patch
> won't need the open-coded 1024?

Good question, I need some advice. The Xen hcall headers get soft-linked into every paravirtualized OS tree: linux, bsd, solaris, etc. In linux right now the xen version.h shows up as  /include/asm-xen/version.h.

This file uses typedefs for every important parameter. For example, typedef char [1024] xen_capabilities_info_t;. 

But as Greg says TYPEDEFS ARE EVIL. 

Last resort would be to use the funky gcc #include_next to override the xen hcall headers with a linux-specific hcall headers. But I don't know if that would be cool with lkml either. 

So, advice would be welcome :). 

thanks, 

Mike


-- 


