Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267812AbUG3Tqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267812AbUG3Tqx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 15:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267810AbUG3Tqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 15:46:48 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:39815 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S267814AbUG3Tqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 15:46:33 -0400
Date: Fri, 30 Jul 2004 21:46:34 +0200
From: Martin Mares <mj@ucw.cz>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Matthew Wilcox <willy@debian.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Exposing ROM's though sysfs
Message-ID: <20040730194634.GA4851@ucw.cz>
References: <20040730193559.GA4687@ucw.cz> <20040730193932.20813.qmail@web14923.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730193932.20813.qmail@web14923.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The caching is only going to happen for cards with minimal address
> decoder implementations. As far as I know there is only one card that
> does this.

Yes, but ...

(1) it doesn't change the fact that the caching is in the vast majority
of cases just wasting of RAM, even if it will happen only with a couple
of cards.

(2) not all drivers dwell in the kernel.

I would prefer keeping sysfs access the ROM directly, with a little
work-around disabling the sysfs file for the devices known for sharing
decoders and to offer a boot-time parameter for forcing the copy in case
you really need such feature for that particular device.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
return(EIEIO); /* Here-a-bug, There-a-bug... */
