Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbUL1DXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbUL1DXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 22:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbUL1DXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 22:23:15 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:37798
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262042AbUL1DUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 22:20:19 -0500
Date: Mon, 27 Dec 2004 19:15:35 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/ipv4/: misc possible cleanups
Message-Id: <20041227191535.5edce690.davem@davemloft.net>
In-Reply-To: <20041215005139.GJ23151@stusta.de>
References: <20041215005139.GJ23151@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004 01:51:39 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> - remove the following unneeded EXPORT_SYMBOL:
>   - tcp_timer.c: tcp_timer_bug_msg

This one is wrong.  It is needed for the ipv6 module
via the call tcp_ipv6.c makes to tcp_done() which
invokes tcp_clear_xmit_timer() which uses
tcp_timer_bug_msg.
