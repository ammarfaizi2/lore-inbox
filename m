Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbUCZTYc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 14:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264120AbUCZTYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 14:24:32 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:30452 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263793AbUCZTYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 14:24:30 -0500
Message-ID: <4064835E.50403@nortelnetworks.com>
Date: Fri, 26 Mar 2004 14:24:14 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux.nics@intel.com, Linux kernel <linux-kernel@vger.kernel.org>,
       cramerj@intel.com, scott.feldman@intel.com
Subject: e1000 performance issues and broken mtu setting
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got a pair of dual G5s.  For a second gigE link we added in some 
Intel 82540EM cards, using the e1000 driver in the 2.6.4 tree with NAPI 
enabled.  lspci reports the bus as 66MHz.  The cards were connected 
together with a crossover cable.

A basic UDP packet-blasting program in userspace using 64KB datagrams 
could only manage 47MB/s of data throughput, using 20% of a cpu.

For comparison, the same program managed 108.9 MB/s with 30% cpu when 
using the onboard gigE ports.

Also, I tried setting a larger mtu using "ip set link dev ethx mtu 
xxxxx".  No matter what value I chose (even setting it to its default 
value, which should have had zero effect) it resulted in the link not 
being able to transfer data.  Downing/upping the link didn't clear the 
issue, neither did unloading/reloading the driver module.  It took a 
reboot to actually get it working again.

Any ideas what's going on?

Thanks,

Chris Friesen

