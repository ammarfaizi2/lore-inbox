Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263808AbTKKX0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 18:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbTKKX0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 18:26:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:31444 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263808AbTKKX0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 18:26:12 -0500
Date: Tue, 11 Nov 2003 15:30:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: jhf@rivenstone.net (Joseph Fannin)
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [OOPS] TLAN fails on ifconfig with CONFIG_HOTPLUG=n
Message-Id: <20031111153013.3b9eba6e.akpm@osdl.org>
In-Reply-To: <20031111222933.GA2868@rivenstone.net>
References: <20031111222933.GA2868@rivenstone.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jhf@rivenstone.net (Joseph Fannin) wrote:
>
>     I'm getting an Oops when ifup'ing a Compaq Netelligent card that
>  uses the tlan driver running 2.6.

Does this fix it?

diff -puN drivers/net/tlan.c~tlan-oops-fix drivers/net/tlan.c
--- 25/drivers/net/tlan.c~tlan-oops-fix	2003-11-11 15:29:32.000000000 -0800
+++ 25-akpm/drivers/net/tlan.c	2003-11-11 15:29:38.000000000 -0800
@@ -234,7 +234,7 @@ static struct board {
 	const char	*deviceLabel;
 	u32	   	flags;
 	u16	   	addrOfs;
-} board_info[] __devinitdata = {
+} board_info[] = {
 	{ "Compaq Netelligent 10 T PCI UTP", TLAN_ADAPTER_ACTIVITY_LED, 0x83 },
 	{ "Compaq Netelligent 10/100 TX PCI UTP", TLAN_ADAPTER_ACTIVITY_LED, 0x83 },
 	{ "Compaq Integrated NetFlex-3/P", TLAN_ADAPTER_NONE, 0x83 },

_

