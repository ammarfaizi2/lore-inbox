Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWAVDBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWAVDBQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 22:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWAVDBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 22:01:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:47504 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751259AbWAVDBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 22:01:15 -0500
Subject: Re: [PATCH] sungem: Make PM of PHYs more reliable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1137898747.12998.93.camel@localhost.localdomain>
References: <1137898747.12998.93.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 22 Jan 2006 14:01:09 +1100
Message-Id: <1137898869.12998.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-22 at 13:59 +1100, Benjamin Herrenschmidt wrote:
> On my latest laptop, I've had occasional PHY dead on wakeup from
> sleep... the PHY would be totally unresponsive even to toggling the hard
> reset line until the machine is powered down... Looking closely at the
> code, I found some possible issues in the way we setup the MDIO lines
> during suspend along with slight divergences from what Darwin does when
> resetting it that may explain the problem. That patch change these and
> the problem appear to be gone for me at least... I also fixed an mdelay
> -> msleep while I was at it to the pmac feature code that is called
> when toggling the PHY reset line since sungem doesn't call it in an
> atomic context anymore.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

Oops, -EWRONGPATCH... Sorry, please ignore it, I'll dig the right one...

Ben.


