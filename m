Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262870AbVDAUPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbVDAUPH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVDAUPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:15:07 -0500
Received: from fire.osdl.org ([65.172.181.4]:40907 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262870AbVDAUHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:07:37 -0500
Date: Fri, 1 Apr 2005 12:07:27 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: lartc@mailman.ds9a.nl, linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: [ANNOUNCE] iproute2 2.6.11-050330
Message-ID: <20050401120727.62700e8c@dxpl.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An updated version of the iproute2 utilities is available at:
http://developer.osdl.org/dev/iproute2/download/iproute2-2.6.11-050330.tar.gz

It supports the latest features from 2.6, but is backwards compatiable
with 2.4.

This update includes several bugfixes and build clean from
the previous version (2.6.11-050314):

[Jamal Hadi Salim]
	* Proper verison of iptables headers (from 1.3.1)
	* Set revision file in m_ipt
	* Fix action_util naming in mirred
	* don't call ll_init_map in mirred

[Thomas Graf]

	* Warn about wildcard deletions and provide IFA_ADDRESS upon
	  deletions to enforce prefix length validation for IPv4.
	* Fix netlink message alignment when the last routing attribute added
	  has a data length not aligned to RTA_ALIGNTO.
	
[Masahide NAKAMURA]
	
	* ipv6 xfrm allocspi and monitor support.
	
[Stephen Hemminger]
	* include/linux/netfilter_ipv4/ip_tables.h dont include compiler.h
	  because it isn't needed and not on all systems
	* Update rtnetlink.h and pkt_cls.h to be stripped versions
	  of headers from 2.6.12-rc1
	* switch to stack for netem tables
	* add -force option to batch mode
	* handle midline comments in batch mode
	* sum per cpu fields in lnstat correctly
