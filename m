Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbULNQob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbULNQob (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbULNQob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:44:31 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:32145 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261552AbULNQoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:44:21 -0500
Date: Tue, 14 Dec 2004 17:44:15 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adam Denenberg <adam@dberg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: bind() udp behavior 2.6.8.1
In-Reply-To: <1103042538.10965.27.camel@sucka>
Message-ID: <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr>
References: <1103038728.10965.12.camel@sucka>  <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr>
 <1103042538.10965.27.camel@sucka>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>sorry "closed" was the wrong term here.  We are using a PIX Firewall
>Module and it keeps a state table of all connections (tcp and udp). 
>Thus when a new udp connection comes in with same high numbered source

UDP does not know connections. As such, _nobody_ can tell whether an UDP 
packet belongs to a logically existing "connection" or not.

>port and the firewall has not removed that connection from its state
>table, the firewall drops the packet.  The firewall needs about 60ms in
>order to clear that connection from the state table, so if a second udp
>request with the same high number port/ip comes thru before the firewall
>clears the connection from the state table, it will drop the connection
>(which is what we are seeing).
>
>FreeBSD seems to increment future udp requests which prevents this
>problem.  It just seems strange that the kernel would not randomize or
>increment these source ports for udp requests.

The kernel does not have problems with UDP, it's probably your firewall.

