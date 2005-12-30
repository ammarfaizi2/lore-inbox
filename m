Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbVL3XLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbVL3XLq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 18:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbVL3XLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 18:11:46 -0500
Received: from mx.pathscale.com ([64.160.42.68]:26266 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964939AbVL3XLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 18:11:45 -0500
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051230080002.GA7438@kroah.com>
References: <patchbomb.1135816279@eng-12.pathscale.com>
	 <20051230080002.GA7438@kroah.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 30 Dec 2005 15:11:44 -0800
Message-Id: <1135984304.13318.50.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 00:00 -0800, Greg KH wrote:

> >   - The driver still uses EXPORT_SYMBOL, for consistency with other
> >     code in drivers/infiniband
> 
> Why would that matter?

I don't want to do something gratuitously different to the prevailing
set of code in which it lives.

> >   - We're still using ioctls instead of sysfs or configfs in some
> >     cases, to maintain userspace compatibility
> 
> Compatibility with what?  The driver isn't in the kernel tree yet, so
> there's no old kernel versions to remain compatibile with :)

We already ship userspace code to customers that relies on the ioctl
interfaces.

> I also noticed that you are still using the uint64_t type variable
> types, can you please switch to the proper kernel types instead (u64 in
> this specific example.)

Yes, we'll use u64 for internal variables, and __u64 for stuff exported
to userspace, etc.

	<b

