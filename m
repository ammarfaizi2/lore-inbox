Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbTD2Kyv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 06:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbTD2Kyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 06:54:51 -0400
Received: from rth.ninka.net ([216.101.162.244]:43467 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261338AbTD2Kys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 06:54:48 -0400
Subject: RE: Broadcom BCM4306/BCM2050  support
From: "David S. Miller" <davem@redhat.com>
To: Martin List-Petersen <martin@list-petersen.dk>
Cc: bas.mevissen@hetnet.nl, linux-kernel@vger.kernel.org
In-Reply-To: <1051596982.3eae18b640303@roadrunner.hulpsystems.net>
References: <1051596982.3eae18b640303@roadrunner.hulpsystems.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051614381.21135.5.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Apr 2003 04:06:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-28 at 23:16, Martin List-Petersen wrote:
> > I couldn't find any Linux support for these WLAN chips with 
> > google or on this lists archives. So I would like to ask it here:
> 
> It seems, that the specs haven't been released yet. There are quite a few Wlan
> cards out there based on the Broadcom chips (nearly all cards, that support
> 802.11g), so it's quite a shame. (Actually this fits the the TrueMobile 1180,
> 1300 and 1400, speaking of Dell wireless lan cards).
...
> The same problem is with the Intel Prowireless 2100 (Centrino) WLan card. No
> Linux support available yet, which is another choice for the Dell notebooks at
> the moment.

Don't expect specs or opensource drivers for any of these pieces
of hardware until these vendors figure out a way to hide the frequency
programming interface.

Ie. these cards can be programmed to transmit at any frequency,
and various government agencies don't like it when f.e. users can
transmit on military frequencies and stuff like that.

The only halfway plausible idea I've seen is to not document the
frequency programming registers, and users get a "region" key file that
has opaque register values to program into the appropriate registers.
The file is per-region (one for US, Germany, etc.)and the wireless
kernel driver reads in this file to do the frequency programming.

So don't blame the vendors on this one, several of them would love
to publish drivers public for their cards, but simply cannot with
upsetting federal regulators.

-- 
David S. Miller <davem@redhat.com>
