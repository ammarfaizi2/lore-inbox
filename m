Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265925AbTLIO7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 09:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265933AbTLIO7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 09:59:49 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:28682 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S265925AbTLIO63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 09:58:29 -0500
Date: Tue, 9 Dec 2003 15:58:47 +0100
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: /proc/sys/net/ipv4/config/eth0/arp_filter not working?
Message-ID: <20031209145847.GA10652@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm having trouble with the Linux kernel answering ARP requests it
shouldn't answer.

In particular, I have added the IP 10.0.0.23 to lo using ip from
iproute2.  On another machine, I have added the IP 10.0.0.23 to eth0
using ip.  Now, an ARP request from a third machine is answered by both.

According to the documentation I found, the kernel (2.6.0-test11) should
not answer ARP requests for the lo alias if I write 1 to
/proc/sys/net/ipv4/config/eth0/arp_filter, and to be on the safe side, I
also wrote 1 to /proc/sys/net/ipv4/config/lo/arp_filter.  However, the
kernel still answers the ARP requests.

Any takers?

Felix
