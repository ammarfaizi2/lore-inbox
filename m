Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263247AbUCPAei (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263252AbUCPAeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:34:12 -0500
Received: from gate.crashing.org ([63.228.1.57]:36573 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263280AbUCPA3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:29:35 -0500
Subject: Re: consistent_sync_for_cpu() and friends on ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Olaf Hering <olh@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040315123647.4ce943b7.davem@redhat.com>
References: <20040315201616.GA31268@suse.de>
	 <20040315123647.4ce943b7.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1079396621.1967.196.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 11:23:42 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ben, can you work this out?  I can make it compile by just making the
> _for_cpu and _for_device routines behave identically to what the
> consisten_sync{,_page}() stuff does now.  But I'd much rather a ppc32
> person implement it correctly and optimally.
> 
> In short, the _for_device routines should make sure cacheable data in
> the cpu is fully visible to the DMA device, and _for_cpu should make
> sure all device DMA is visible to the processor.

BTW, I missed your explanation in the first place, but why wouldn't
the "direction" field be enough ? I'm not sure if I need a different
implementation here...

Ben.


