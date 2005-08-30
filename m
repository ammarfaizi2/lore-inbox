Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbVH3VFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbVH3VFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 17:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVH3VFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 17:05:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52366 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932471AbVH3VFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 17:05:05 -0400
Date: Tue, 30 Aug 2005 14:05:16 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Steve Kieu <haiquy@yahoo.com>
Cc: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       Daniel Drake <dsd@gentoo.org>, Steve Kieu <haiquy@yahoo.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
Message-ID: <20050830140516.316e9695@dxpl.pdx.osdl.net>
In-Reply-To: <20050830205027.59306.qmail@web53609.mail.yahoo.com>
References: <20050830133918.42444cae@dxpl.pdx.osdl.net>
	<20050830205027.59306.qmail@web53609.mail.yahoo.com>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.6.7; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You have a version of the Marvell Yukon that was affected
by a fix in 2.6.13.
	skge addr 0xfeaf8000 irq 19 chip Yukon-Lite rev 9

Both the skge and sk98lin driver were fixed to check for this.
Without the fix, the chip will be in the wrong power mode.

The version of sk98lin driver from SysKonnect already had the
fix, so if your distro used that one, it would have the reset
the power mode as needed.
