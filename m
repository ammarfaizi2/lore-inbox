Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVAEQav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVAEQav (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 11:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbVAEQ3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 11:29:21 -0500
Received: from [213.241.40.118] ([213.241.40.118]:47792 "EHLO
	workaround.pex.com.pl") by vger.kernel.org with ESMTP
	id S261207AbVAEQ01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 11:26:27 -0500
Date: Wed, 5 Jan 2005 17:26:26 +0100
From: Tomasz.Wasiak@pex.com.pl
To: linux-kernel@vger.kernel.org
Cc: tjwasiak@odynca.pex.com.pl
Subject: PROBLEM: changing ownership of directory with reiserfs mounted inside
Message-ID: <20050105162626.GA6401@workaround.pex.com.pl>
Reply-To: Tomasz.Wasiak@pex.com.pl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to change ownership of directory where I have reiserfs
mounted (I was preparing it for squid cache dir). Under 2.6.10 and up
to 2.6.10-bk5 (and 2.6.10-ac4 too) everything works as it should, but 
when I tried to do it under 2.6.10-bk7 (or bk8) chown suspended. This
bug is very simple to reproduct - just mount reiserfs into directory
and then try to change ownership of that directory. Something must
have happened between bk5 and bk7.
Keywords: kernel, reiserfs, chown
Kernel version: 2.6.10-bk7, 2.6.10-bk8
I am running Debian Sarge (daily updated) on AMD Athlon 900 stepping 02:
	Gnu C			3.3.5
	Gnu make		3.80
	binutils		2.15
	util-linux		2.12
	mount			2.12
	module-init-tools	3.1
	e2fsprogs		1.35
	reiserfsprogs		3.6.19
	PPP			2.4.2
	Linux C Library		2.3.2
	Dynamic linker (ldd)	2.3.2
	Procps			3.2.1
	Net-tools		1.60
	Console-tools		0.2.3
	Sh-utils		5.2.1
	Modules Loaded		ipt_LOG ipt_limit af_packet capability
				commoncap ipt_REJECT ipt_state iptable_filter
				ipt_MASQUERADE ipt_iprange iptable_nat
				ip_conntrack ip_tables uhci_hcd usbcore
				via_agp agpgart floppy evdev reiserfs
				parport_pc lp parport ide_cd cdrom unix
I use gcc-3.3.5 (Debian 1:3.3.5-5) to compile all those kernels.
