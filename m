Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbTEGNCc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 09:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbTEGNCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 09:02:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18959 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263163AbTEGNCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 09:02:31 -0400
Date: Wed, 7 May 2003 14:14:58 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: The magical mystical changing ethernet interface order
Message-ID: <20030507141458.B30005@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know if there's a reason that the ethernet driver initialisation
order has changed again in 2.5?

In 2.2.xx, we had eth0 = NE2000, eth1 = Tulip
In 2.4, we have eth0 = Tulip, eth1 = NE2000
And in 2.5, it's back to eth0 = NE2000, eth1 = Tulip

Both interfaces are on the same bus:

00:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 30)
00:0d.0 Ethernet controller: Winbond Electronics Corp W89C940F

Its rather annoying when your dhcpd starts on the wrong interface.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

