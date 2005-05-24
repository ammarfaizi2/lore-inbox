Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVEXNHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVEXNHw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 09:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVEXNHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 09:07:52 -0400
Received: from styx.suse.cz ([82.119.242.94]:54202 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262038AbVEXNHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 09:07:44 -0400
Date: Tue, 24 May 2005 15:07:11 +0200
From: Jiri Benc <jbenc@suse.cz>
To: NetDev <netdev@oss.sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com, pavel@suse.cz
Subject: [0/5] Improvements to the ieee80211 layer
Message-ID: <20050524150711.01632672@griffin.suse.cz>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ieee80211 layer, now present in -mm, lacks many important features
(actually it's just a part of the ipw2100/ipw2200 driver; these cards do
a lot of the processing in the hardware/firmware and thus the layer
currently can not be used for simpler devices).

This is the first series of patches that try to convert it to a generic
IEEE 802.11 layer, usable for most of today's wireless cards.

The long term plan is:
- to implement a complete 802.11 stack in the kernel, making it easy to
  write drivers for simple (cheap) devices
- to implement all of Ad-Hoc, AP and monitor modes in the layer, so it
  will be easy to support them in the drivers
- to integrate Wireless Extensions to unify the kernel-userspace
  interface of all the drivers

This means that drivers for "stupid" (simple, cheap) cards should be
very short and easy to write, whereas drivers for "clever" cards will be
longer (but still shorter than they are now).

We have a couple of cards for testing, and we gradually modify the
drivers for ipw2100 and ipw2200 with the development of the layer. When
the layer is mature enough for the "stupid" cards, we will rewrite the
driver for Atheros-based cards to use this layer. We plan to send all
the patches for these drivers to the netdev list. Of course, we are in
close contact with Pavel Machek, who is pushing the ipw2100 driver
upstream.

Any comments and suggestions are appreciated.


Jiri Benc <jbenc@suse.cz> and Jirka Bohac <jbohac@suse.cz>
SUSE Labs
