Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbULFVuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbULFVuN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 16:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbULFVuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 16:50:13 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:4773
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261666AbULFVuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 16:50:11 -0500
Date: Mon, 6 Dec 2004 13:48:49 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Karsten Desler <kdesler@soohrt.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
Message-Id: <20041206134849.498bfc93.davem@davemloft.net>
In-Reply-To: <20041206205305.GA11970@soohrt.org>
References: <20041206205305.GA11970@soohrt.org>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004 21:53:05 +0100
Karsten Desler <kdesler@soohrt.org> wrote:

>  20017 ipt_do_table                              24.0589

It's spending nearly half of it's time in iptables.
Try to consolidate your rules if possible.  This is the
part of netfilter that really doesn't scale well at all.
