Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWCJE6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWCJE6P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 23:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWCJE6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 23:58:15 -0500
Received: from mx.pathscale.com ([64.160.42.68]:53666 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751392AbWCJE6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 23:58:14 -0500
Subject: Re: Revenge of the sysfs maintainer! (was Re: [PATCH 8 of 20]
	ipath - sysfs support for core driver)
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <gregkh@suse.de>
Cc: Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20060310010050.GA9945@suse.de>
References: <ef8042c934401522ed3f.1141922821@localhost.localdomain>
	 <adapskvfbqe.fsf@cisco.com>
	 <1141947143.10693.40.camel@serpentine.pathscale.com>
	 <20060310003513.GA17050@suse.de>
	 <1141951589.10693.84.camel@serpentine.pathscale.com>
	 <20060310010050.GA9945@suse.de>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 20:58:13 -0800
Message-Id: <1141966693.14517.20.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 17:00 -0800, Greg KH wrote:

> They are in the latest -mm tree if you wish to use them.  Unfortunatly
> it might look like they will not work out, due to the per-cpu relay
> files not working properly with Paul's patches at the moment.

Hmm, OK.

> What's wrong with debugfs?

It's not configured into the kernels of either of the distros I use (Red
Hat or SUSE).  I can't have a required part of my driver depend on a
feature that's not enabled in the major distro kernels.

I'd like a mechanism that is (a) always there (b) easy for kernel to use
and (c) easy for userspace to use.  A sysfs file satisfies a, b, and c,
but I can't use it; a sysfs bin file satisfies all three (a bit worse on
b), but I can't use it; debugfs isn't there, so I can't use it.

That leaves me with few options, I think.  What do you suggest?  (Please
don't say netlink.)

	<b

