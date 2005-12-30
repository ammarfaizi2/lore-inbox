Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVL3Rzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVL3Rzs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 12:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVL3Rzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 12:55:48 -0500
Received: from cluster1.g-wis.com ([204.250.154.18]:42002 "EHLO
	cluster1.g-wis.com") by vger.kernel.org with ESMTP id S1751269AbVL3Rzr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 12:55:47 -0500
Thread-Index: AcYNakO+oLJSxaLcS7GqR2MdE3kouQ==
X-Received-From-Address: 66.220.104.32
X-Envelope-From: greg@kroah.com
Date: Fri, 30 Dec 2005 00:00:02 -0800
Content-Transfer-Encoding: 7bit
From: "Greg KH" <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: <linux-kernel@vger.kernel.org>, <openib-general@openib.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Content-Class: urn:content-classes:message
Importance: normal
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver
Message-ID: <20051230080002.GA7438@kroah.com>
References: <patchbomb.1135816279@eng-12.pathscale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <patchbomb.1135816279@eng-12.pathscale.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 30 Dec 2005 17:55:47.0601 (UTC) FILETIME=[43740810:01C60D6A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 04:31:19PM -0800, Bryan O'Sullivan wrote:
> 
> There are a few requested changes we have chosen to omit for now:
> 
>   - The driver still uses EXPORT_SYMBOL, for consistency with other
>     code in drivers/infiniband

Why would that matter?

>   - Someone asked for the kernel's i2c infrastructure to be used, but
>     our i2c usage is very specialised, and it would be more of a mess
>     to use the kernel's

Why is this?  What is so messy about the in-kernel i2c interfaces?
(yeah, I know that there are some oddities, just want to know what you
specifically are not liking...)

>   - We're still using ioctls instead of sysfs or configfs in some
>     cases, to maintain userspace compatibility

Compatibility with what?  The driver isn't in the kernel tree yet, so
there's no old kernel versions to remain compatibile with :)

I also noticed that you are still using the uint64_t type variable
types, can you please switch to the proper kernel types instead (u64 in
this specific example.)

thanks,

greg k-h
