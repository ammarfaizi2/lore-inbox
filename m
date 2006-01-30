Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWA3R0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWA3R0n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWA3R0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:26:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:35757 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964790AbWA3R0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:26:42 -0500
Date: Mon, 30 Jan 2006 09:26:09 -0800
From: Greg KH <greg@kroah.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: [PATCH 2.6.12.6-xen] sysfs attributes for xen
Message-ID: <20060130172609.GA15949@kroah.com>
References: <43DAD4DB.4090708@us.ibm.com> <1138637931.19801.101.camel@localhost.localdomain> <43DE45A4.6010808@us.ibm.com> <1138640666.19801.106.camel@localhost.localdomain> <43DE4A1D.4050501@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DE4A1D.4050501@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 12:17:17PM -0500, Mike D. Day wrote:
> Dave Hansen wrote:
> >In the final version, there will be available Xen headers, and the patch
> >won't need the open-coded 1024?
> 
> Good question, I need some advice. The Xen hcall headers get soft-linked 
> into every paravirtualized OS tree: linux, bsd, solaris, etc. In linux 
> right now the xen version.h shows up as  /include/asm-xen/version.h.
> 
> This file uses typedefs for every important parameter. For example, typedef 
> char [1024] xen_capabilities_info_t;. 
> But as Greg says TYPEDEFS ARE EVIL. 

Then just make it a structure.  All the operating systems will be able
to handle that just fine :)

thanks,

greg k-h
