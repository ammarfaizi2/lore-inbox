Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWBVWmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWBVWmy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWBVWmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:42:54 -0500
Received: from natipslore.rzone.de ([81.169.145.179]:42716 "EHLO
	natipslore.rzone.de") by vger.kernel.org with ESMTP
	id S1751031AbWBVWmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:42:54 -0500
From: Stefan Rompf <stefan@loplof.de>
To: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdev/uevent
Date: Wed, 22 Feb 2006 23:37:34 +0100
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602222337.34755.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Ogrisegg wrote:

> What do you mean with "ethtool and netlink"? At least the current
> release of ethtool does not seem to have any netlink support.

You can listen to RTMGRP_LINK on NETLINK_ROUTE. IFF_RUNNING will give you the 
link state information you're looking for.

For you application scenario: I'm working on a DHCP client that uses this 
netlink information, so don't invent the wheel twice ;-)

Stefan
