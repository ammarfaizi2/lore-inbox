Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268204AbUIBLY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268204AbUIBLY5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 07:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268214AbUIBLY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 07:24:57 -0400
Received: from gwout.thalesgroup.com ([195.101.39.227]:21008 "EHLO
	GWOUT.thalesgroup.com") by vger.kernel.org with ESMTP
	id S268204AbUIBLYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 07:24:37 -0400
Message-ID: <413702EE.2000309@fr.thalesgroup.com>
Date: Thu, 02 Sep 2004 13:24:30 +0200
From: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Reply-To: pierre-olivier.gaillard@fr.thalesgroup.com
Organization: Thales Air Defence
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q6 - network is no longer
 smooth
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040830192131.GA12249@elte.hu> <4135C12B.6050208@fr.thalesgroup.com> <20040901130518.GA10060@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just tried with Q6 and the network behaviour seems odd :
  - my ssh connection freezes a bit,
  - communication between the two PCs sharing the GigE connection is difficult 
to start :
13:17:37.965962 arp who-has djerba-gig tell canopus-gig
13:17:37.966220 IP djerba-gig > canopus-gig: udp
13:17:37.966230 IP djerba-gig > canopus-gig: udp
13:17:37.966313 IP djerba-gig > canopus-gig: udp
13:17:38.965906 arp who-has djerba-gig tell canopus-gig
13:17:38.966040 IP djerba-gig > canopus-gig: udp
This is strange since canopus is the one with Q6
  - ping does not start for a moment since all packets are RX-ERROR, then they 
start being received.

Here is the output of ethtool -S eth1

NIC statistics:
      rx_packets: 581
      tx_packets: 552
      rx_bytes: 545746
      tx_bytes: 66508
      rx_errors: 112950
      tx_errors: 0
      rx_dropped: 90
      tx_dropped: 0
      multicast: 0
      collisions: 0
      rx_length_errors: 0
      rx_over_errors: 0
      rx_crc_errors: 0
      rx_frame_errors: 0
      rx_fifo_errors: 112860
      rx_missed_errors: 112860
      tx_aborted_errors: 0
      tx_carrier_errors: 0
      tx_fifo_errors: 0
      tx_heartbeat_errors: 0
      tx_window_errors: 0
      tx_abort_late_coll: 0
      tx_deferred_ok: 0
      tx_single_coll_ok: 0
      tx_multi_coll_ok: 0
      rx_long_length_errors: 0
      rx_short_length_errors: 0
      rx_align_errors: 0
      tx_tcp_seg_good: 0
      tx_tcp_seg_failed: 0
      rx_flow_control_xon: 0
      rx_flow_control_xoff: 0
      tx_flow_control_xon: 45
      tx_flow_control_xoff: 112905
      rx_long_byte_count: 545746
      rx_csum_offload_good: 1
      rx_csum_offload_errors: 0


I rebooted with Q5 (+ netdev_max_backlog=32) and everything was fine. Is there 
anything I can do to make my report more useful for you ?

	

	P.O. Gaillard







