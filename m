Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbTFQTfm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 15:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264906AbTFQTfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 15:35:42 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:43433 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264905AbTFQTfj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 15:35:39 -0400
Message-ID: <3EEF7030.6030303@us.ibm.com>
Date: Tue, 17 Jun 2003 14:46:56 -0500
From: Janice M Girouard <janiceg@us.ibm.com>
Organization: IBM Linux Technology Center - Network Device Drivers
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: "David S. Miller" <davem@redhat.com>, shemminger@osdl.org,
       Valdis.Kletnieks@vt.edu, Janice Girouard <girouard@us.ibm.com>,
       Daniel Stekloff <stekloff@us.ibm.com>,
       Larry Kessler <lkessler@us.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: patch for common networking error messages
References: <OFCA1A4F38.D782F1D3-ON85256D48.000A5CED@us.ibm.com>	<200306170434.h5H4YZPZ003025@turing-police.cc.vt.edu>	<20030617090859.0ffa0ca8.shemminger@osdl.org> <20030617.090930.102574393.davem@redhat.com> <3EEF620A.40608@pobox.com> <3EEF66AA.3000509@us.ibm.com> <3EEF6A9D.6050303@pobox.com>
Content-Type: multipart/related;
 boundary="------------010202080205050803050900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------010202080205050803050900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:

    Do you want to individually send 4000 - 16000 (or more) TX stop /
    start events per second to userspace?  :)   At some point Heisenburg
    defeats low latency :)

How about looking at 1000 byte packet transmit example.  A gigabit 
adapter would send 125,000 packets per second.  I'm thinking that most 
of the time, you will have enough available buffers in the adapter that 
you don't start to see the adapter buffers completely fill up.  Are you 
saying that 3.2% - 12.8% of the time in this case you're disabling the 
tcp/ip stack because the transmit buffers on your card are completely 
full?   Perhaps with zero copy enabled, but the tcp/ip cpu load alone 
will throttle your ability to fill the adapter buffers up.  

What does your own experience indicate for gigabit adapter cards?

 I could see the buffers backing up for 10/100 cards. So that case 
favors your point.  I'm still thinking that it's a sign someone should 
be buying a 2nd card and ramping up their network capability.  But I can 
see your point.



--------------010202080205050803050900--

