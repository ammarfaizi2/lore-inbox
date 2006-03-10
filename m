Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWCJElm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWCJElm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 23:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWCJElm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 23:41:42 -0500
Received: from mx.pathscale.com ([64.160.42.68]:46241 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751348AbWCJElm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 23:41:42 -0500
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and
	lightweight subnet management
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <gregkh@suse.de>
Cc: Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20060310010403.GC9945@suse.de>
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
	 <ada8xrjfbd8.fsf@cisco.com>
	 <1141948367.10693.53.camel@serpentine.pathscale.com>
	 <20060310004505.GB17050@suse.de>
	 <1141951725.10693.88.camel@serpentine.pathscale.com>
	 <20060310010403.GC9945@suse.de>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 20:41:36 -0800
Message-Id: <1141965696.14517.4.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 17:04 -0800, Greg KH wrote:

> > I don't expect this to be a practical problem.  We're planning to add
> > hotplug support to the driver once we have some cycles free.
> 
> Ugh, that means it's never going to be there.
> 
> All new PCI drivers have the requirement that they work properly in
> hotplug systems, as they should follow the PCI core api.  If not, odds
> are they will not be accepted into the tree :(

Okay, maybe we're talking at cross purposes here.  We do follow the PCI
core API.  We have a __devinit probe and __devexit remove routine, a
MODULE_DEVICE_TABLE, the kernel generates hotplug events when a device
is detected or the driver is unloaded, and so on.

I *assumed* that there was something more that we would need to do in
order to support real hotplug of actual physical cards, but now that I
look more closely, it doesn't appear that there is.  At least, there's
nothing in Documentation/pci.txt or LDD3 that indicates to me that we
ought to be doing more.

Am I missing something?

	<b

