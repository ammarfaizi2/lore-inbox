Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbUC3PUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUC3PUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:20:30 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:51392 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263708AbUC3PSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:18:41 -0500
Subject: Re: Migrate pages from a ccNUMA node to another - patch
From: Dave Hansen <haveblue@us.ibm.com>
To: Zoltan.Menyhart@bull.net
Cc: linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <40695C68.4A5F551E@nospam.org>
References: <4063F581.ACC5C511@nospam.org>
	 <1080321646.31638.105.camel@nighthawk>  <40695C68.4A5F551E@nospam.org>
Content-Type: text/plain
Message-Id: <1080659885.3646.2106.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Mar 2004 07:18:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-30 at 03:39, Zoltan Menyhart wrote:
> Dave Hansen wrote:
> > 
> > Have you considered any common ground your patch might share with the
> > people doing memory hotplug?
> 
> Comparing my stuff to their work, I just do some small performance enhancements:
> 
> - I do not modify a single line on the existing VM paths - if my stuff has no
>   improvement for you, then yo will not be obliged to pay any overhead
...
> - I handle only the simplest case: private anonymous pages (...a singe PTE...)

By not modifying a single line in the existing VM path, your patch
simply duplicates functionality from that existing code, which I'm not
sure is any better.  

I think there's a lot of commonality with what the swap code, NUMA page
migration, and memory removal have to do.  However, none of them share
any code today.  I think all of the implementations could benefit from
making them a bit more generic.  

-- Dave

