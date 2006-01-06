Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWAFWy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWAFWy2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWAFWy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:54:27 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:64493 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S964977AbWAFWyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:54:25 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [Bcm43xx-dev] [Fwd: State of the Union: Wireless]
To: Michael Buesch <mbuesch@freenet.de>, jgarzik@pobox.com,
       bcm43xx-dev@lists.berlios.de, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 06 Jan 2006 23:57:59 +0100
References: <5rXDU-5s4-7@gated-at.bofh.it> <5rXDU-5s4-5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1Ev0X3-0000tX-4l@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <mbuesch@freenet.de> wrote:

> How would the virtual interfaces look like? That is quite easy to answer.
> They are net_devices, as they transfer data.
> They should probaly _not_ be on top of the ethernet, as 80211 does not
> have very much in common with ethernet. Basically they share the same
> MAC address format. Does someone have another thing, which he thinks
> is shared?

<brainstorming>

It has a connection status.
It has a connection speed, which is less static than on a LAN.
(Maybe it can be asynchronous in the next version.)
It can't yet be full duplex, but who knows ...
It can be in promiscious mode (wardriving).

> The virtual interface is then configured though /dev/wlan0 using write()
> (no ugly ioctl anymore, you see...). Config data like TX rate,
> current essid,.... basically everything + xyz which is done by WE today,
> is written to /dev/wlan0.

In ASCII parsed by an in-kernel library? Did you consider sysfs?

What would a connection manager look for if it's supposed to act on
* plugging in the WLAN card
* finding/losing a (better) network

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
