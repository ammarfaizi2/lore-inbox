Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbVLSB71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbVLSB71 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 20:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbVLSB71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 20:59:27 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52203
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030233AbVLSB70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 20:59:26 -0500
Date: Sun, 18 Dec 2005 17:59:38 -0800 (PST)
Message-Id: <20051218.175938.54428509.davem@davemloft.net>
To: kay.sievers@vrfy.org
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: net: swich device attribute creation to default attrs
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051219004256.GA29285@vrfy.org>
References: <20051219004256.GA29285@vrfy.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kay Sievers <kay.sievers@vrfy.org>
Date: Mon, 19 Dec 2005 01:42:56 +0100

> Recent udev versions don't longer cover bad sysfs timing with built-in
> logic. Explicit rules are required to do that. For net devices, the
> following is needed:
>   ACTION=="add", SUBSYSTEM=="net", WAIT_FOR_SYSFS="address"
> to handle access to net device properties from an event handler without
> races.
> 
> This patch changes the main net attributes to be created by the driver
> core, which is done _before_ the event is sent out and will not require
> the stat() loop of the WAIT_FOR_SYSFS key.

Kay/Greg, this looks fine, feel free to merge it in.
