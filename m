Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVAaTza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVAaTza (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVAaTxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:53:39 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:36324
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261344AbVAaTwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:52:21 -0500
Date: Mon, 31 Jan 2005 11:46:40 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: SIOCGIFMAP silently broken?
Message-Id: <20050131114640.7e002652.davem@davemloft.net>
In-Reply-To: <41FE4745.4020003@fujitsu-siemens.com>
References: <41FE4745.4020003@fujitsu-siemens.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005 15:57:09 +0100
Martin Wilck <martin.wilck@fujitsu-siemens.com> wrote:

> In both cases, the netdev->irq field isn't used anymore; perhaps it 
> should be officially deprecated and/or removed?

It is used for explicitly setting the IRQ value on hardware
where doing so automatically via probing may not be %100
reliable, such as on ISA.

Another way to do what you're trying to do is to look for
the string name of the device you are interested in within
the output of /proc/interrupts.
