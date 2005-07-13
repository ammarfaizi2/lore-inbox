Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVGMXTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVGMXTm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 19:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVGMXTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 19:19:02 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:16047 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262148AbVGMXRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 19:17:05 -0400
Date: Thu, 14 Jul 2005 03:16:33 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Bridge changes and lost console on 2.6.13-rc3
Message-ID: <20050714031633.A25768@jurassic.park.msu.ru>
References: <9e4733910507130952372a5bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9e4733910507130952372a5bd@mail.gmail.com>; from jonsmirl@gmail.com on Wed, Jul 13, 2005 at 12:52:21PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 12:52:21PM -0400, Jon Smirl wrote:
> My machine has two child buses, AGP and PCI. I am using a PCI video
> card at 02:03.0. Only the card on bus #2 fails, the AGP card is ok. 
> Are you setting the VGA port forwarding bits correctly on the bridge
> #2 if it is the active display device?

Good catch. Actually we enable bridge VGA port forwarding for *all*
VGA devices, which is obviously incorrect.
It seems that we could safely drop VGA bits from setup-bus.c.
I'll do some testing and post a patch tomorrow.

Ivan.
