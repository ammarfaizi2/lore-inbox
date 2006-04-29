Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWD2VOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWD2VOV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 17:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWD2VOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 17:14:21 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37261 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750803AbWD2VOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 17:14:20 -0400
Subject: Re: better leve triggered IRQ management needed
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060424114105.113eecac@localhost.localdomain>
References: <20060424114105.113eecac@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 29 Apr 2006 22:25:11 +0100
Message-Id: <1146345911.3302.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-24 at 11:41 -0700, Stephen Hemminger wrote:
> I am seeing repeated problems with misconfigured systems that have shared IRQ
> devices configured for edge-triggered.

I've been thinking about this a chunk more. The embedded folks have been
having a related argument about SA_EDGE and SA_LEVEL or similar. On some
embedded platforms the driver really has to pass this information
according to the board configuration.

Trying to guess the current IRQ level v edge on a PC is very hard.
Trying to set it correctly from the driver is rather easier.

