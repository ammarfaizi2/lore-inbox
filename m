Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWIYAZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWIYAZd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 20:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbWIYAZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 20:25:33 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:57520 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751484AbWIYAZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 20:25:33 -0400
Message-ID: <451721F8.4060600@pobox.com>
Date: Sun, 24 Sep 2006 20:25:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: NV SATA breakage: jgarzik/libata-dev#upstream etc
References: <m3wt7tm6sh.fsf@defiant.localdomain>
In-Reply-To: <m3wt7tm6sh.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Hi,
> 
> The following commit in libata-dev breaks NV SATA init - I don't
> have a dump handy, but the problem is a NULL ptr dereference here:
> 
> libata-core.c
> int ata_device_add(const struct ata_probe_ent *ent)
> {
> ...
>         /* register each port bound to this device */
>         for (i = 0; i < host->n_ports; i++) {
> ...
>                 /* start port */
>                 rc = ap->ops->port_start(ap);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> The problematic commit is fea63e38013ec628ab3f7fddc4c2148064b7910a:
> "[PATCH] libata: fix non-uniform ports handling
> 
> Non-uniform ports handling got broken while updating libata to handle
> those in the same host.  Only separate irq for the non-uniform
> secondary port was implemented while all other fields (host flags,
> transfer mode...) of the secondary port simply shared those of the
> first.

What's broken, and how does it affect NV sata?

That's the chipset on my main dev workstation, and there are no problems 
here...

	Jeff



