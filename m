Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbUBZRyG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 12:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbUBZRyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 12:54:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:27078 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262829AbUBZRyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 12:54:03 -0500
Date: Thu, 26 Feb 2004 09:53:58 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "Nick Warne" <nick@ukfsn.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       "=?ISO-8859-1?B?RnLpZOlyaWM=?= L. W. Meunier" <1@pervalidus.net>
Subject: Re: 2.6.3 RT8139too NIC problems [NOT resolved]
Message-Id: <20040226095358.2bb53915@dell_ss3.pdx.osdl.net>
In-Reply-To: <403A6011.5674.103225D9@localhost>
References: <403A6011.5674.103225D9@localhost>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current 2.6.3 driver uses NAPI, and maybe that is related to your troubles.

What exactly is the hardware config (lspci output)?

There are debug messages produced, something like:
	eth0: Tx queue start entry 0  dirty entry 13
do you see these in dmesg output? or change your syslog.conf to capture
debug kernel messages to a different file.

Also, rebuild with RTL8139_DEBUG defined to pick up more info.

Seems like interrupts are getting disabled somehow.
