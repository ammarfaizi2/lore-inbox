Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbVIZRic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVIZRic (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 13:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVIZRic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 13:38:32 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:47044 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932394AbVIZRib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 13:38:31 -0400
Subject: Re: [PATCH 2.6.14-rc2] aoe [1/2]: explicitly set minimum packet
	length to ETH_ZLEN
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
In-Reply-To: <87hdc7ept7.fsf@coraid.com>
References: <87oe6fhj8y.fsf@coraid.com>  <87hdc7ept7.fsf@coraid.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Sep 2005 19:05:32 +0100
Message-Id: <1127757933.27757.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-09-26 at 12:50 -0400, Ed L Cashin wrote:
> >  	skb = alloc_skb(len, GFP_ATOMIC);
> 
> This change fixes some strange problems observed on a system that was
> using the e1000 network driver.  Is the network driver supposed to
> ensure that ethernet packets are up to spec, at least 60 bytes long?

The network driver is supposed to pad frames if the hardware cannot and
to blank the spare bits. If it isn't occurring please try and trace down
the offender.

