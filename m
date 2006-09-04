Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWIDHnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWIDHnj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWIDHni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:43:38 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:50152 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932460AbWIDHng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:43:36 -0400
Message-ID: <44FBD91B.2080600@garzik.org>
Date: Mon, 04 Sep 2006 03:43:23 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Andrew Morton <akpm@osdl.org>, sergio@sergiomb.no-ip.org,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, greg@kroah.com, harmon@ksu.edu,
       Daniel Drake <dsd@gentoo.org>, Len Brown <len.brown@intel.com>
Subject: Re: VIA IRQ quirk, another (embarrassing) suggestion.
References: <1157330567.3046.24.camel@localhost.portugal> <20060903175841.7a84c63c.akpm@osdl.org> <44FBBD28.6070601@garzik.org> <20060904055502.GA26816@tuatara.stupidest.org>
In-Reply-To: <20060904055502.GA26816@tuatara.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> Now, failing that, Jeff, what about if we try to use ACPI to detect if
> the PCI device is on-board or a plug-in card?  If we did and ignored
> them would that satisfy you?
> 
> Yes, I know this is yet-another horrible heuristic and might not work
> in all cases, but I think we need to aim to get the majority of
> systems broken working pretty promptly.  As Andrew said, this really
> is quire embarrassing right now.

It's not a question of me being satisfied or embarrassed.  The only 
question is what works for all cases.

My guess is that we need more complex logic to detect which devices are 
truly on-board.

Unfortunately for us, PCI cards with VIA SATA or VIA ethernet exist, so 
we cannot continue the current scheme of device ID enumeration either.

	Jeff



-- 
VGER BF report: H 0
