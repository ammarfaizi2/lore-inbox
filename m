Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129814AbRBVOcu>; Thu, 22 Feb 2001 09:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129761AbRBVOcb>; Thu, 22 Feb 2001 09:32:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11526 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129814AbRBVOcZ>;
	Thu, 22 Feb 2001 09:32:25 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102221358.f1MDwIH30430@flint.arm.linux.org.uk>
Subject: ipv4: 2.4.2: unused static variables
To: linux-kernel@vger.kernel.org
Date: Thu, 22 Feb 2001 13:58:18 +0000 (GMT)
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With CONFIG_SYSCTL=n, I get the following warnings:

sysctl_net_ipv4.c:50: warning: `tcp_retr1_max' defined but not used
sysctl_net_ipv4.c:52: warning: `ip_local_port_range_min' defined but not used
sysctl_net_ipv4.c:53: warning: `ip_local_port_range_max' defined but not used

These are defined static in sysctl_net_ipv4.c, and appear to only be
exported via procfs.  In other words, you can set them to whatever you
like and the IPv4 stack couldn't care less.

Why do we have them?  If they're not used, can we either eliminate them,
or else move their definition within the '#ifdef CONFIG_SYSCTL' to
eliminate the warning?

Thanks.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

