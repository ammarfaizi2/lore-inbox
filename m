Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTDDTts (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 14:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbTDDTts (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 14:49:48 -0500
Received: from smtp1.libero.it ([193.70.192.51]:30131 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S261292AbTDDTtB (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 14:49:01 -0500
Message-ID: <3E8DE570.6050801@inwind.it>
Date: Fri, 04 Apr 2003 22:05:04 +0200
From: Stefano Pettini <spettini@inwind.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ip_conntrack_ftp and ip_nat_ftp module problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kernel guys!

I'm running a 2.4.20 (i686, configured with "make menuconfig") and I 
have the following problem:

If I compile into the kernel ip_conntrack module, and its ftp and irc 
extensions, I can't insert ip_nat_ftp because it "can't find 
ip_conntrack_ftp module". If I want ftp nat and connection tracking, I 
have to compile ip_conntrack_* as modules because it seems that ip_nat_* 
are always compiled as modules instead of being compiled directly into 
the kernel when requested to do so, like ip_conntrack_*.

I think it's only a makefile problem. Can you fix it for 2.4.21 ?? I see 
"CONFIG_IP_NF_NAT_IRC=m" in config file, but that line doesn't exist in 
menuconfig.

Thank you very much.

PS.
Another question:

To have a working FTP or IRC NAT and connection tracking, I have to 
insert their modules (*_ftp and *_irc) manually with insmod or modprobe. 
lsmod tells they're usage count is always 0, even if they "work". Why 
can't those modules be automagically probed when required, like every 
other module, for example when I add a nat or a state rule with 
iptables? This inserts ip_conntrack, but not ip_conntrack_* and 
ip_nat_*. And with their usage count = 0, there's a risk that rmmod -a 
removes them.

Stefano from Rome

