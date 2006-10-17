Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWJQQnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWJQQnM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWJQQnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:43:11 -0400
Received: from web57808.mail.re3.yahoo.com ([68.142.236.86]:2188 "HELO
	web57808.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S1751307AbWJQQnJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:43:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=vlLYYaYSWGj56sAHBqRCoX/0I4Y+2UkhV674CVABuIfLTSN5XxxOtgqG5ERYJu6aPcld74BtHQ2p1sf0WtWaeUCtrBpKJcLR3Ko0Bzxp6f8V2qLEAfRVgjCj5xBVHV3OgU4YUXBKV8dtnfj6hesKnGV0MN9541R0uNeH8OELqt4=  ;
Message-ID: <20061017164308.10124.qmail@web57808.mail.re3.yahoo.com>
Date: Tue, 17 Oct 2006 09:43:08 -0700 (PDT)
From: John Philips <johnphilips42@yahoo.com>
Subject: Re: BUG: warning at kernel/softirq.c:141/local_bh_enable()
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>OK, could you please send now :
>
>ifconfig eth6
>cat /proc/interrupts

Eric,

Here you go:

ifconfig eth6:
eth6      Link encap:Ethernet  HWaddr XX:XX:XX:XX:XX:XX
          inet addr:X.X.X.X  Bcast:X.X.X.X  Mask:X.X.X.X
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:19015877 errors:0 dropped:880 overruns:82 frame:0
          TX packets:18771972 errors:1970 dropped:17259 overruns:25 carrier:25
          collisions:0 txqueuelen:1000
          RX bytes:2956503786 (2.7 GiB)  TX bytes:2149556909 (2.0 GiB)
          Interrupt:12 Base address:0x8000


cat /proc/interrupts:
           CPU0
  0:   71570907          XT-PIC  timer
  2:          0          XT-PIC  cascade
  4:        465          XT-PIC  serial
  8:          4          XT-PIC  rtc
 10:   17076423          XT-PIC  eth1
 11:    3602236          XT-PIC  eth2
 12:   52112382          XT-PIC  eth0, eth6
 14:     955580          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0





