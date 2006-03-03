Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWCCQRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWCCQRx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 11:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWCCQRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 11:17:53 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:9470 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S932107AbWCCQRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 11:17:52 -0500
Date: Sat, 04 Mar 2006 01:17:47 +0900 (JST)
Message-Id: <20060304.011747.07644094.anemo@mba.ocn.ne.jp>
To: tbm@cyrius.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jbowler@acm.org
Subject: Re: [RFC] [PATCH 1/2] Driver to remember ethernet MAC values:
 maclist
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060220010113.GA19309@deprecation.cyrius.com>
References: <20060220010113.GA19309@deprecation.cyrius.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 20 Feb 2006 01:01:13 +0000, Martin Michlmayr <tbm@cyrius.com> said:

tbm> Some Ethernet hardware implementations have no built-in storage
tbm> for allocated MAC values - an example is the Intel IXP420 chip
tbm> which has support for Ethernet but no defined way of storing
tbm> allocated MAC values.  With such hardware different board level
tbm> implementations store the allocated MAC (or MACs) in different
tbm> ways.  Rather than put board level code into a specific Ethernet
tbm> driver this driver provides a generally accessible repository for
tbm> the MACs which can be written by board level code and read by the
tbm> driver.

Slow response:

It can be done with register_netdevice_notifier().  You can catch
NETDEV_REGISTER event, check the device is what you expected by
looking dev->irq or something, and initialize dev->dev_addr.  Whole
these can be implemented in your board level code.

---
Atsushi Nemoto
