Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWDFF2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWDFF2c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 01:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWDFF2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 01:28:32 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:47049
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932068AbWDFF2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 01:28:32 -0400
Date: Wed, 05 Apr 2006 22:28:31 -0700 (PDT)
Message-Id: <20060405.222831.67805286.davem@davemloft.net>
To: snakebyte@gmx.de
Cc: linux-kernel@vger.kernel.org, maxk@qualcomm.com
Subject: Re: [Patch] Possible double free in net/bluetooth/sco.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1144178718.12132.4.camel@alice>
References: <1144178718.12132.4.camel@alice>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sesterhenn <snakebyte@gmx.de>
Date: Tue, 04 Apr 2006 21:25:18 +0200

> this fixes coverity bug id #1068. 
> hci_send_sco() frees skb if (skb->len > hdev->sco_mtu).
> Since it returns a negative error value only in this case, we
> can directly return here.
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

This looks fine, applied.

Thanks.
