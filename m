Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVLIMKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVLIMKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 07:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVLIMKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 07:10:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47675 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932249AbVLIMKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 07:10:48 -0500
Date: Fri, 9 Dec 2005 13:12:21 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: 2.6.15-rc5 spits oodles of hw csum failures
Message-ID: <20051209121220.GJ26185@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just booted -rc5 on another one of my boxes, and I get literally tons of
these everytime there's some network activity:

printk: 300 messages suppressed.
<NULL>: hw csum failure.

Call Trace: <IRQ> <ffffffff80357463>{__skb_checksum_complete+76}
       <ffffffff80381e89>{tcp_rcv_established+1384}
<ffffffff80388ee9>{tcp_v4_d}
       <ffffffff8038a4ee>{tcp_v4_rcv+2285}
<ffffffff8036f59f>{ip_local_deliver+}
       <ffffffff8036f480>{ip_rcv+1043}
<ffffffff8035bc0a>{netif_receive_skb+460}
       <ffffffff8035bd08>{process_backlog+142}
<ffffffff8035a8a5>{net_rx_action}
       <ffffffff8013641e>{__do_softirq+100}
<ffffffff8010ef9b>{call_softirq+31}
       <ffffffff8011028c>{do_softirq+44} <ffffffff801102c4>{do_IRQ+52}
       <ffffffff8010df9a>{ret_from_intr+0}  <EOI>
<ffffffff8010c4a3>{default_id}
       <ffffffff8010c547>{cpu_idle+97}
<ffffffff806327d5>{start_kernel+389}
       <ffffffff8063225e>{_sinittext+606} 

The box is using the sk98lin driver.

-- 
Jens Axboe

