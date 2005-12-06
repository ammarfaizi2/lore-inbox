Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932660AbVLFXUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbVLFXUL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 18:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbVLFXUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 18:20:10 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:53460
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932656AbVLFXUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 18:20:08 -0500
Date: Tue, 06 Dec 2005 15:19:19 -0800 (PST)
Message-Id: <20051206.151919.72043193.davem@davemloft.net>
To: laforge@gnumonks.org
Cc: davej@redhat.com, jgarzik@pobox.com, jbenc@suse.cz, josejx@gentoo.org,
       mbuesch@freenet.de, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, netdev@vger.kernel.org
Subject: Re: Broadcom 43xx first results
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051206151046.GF4038@rama.exocore.com>
References: <4394902C.8060100@pobox.com>
	<20051205195329.GB19964@redhat.com>
	<20051206151046.GF4038@rama.exocore.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harald Welte <laforge@gnumonks.org>
Date: Tue, 6 Dec 2005 20:40:47 +0530

> I'm also in favor of merging the devicescape code, but I don't see it
> happening without somebody taking care to provide all the required
> levels of interfaces (I see at least three levels of API's that a wireless
> driver would need, depending on how much stuff is done in
> hardware/firmware and how much in software.

I hate to say this, but part of the problem is exactly the fact
that all the implementors have implemented different levels of
hardware-MAC'ness in their wireless products.

Stated even further, things might have been more consistent if M$ had
specified a set of driver interfaces into their own softmac stack,
which I am to understand they are working on now.

So every M$ wireless driver essentially links in their own softmac
stack, if needed.

This has resulted in a complicated situation for an already
complicated technology.  Therefore, the fact that it's taking this
long to accomodate all of the cases in the vanilla tree is quite
understandable.

I'm at the point where I frankly don't care which softmac
implementation we go with, but rather I'm more concerned that we pick
_ONE_ and just stick with it, and then adding the necessary interfaces
and infrastructure as different wireless devices require.

Yes, you hear me right, it's more important to agree to one
implementation as the basis, even if it's the worst one currently.
Division of labor is something we simply cannot afford on the wireless
stack at this time.
