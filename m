Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVEXXjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVEXXjv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 19:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVEXXjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 19:39:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:29862 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262160AbVEXXjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 19:39:46 -0400
Date: Tue, 24 May 2005 16:39:39 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: 2.6.12-rc4-tcp3
Message-ID: <20050524163939.0fb86509@dxpl.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://developer.osdl.org/shemminger/patches/2.6.12-rc4-tcp3

This is the third revision of the TCP pluggable congestion framework with
other network changes (targeted for 2.6.13)

Minor tweaks from last time:
	- startup changed because westwood and hybla 
	  need to do setup after initial connection establishment
	- initialization happens when socket is created (fixes bug with
	  auto module load and preempt).
	- module refcounting fix for passive opens
	- cleanup westwood and get rid of too much inlining
	- latest version of TSO patch included in set
	- fix min_cwnd undershoot bug for all but legacy reno

# Changes involving network core to remove throttling
fastroute-stats-remove
no-congestion
no-throttle
bigger-backlog
fix-weightp
# TSO fixes from dave
tcp_ack26
tcp_super_tso_v3
# TCP infrastructure
tcp_infra
tcp_bic
tcp_westwood
hstcp
hybla
vegas
h-tcp
# Makefile version
version
