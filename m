Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbTL3JN6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 04:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265707AbTL3JN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 04:13:58 -0500
Received: from mail.humboldt.co.uk ([81.2.65.18]:21691 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S265701AbTL3JN5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 04:13:57 -0500
Subject: Re: network driver that uses skb destructor
From: Adrian Cox <adrian@humboldt.co.uk>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: "Sirotkin, Alexander" <demiurg@ti.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20031229172402.GG13481@actcom.co.il>
References: <3FF05C27.5030706@ti.com>  <20031229172402.GG13481@actcom.co.il>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 30 Dec 2003 09:13:50 +0000
Message-Id: <1072775631.6557.11.camel@newt>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-29 at 17:24, Muli Ben-Yehuda wrote:

> I wrote a patch to allow chaining of skb destructors, which was fairly
> simple and would allow both the driver and the upper layers to set
> their destructors. If there's any interet, I could probably resurrect
> it.

It's interesting to me, for my work with PCI backplane networking, as it
would eliminate an extra packet copy on receive.

(The current non-transparent PCI bridges have an IOMMU in one direction
only. This means that one side of the bridge has to allocate its receive
buffers out of a small area.)

- Adrian Cox
http://www.humboldt.co.uk/


