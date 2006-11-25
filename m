Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967207AbWKYU5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967207AbWKYU5T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 15:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967206AbWKYU5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 15:57:19 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:30900 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S967207AbWKYU5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 15:57:18 -0500
X-Originating-Ip: 72.57.81.197
Date: Sat, 25 Nov 2006 15:54:18 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MPT:  make all Fusion MPT sub-choices singly selectable
In-Reply-To: <20061125121210.52c66f55.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.64.0611251548530.24225@localhost.localdomain>
References: <Pine.LNX.4.64.0611250627200.20370@localhost.localdomain>
 <20061125121210.52c66f55.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2006, Randy Dunlap wrote:

... snip ...

> Here's another option.  What do you think of it?

...

> --- linux-2.6.19-rc6-git8.orig/drivers/message/fusion/Kconfig
> +++ linux-2.6.19-rc6-git8/drivers/message/fusion/Kconfig
> @@ -1,14 +1,12 @@
>
> -menu "Fusion MPT device support"
> +menuconfig FUSION
> +	bool "Fusion MPT device support"
>
> -config FUSION
> -	bool
> -	default n
> +if FUSION

... more snip ...

  i suspect you already noticed that that's what i proposed in my
followup posting.  :-)  my first suggestion explicitly didn't mess
with the "Device Drivers" menu, only the underlying MPT submenu.

  my second posting went that extra step and added selection boxes to
the Device Drivers menu entries themselves, although your solution is
nicer than mine, surrounding the MPT entries with a single "if FUSION"
rather than my adding a dependency to every selection.

  i'm willing to come up with some patches that match your suggestion,
but what do others think of changing the fundamental layout of the
Device Drivers menu (and perhaps other menus) to that extent by adding
that extra selector?

rday
