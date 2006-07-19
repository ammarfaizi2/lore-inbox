Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWGSVM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWGSVM2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 17:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWGSVM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 17:12:28 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21710
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030314AbWGSVM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 17:12:28 -0400
Date: Wed, 19 Jul 2006 14:12:26 -0700 (PDT)
Message-Id: <20060719.141226.115911193.davem@davemloft.net>
To: keith.chew@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: network tx_timeout guidance
From: David Miller <davem@davemloft.net>
In-Reply-To: <20f65d530607191353p734e9392g1283dae9a7b14b1a@mail.gmail.com>
References: <20f65d530607191353p734e9392g1283dae9a7b14b1a@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Keith Chew" <keith.chew@gmail.com>
Date: Thu, 20 Jul 2006 08:53:28 +1200

> (2) What is the best way to simulate a Tx Timeout? Currently we have
> to wait for several days (for 1 of the 10 PCs under stress testing)
> for it to occur.

Make your netdev->hard_start_xmit() method simply record the
SKB, but don't actually give it to the hardware.
