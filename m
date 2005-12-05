Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbVLEOUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbVLEOUA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 09:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVLEOUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 09:20:00 -0500
Received: from mail2.genealogia.fi ([194.100.116.229]:18084 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP
	id S1751362AbVLEOUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 09:20:00 -0500
Date: Mon, 5 Dec 2005 06:19:35 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Michael Buesch <mbuesch@freenet.de>
Cc: bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       Feyd <feyd@seznam.cz>
Subject: Re: [Bcm43xx-dev] Broadcom 43xx first results
Message-ID: <20051205141935.GC8940@jm.kir.nu>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <200512042058.30801.mbuesch@freenet.de> <20051205055012.GE8953@jm.kir.nu> <200512051208.16241.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512051208.16241.mbuesch@freenet.de>
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 12:08:16PM +0100, Michael Buesch wrote:

> The SoftMAC is a separate module. That is _good_, so devices like
> the ipw do not have to load the code, because they do not need it.
> The SoftMAC ties (and integrates) very close to the ieee80211 subsystem.

I like the modular design..

> You see that SoftMAC is not exactly a part or the ieee80211 subsystem,
> but it uses its interface to TX a frame (and the struct to get
> some information about the device).

.. but I disagree with this. If there is functionality like generating
management frames, it is very much part of the ieee80211 subsystem in my
opinion.

> This all works fine. There is absolutely no need to bloat the
> ieee80211 layer with functionality, which is not needed by all devices.

I'm afraid of this leading to duplicated work since ieee80211 stack is
being used without this new SoftMAC code for devices that do need host
CPU to take care of functionality that is currently in SoftMAC module
and will be added to ieee80211 subsystem.

-- 
Jouni Malinen                                            PGP id EFC895FA
