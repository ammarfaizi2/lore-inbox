Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbUKOXcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbUKOXcY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUKOXcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:32:23 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:35038
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261630AbUKOXaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:30:10 -0500
Date: Mon, 15 Nov 2004 15:15:25 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Patrick McHardy <kaber@trash.net>
Cc: david+challenge-response@blue-labs.org, linux-kernel@vger.kernel.org,
       sri@us.ibm.com, netfilter-devel@lists.netfilter.org
Subject: Re: iptables OOPS (all recent kernels on x86_64)
Message-Id: <20041115151525.164cc207.davem@davemloft.net>
In-Reply-To: <41986353.1020800@trash.net>
References: <41984CCC.9040800@blue-labs.org>
	<41986353.1020800@trash.net>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2004 09:05:39 +0100
Patrick McHardy <kaber@trash.net> wrote:

> David Ford wrote:
> 
> > Up until 2.6.9, when I changed link status after the initial 
> > configuration, I would get a kernel OOPS.  Now with 2.6.9, I get a 
> > crash immediately on boot with network device configuration.   
> > Attached is my boot log.
> 
> Apparently SCTP corrupted the inetaddr notifier chain by registering
> the same notifier_block for IPv4 and IPv6, so masq_inet_event got a
> struct inet6_ifaddr instead of a struct in_ifaddr. This patch should
> fix it.

Looks good, applied.  Thanks Patrick.

I'll apply your 2.4.x backport of this fix as well.
