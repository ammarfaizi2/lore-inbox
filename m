Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbVAQEsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbVAQEsP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 23:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVAQEsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 23:48:15 -0500
Received: from gate.crashing.org ([63.228.1.57]:713 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262687AbVAQEsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 23:48:10 -0500
Subject: Re: [PATCH] PPC64 pmac hotplug cpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Linux PPC64 <linuxppc64-dev@ozlabs.org>,
       Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0501162129380.3010@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0501122341410.23299@montezuma.fsmlabs.com>
	 <1105827794.27410.82.camel@gaston>
	 <Pine.LNX.4.61.0501162129380.3010@montezuma.fsmlabs.com>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 15:47:46 +1100
Message-Id: <1105937266.4534.0.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-16 at 21:37 -0700, Zwane Mwaikambo wrote:
> Hello Ben,
> 
> On Sun, 16 Jan 2005, Benjamin Herrenschmidt wrote:
> 
> > Looks good, but you could do even better :) I still want to look at the
> > proper mecanism to flush the CPU cache on 970, but the idea here is to
> > flush it, and put the CPU into a NAP loop (the 970 has no SLEEP mode)
> > with the caches clean and MSR:EE off. We can later get it back with a
> > soft reset.
> 
> Thanks for the suggestions! I'll work on getting something together.

Well.. the cache flush part requires some not-really-documentd stuff on
the 970, but I'll try to come up with something.

Ben.


