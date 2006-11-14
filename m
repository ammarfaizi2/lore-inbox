Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755403AbWKNDDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755403AbWKNDDM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 22:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755406AbWKNDDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 22:03:12 -0500
Received: from gate.crashing.org ([63.228.1.57]:19923 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1755403AbWKNDDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 22:03:11 -0500
Subject: Re: [PATCH/RFC] powerpc: Fix mmap of PCI resource with hack for X
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ian Romanick <idr@us.ibm.com>
Cc: David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, anton@samba.org, airlied@gmail.com,
       paulus@samba.org
In-Reply-To: <455926C0.9080906@us.ibm.com>
References: <1163405790.4982.289.camel@localhost.localdomain>
	 <20061113.163138.98554015.davem@davemloft.net>
	 <455926C0.9080906@us.ibm.com>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 14:02:51 +1100
Message-Id: <1163473371.5940.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > So the gist of your change is that X isn't obtaining BAR values
> > in the correct context on powerpc, and so you're going to hack up
> > the "devices" files output to "help" X out.
> > 
> > This doesn't sound sane to me.
> 
> It doesn't sound terribly sane to me.  What's wrong with just opening
> /sys/bus/pci/devices/*/resource[0-5]?  It seems like that solves all the
> problems.

We have to, that's how we get current X to work. Of course it will be
much better once X uses sysfs, no question about that.

Ben.


