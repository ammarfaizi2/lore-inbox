Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266885AbUIORQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbUIORQV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUIORPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:15:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:52143 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266850AbUIORKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:10:01 -0400
Date: Wed, 15 Sep 2004 10:05:27 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Donald Duckie <schipperke2000@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: snull_load insmod: unresolved symbol
Message-Id: <20040915100527.60a05e24.rddunlap@osdl.org>
In-Reply-To: <20040915113434.80150.qmail@web53601.mail.yahoo.com>
References: <20040915113434.80150.qmail@web53601.mail.yahoo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004 04:34:34 -0700 (PDT) Donald Duckie wrote:

| hi!
| 
| has anyone ever tried compiling and running snull on
| Linux2.4.18-sh?
| 
| i tried compiling snull(without any modification) on
| Linux2.4.18-sh.
| upon running snull_load, i got the following:
| Using /lib/modules/2.4.18-sh/kernel/drivers/net/snull.
| insmod: unresolved symbol kmalloc_R93d4cfe6
| insmod: unresolved symbol skb_under_panic_R69955398
| insmod: unresolved symbol register_netdev_R09e03f58
| insmod: unresolved symbol eth_type_trans_R0a4e7a1c
| insmod: unresolved symbol unregister_netdev_R98eda3f8
| insmod: unresolved symbol printk_Rdd132261
| insmod: unresolved symbol __udivsi3_i4
| insmod: unresolved symbol memcpy_R11f7ce5e
| insmod: unresolved symbol jiffies_R0da02d67
| insmod: unresolved symbol alloc_skb_R0177038c
| insmod: unresolved symbol softnet_data_R258cb892
| insmod: unresolved symbol cpu_raise_softirq_R4d09166c
| insmod: unresolved symbol __kfree_skb_R1741771d
| insmod: unresolved symbol memset_R2bc95bd4
| insmod: unresolved symbol kfree_R037a0cba
| insmod: unresolved symbol netif_rx_R8316ccd0
| insmod: unresolved symbol ether_setup_R586ea93a
| insmod: unresolved symbol skb_over_panic_R4bb59969
| 
| can someone please tell me what's wrong with this,
| and how to fix this without chaning Linux versions?

You are building the module with module versioning turned on,
but your kernel is built without module versions, or it is built
with module versions, but they don't match your current kernel
source code.

You'll need to determine which is the case/problem and change
some part of that config.

--
~Randy
