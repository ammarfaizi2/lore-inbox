Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTE2Vwv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 17:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTE2Vwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 17:52:47 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:21633
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262874AbTE2VwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 17:52:17 -0400
Date: Thu, 29 May 2003 17:55:15 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
cc: Jeff Garzik <jgarzik@pobox.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "" <linux-kernel@vger.kernel.org>
Subject: RE: RFC Proposal to enable MSI support in Linux kernel
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E502413624E@orsmsx404.jf.intel.com>
Message-ID: <Pine.LNX.4.50.0305291752530.13731-100000@montezuma.mastecende.com>
References: <C7AB9DA4D0B1F344BF2489FA165E502413624E@orsmsx404.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 May 2003, Nguyen, Tom L wrote:

> I am working on an updated patch to 2.5.70 to incorporate the comments 
> from you and Jeff Garzik. Regarding the variable renaming of irq, I am 
> open to any suggestions. Please make a recommendation and I will 
> incorporate it into the next update.

Well essentially, if the function is being passed a vector, lets call the 
parameter 'vector', right now you have to look at the code paths careful 
to determine wether it's an irq number or a vector masquerading as an irq 
number.

> Regarding platform_legacy_irq, I have not seen an edge-triggered 
> interrupt failure caused by platform_legacy_irq.

So we can go with Jeff's suggestion there and remove the unecessary check 
for wether to assign level or edge?

	Zwane
-- 
function.linuxpower.ca
