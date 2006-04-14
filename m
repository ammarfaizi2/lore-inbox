Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbWDNVCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbWDNVCm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWDNVCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:02:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:57516 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965162AbWDNVCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:02:42 -0400
Subject: Re: [PATCH] pcmcia/pcmcia_resource.c: fix crash when using Cardbus
	cards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-pcmcia@lists.infradead.org,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200604141742.13553.daniel.ritz-ml@swissonline.ch>
References: <200604141742.13553.daniel.ritz-ml@swissonline.ch>
Content-Type: text/plain
Date: Sat, 15 Apr 2006 06:59:09 +1000
Message-Id: <1145048349.4223.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-14 at 17:42 +0200, Daniel Ritz wrote:
> [PATCH] pcmcia/pcmcia_resource.c: fix crash when using Cardbus cards
> 
> using the old ioctl interface together with cardbus card gives a NULL
> pointer dereference since cardbus devices don't have a struct pcmcia_device.
> also s->io[0].res can be NULL as well.
> 
> fix is to move the pcmcia code after the cardbus code and to check for a null
> pointer.

Also note that when the card is inserted, cardctl info does print some
useful infos while pccardctl info will display nothing (empty strings).

Ben.


