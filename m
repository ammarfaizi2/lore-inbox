Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVAHQvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVAHQvO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 11:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVAHQvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 11:51:14 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:13764 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261213AbVAHQuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 11:50:08 -0500
Subject: Re: [PATCH] 2.6.9 Use skb_padto() in drivers/net/8390.c]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Gortmaker <penguin@muskoka.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <41DF9AC1.2010609@muskoka.com>
References: <41DED9FA.7080106@pobox.com>  <41DF9AC1.2010609@muskoka.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105197689.10505.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 08 Jan 2005 15:45:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-01-08 at 08:33, Paul Gortmaker wrote:
> Is it possible that skb_padto has since got its act together?   Reason I
> ask is that I just dusted off a crusty 386dx40 (doesn't get much older

Could be - kmalloc has probably improved but the skbuffs have got far
more complex

> than that) with a wd8013.  As a basic test, I did ttcp Tx tests with small
> packets and they came out to all intents and purposes, identical.   Kernel 
> was 2.6.10, with stack vs skb_padto, each size test ran 3 times, even tested
> packets bigger than ETH_ZLEN as a (hopefully) invariant.  I've attached the
> edited down results below.

What are you testing ? I don't see the relationship between network
throughput and efficiency on this device.

Drop it on a pentium or late 486 and use the tsc to compare the two code
paths. One is much much more efficienct.

