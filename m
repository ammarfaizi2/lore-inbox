Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWJVTHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWJVTHM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 15:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWJVTHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 15:07:12 -0400
Received: from dvhart.com ([64.146.134.43]:23219 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750739AbWJVTHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 15:07:10 -0400
Message-ID: <453BC0E7.1060308@mbligh.org>
Date: Sun, 22 Oct 2006 12:05:11 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: Strange errors from e1000 driver (2.6.18)
References: <453BBC9E.4040300@google.com>
In-Reply-To: <453BBC9E.4040300@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> I'm getting a lot of these type of errors if I run 2.6.18. If
> I run the standard Ubuntu Dapper kernel, I don't get them.
> What do they indicate?
> 
> Oct 21 18:48:28 localhost kernel: buffer_info[next_to_clean]
> Oct 21 18:48:28 localhost kernel:   time_stamp           <7b79d33>
> Oct 21 18:48:28 localhost kernel:   next_to_watch        <3d>
> Oct 21 18:48:28 localhost kernel:   jiffies              <7b7a0c1>
> Oct 21 18:48:28 localhost kernel:   next_to_watch.status <0>
> Oct 21 18:48:30 localhost kernel:   Tx Queue             <0>
> Oct 21 18:48:30 localhost kernel:   TDH                  <3d>
> Oct 21 18:48:30 localhost kernel:   TDT                  <44>
> Oct 21 18:48:30 localhost kernel:   next_to_use          <44>
> Oct 21 18:48:30 localhost kernel:   next_to_clean        <39>
> Oct 21 18:48:30 localhost kernel: buffer_info[next_to_clean]
> Oct 21 18:48:30 localhost kernel:   time_stamp           <7b79d33>
> Oct 21 18:48:30 localhost kernel:   next_to_watch        <3d>
> Oct 21 18:48:30 localhost kernel:   jiffies              <7b7a2b5>
> Oct 21 18:48:30 localhost kernel:   next_to_watch.status <0>
> Oct 21 18:48:32 localhost kernel:   Tx Queue             <0>
> Oct 21 18:48:32 localhost kernel:   TDH                  <3d>
> Oct 21 18:48:32 localhost kernel:   TDT                  <44>
> Oct 21 18:48:32 localhost kernel:   next_to_use          <44>
> Oct 21 18:48:32 localhost kernel:   next_to_clean        <39>
> Oct 21 18:48:32 localhost kernel: buffer_info[next_to_clean]
> Oct 21 18:48:32 localhost kernel:   time_stamp           <7b79d33>
> Oct 21 18:48:32 localhost kernel:   next_to_watch        <3d>
> Oct 21 18:48:32 localhost kernel:   jiffies              <7b7a4a9>
> Oct 21 18:48:32 localhost kernel:   next_to_watch.status <0>
> Oct 21 18:48:34 localhost kernel:   Tx Queue             <0>
> Oct 21 18:48:34 localhost kernel:   TDH                  <3d>
> Oct 21 18:48:34 localhost kernel:   TDT                  <44>
> Oct 21 18:48:34 localhost kernel:   next_to_use          <44>
> Oct 21 18:48:34 localhost kernel:   next_to_clean        <39>
> Oct 21 18:48:34 localhost kernel: buffer_info[next_to_clean]
> Oct 21 18:48:34 localhost kernel:   time_stamp           <7b79d33>
> Oct 21 18:48:34 localhost kernel:   next_to_watch        <3d>
> Oct 21 18:48:34 localhost kernel:   jiffies              <7b7a69d>
> Oct 21 18:48:34 localhost kernel:   next_to_watch.status <0>
> Oct 21 18:48:35 localhost kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Oct 21 18:48:36 localhost kernel: e1000: eth0: e1000_watchdog: NIC Link 
> is Up 100 Mbps Full Duplex

Actually, maybe this set is more helpful:

e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
   Tx Queue             <0>
   TDH                  <6>
   TDT                  <1f>
   next_to_use          <1f>
   next_to_clean        <2>
buffer_info[next_to_clean]
   time_stamp           <2de8b54>
   next_to_watch        <6>
   jiffies              <2de8db7>
   next_to_watch.status <0>
e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
   Tx Queue             <0>
   TDH                  <6>
   TDT                  <1f>
   next_to_use          <1f>
   next_to_clean        <2>
buffer_info[next_to_clean]
   time_stamp           <2de8b54>
   next_to_watch        <6>
   jiffies              <2de8fab>
   next_to_watch.status <0>
e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
   Tx Queue             <0>
   TDH                  <6>
   TDT                  <1f>
   next_to_use          <1f>
   next_to_clean        <2>
buffer_info[next_to_clean]
   time_stamp           <2de8b54>
   next_to_watch        <6>
   jiffies              <2de919f>
   next_to_watch.status <0>
NETDEV WATCHDOG: eth0: transmit timed out
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex


