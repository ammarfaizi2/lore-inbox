Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVARAvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVARAvm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 19:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVARAvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 19:51:42 -0500
Received: from gate.crashing.org ([63.228.1.57]:5075 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261370AbVARAvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 19:51:41 -0500
Subject: Re: [PATCH] PPC64 pmac hotplug cpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux PPC64 <linuxppc64-dev@ozlabs.org>,
       Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <41EBD662.1080409@nortelnetworks.com>
References: <Pine.LNX.4.61.0501122341410.23299@montezuma.fsmlabs.com>
	 <1105827794.27410.82.camel@gaston>
	 <Pine.LNX.4.61.0501162129380.3010@montezuma.fsmlabs.com>
	 <1105937266.4534.0.camel@gaston>  <41EBD662.1080409@nortelnetworks.com>
Content-Type: text/plain
Date: Tue, 18 Jan 2005 11:49:15 +1100
Message-Id: <1106009355.4533.19.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-17 at 09:14 -0600, Chris Friesen wrote:
> Benjamin Herrenschmidt wrote:
> 
> > Well.. the cache flush part requires some not-really-documentd stuff on
> > the 970, but I'll try to come up with something.
> 
> Details?  We've got a cache-flush routine put together based on the 
> documentation that seems to be working, but if there's something else 
> that has to be done I'd love to know about it.

Well, I don't have all the details at hand right now, but it involves
using SCOM (with appropriate workarounds for CPU SCOM bugs on some
970's) to switch the L2 to direct addressing iirc.

Ben.


