Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVAPCiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVAPCiU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 21:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVAPCiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 21:38:20 -0500
Received: from mx.freeshell.org ([192.94.73.21]:737 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S262400AbVAPCiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 21:38:03 -0500
Date: Sat, 15 Jan 2005 20:37:39 -0600 (CST)
From: John Dahlstrom <jd@freeshell.org>
To: linux-kernel@vger.kernel.org
Subject: NETWORK: udp_port_rover reluctant to rove (unlike tcp_port_rover)
Message-ID: <Pine.NEB.4.61.0501151934180.14016@ukato.freeshell.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding udp_port_rover (of linux/net/ipv4/udp.c):

In Linux 2.4 or 2.6, I noticed that selected local port numbers for UDP
resist roaming, unlike TCP ports numbers (tcp_port_rover) that appear
to steadily increase irrespective of concurrent local port usage.

What is the advantage of this lack of parallel behavior?  (Other than
exacerbating broken behavior of certain firewalls that insist on fixed
UDP source port blocking?)

Aesthetically peculiar it seems, that the kernel reins in port roving
for the connectionless protocol unless a UDP stampede unleashes itself,
while allowing the TCP ports to range free across the local ports
regardless.

Kind regards,

- John

--
http://jodarom.sdf1.org/
