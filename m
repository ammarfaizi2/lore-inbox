Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbUB2Fkz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 00:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUB2Fky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 00:40:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29910 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261978AbUB2Fkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 00:40:53 -0500
Date: Sat, 28 Feb 2004 21:40:46 -0800
From: "David S. Miller" <davem@redhat.com>
To: Michael Schlenstedt <Michael-ml-kernel@schlenn.net>
Cc: linux-kernel@vger.kernel.org, jjciarla@raiz.uncu.edu.ar
Subject: Re: PROBLEM: /proc/sys/net/ipv4/ip_dynaddr does not work correctly
Message-Id: <20040228214046.23c31cc2.davem@redhat.com>
In-Reply-To: <20040215212241.GA2752@schlenn.net>
References: <20040215212241.GA2752@schlenn.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Feb 2004 22:22:42 +0100
Michael Schlenstedt <Michael-ml-kernel@schlenn.net> wrote:

> 
> [2.] Full description of the problem/report:
> 
> I've recognized that the debug-mode ("2") with
> /proc/sys/net/ipv4/ip_dynaddr does not work correctly. In fact, if I do
> a "echo 2 > /proc/sys/net/ipv4/ip_dynaddr", nothing happens. There are no
> messages in the syslog, and there is no function of ip_dynaddr at all.

It will only print a "debugging message" if the IP address of the system
changes and a packet is attempted to be sent over a TCP connection, then
it will print a message looking like:

tcp_v4_rebuild_header(): shifting iner->saddr from x.x.x.x to y.y.y.y

And it in fact does do this.
