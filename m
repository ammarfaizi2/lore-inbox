Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933541AbWAORyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933541AbWAORyO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 12:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933548AbWAORyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 12:54:14 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:7382 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S933559AbWAORyM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 12:54:12 -0500
From: Stefan Rompf <stefan@loplof.de>
To: "Johannes Berg" <johannes@sipsolutions.net>
Subject: Re: wireless: recap of current issues (configuration)
Date: Sun, 15 Jan 2006 18:53:31 +0100
User-Agent: KMail/1.8
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060113195723.GB16166@tuxdriver.com> <200601151340.10730.stefan@loplof.de> <56187.84.135.205.30.1137340292.squirrel@secure.sipsolutions.net>
In-Reply-To: <56187.84.135.205.30.1137340292.squirrel@secure.sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601151853.31710.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag 15 Januar 2006 16:51 schrieb Johannes Berg:

> Isn't that rather a question of having good user-space tools that make
> deactivating one type of interface and activating another seamless?

Well, it's always easy to point to userspace. However, unregister_netdev() 
initiates a lot of actions. IPv4 addresses and routes are removed, same for 
IPv6, IPX, Appletalk etc. Stacked VLAN devices are recursively unregistered 
(even though I have not tried yet if it works when I create VLANs over 802.3 
emulated wlan interfaces ;-), udev bloat runs. And all this stuff has to be 
restored by the nifty new configuration utility, possibly including ifindex 
and future protocols.

This is from my usage pattern that I want to go into monitor mode on current 
channel, look at some packets and return to the association without losing 
layer 3 configuration.

So after all, it is IMHO way less painful to handle a mode change in the 
kernel.

Stefan
