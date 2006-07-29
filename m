Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWG2PmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWG2PmL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 11:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbWG2PmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 11:42:11 -0400
Received: from front3.netvisao.pt ([213.228.128.91]:40907 "EHLO
	front3.netvisao.pt") by vger.kernel.org with ESMTP id S1750933AbWG2PmJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 11:42:09 -0400
From: Rodrigo Ventura <yoda@isr.ist.utl.pt>
Organization: ISR/IST
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel hangs when trying to remove a bridge
Date: Sat, 29 Jul 2006 16:42:04 +0100
User-Agent: KMail/1.9.1
Cc: shemminger@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607291642.05046.yoda@isr.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm using kernel 2.6.16 (-gentoo-r13 actually). A bridge iface br0 is setup 
using eth1 and eth0.1 (VLAN) as slaves. To bring br0, what I do is to remove 
the slaves from the bridge first, "ip link set dev br0 down" next, followed 
by the brctl command to remove the bridge. What happens is that it seems it 
tryes to destroy the bridge iface, and then hangs, with dmesg complaining, 
periodically, about once a second, something like:

unregister_netdevice: waiting for br0 to become free. Usage count = 1
unregister_netdevice: waiting for br0 to become free. Usage count = 1
unregister_netdevice: waiting for br0 to become free. Usage count = 1
...

I say it partially hangs because commands like ifconfig hang (ps state=Disk 
busy)...
To reboot the machine, a HARD reset is required, since, the shutdown process 
hangs... 

Cheers,

Rodrigo

-- 
Rodrigo Ventura
ISR/IST
