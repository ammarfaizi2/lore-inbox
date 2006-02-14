Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161110AbWBNVDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbWBNVDe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161111AbWBNVDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:03:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19475 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1161110AbWBNVDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:03:33 -0500
Date: Tue, 14 Feb 2006 21:03:24 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Lord <lkml@rtr.ca>, "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add cast to __iomem pointer in scsi drivers
Message-ID: <20060214210324.GA13442@flint.arm.linux.org.uk>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, Mark Lord <lkml@rtr.ca>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <s5hzmktaecj.wl%tiwai@suse.de> <Pine.LNX.4.61.0602141530420.32364@chaos.analogic.com> <s5hu0b1ad2o.wl%tiwai@suse.de> <43F2419E.9060308@rtr.ca> <s5hslqlac86.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hslqlac86.wl%tiwai@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 09:59:05PM +0100, Takashi Iwai wrote:
> Yes, that'll be the best solution.  But, in these drivers, the same
> struct fields are used for both inl() and writel() depending on the
> flag, so you cannot change the type.

Which is why we have io{read|write}[bwl], iomap_port, etc.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
