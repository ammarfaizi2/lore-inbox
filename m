Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263907AbUDPWsv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbUDPWp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:45:58 -0400
Received: from mail.ccur.com ([208.248.32.212]:22286 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S263916AbUDPWoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:44:23 -0400
Date: Fri, 16 Apr 2004 18:44:22 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Linux NICS <linux.nics@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] e1000 fails on 2.4.26+bk with CONFIG_SMP=y
Message-ID: <20040416224422.GA19095@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The e1000 driver fails to operate an Intel PRO/1000 MT Quad Port Server
Adaptor under the latest 2.4.26+bk with CONFIG_SMP=y.  It works fine
when CONFIG_SMP=n.

netstat -i shows packets being transmitted and received with ~1/2 of the
received packets being errors.

This is a Dell 650 configured with 4 (hyperthreaded) CPUs.  E1000 driver
version is 5.2.39-k1.

Regards,
Joe

good (uniproc) netstat -i:

Iface     MTU Met   RX-OK RX-ERR RX-DRP RX-OVR   TX-OK TX-ERR TX-DRP TX-OVR Flg
eth1     1500   0      72      0      0      0      10      0      0      0 BMRU
lo      16436   0      88      0      0      0      88      0      0      0 LRU

bad (smp) netstat -i:

Iface     MTU Met   RX-OK RX-ERR RX-DRP RX-OVR   TX-OK TX-ERR TX-DRP TX-OVR Flg
eth1     1500   0     516    214    214      0       3      0      0      0 BMRU
lo      16436   0      75      0      0      0      75      0      0      0 LRU
