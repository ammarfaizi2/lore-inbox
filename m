Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWGRKft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWGRKft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWGRKft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:35:49 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:39351 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S932170AbWGRKfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:35:47 -0400
In-Reply-To: <1153218477.3038.46.camel@laptopd505.fenrus.org>
References: <20060718091807.467468000@sous-sol.org> <20060718091958.414414000@sous-sol.org> <1153218477.3038.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <278d0ba5a24d74c5b590dd76d234c312@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: Ian Pratt <ian.pratt@xensource.com>, Jeremy Fitzhardinge <jeremy@goop.org>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 32/33] Add the Xen virtual network device driver.
Date: Tue, 18 Jul 2006 11:35:38 +0100
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Jul 2006, at 11:27, Arjan van de Ven wrote:

> Hmmm maybe it's me, but something bugs me if a NIC driver is going to
> send IP level ARP packets... that just feels very very wrong and is a
> blatant layering violation.... shouldn't the ifup/ifconfig scripts just
> be fixed instead if this is critical behavior?

Maybe we should be faking this out from our hotplug scripts in the 
control VM, although triggering this from user space is probably a bit 
of a pain. Regardless, the function can be removed from the driver if 
it's too distasteful: it's only a performance 'hack' to get network 
traffic more quickly redirected when migrating a VM between physical 
hosts. Things won't break horribly if it's removed.

  -- Keir

