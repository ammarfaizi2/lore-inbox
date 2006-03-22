Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWCVLO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWCVLO0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 06:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWCVLO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 06:14:26 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:6360 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1750847AbWCVLOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 06:14:25 -0500
In-Reply-To: <1143017601.2955.33.camel@laptopd505.fenrus.org>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063807.597300000@sorel.sous-sol.org> <1143017601.2955.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8de96373b7e6ab59494b4b9ef1fb29c5@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 33/35] Add the Xenbus sysfs and virtual device hotplug driver.
Date: Wed, 22 Mar 2006 11:14:43 +0000
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Mar 2006, at 08:53, Arjan van de Ven wrote:

>> +char *kasprintf(const char *fmt, ...)
>> +{
>
> this should take a gfp mask most likely

It's internal to xenbus driver, where it is used only in safe kernel 
thread contexts where GFP_KERNEL is okay. Adding a gfp mask would just 
clutter the interface I think.

  -- Keir

