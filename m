Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbUDZPom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUDZPom (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 11:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUDZPol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 11:44:41 -0400
Received: from web41402.mail.yahoo.com ([66.218.93.68]:8622 "HELO
	web41402.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262398AbUDZPoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 11:44:38 -0400
Message-ID: <20040426154437.67657.qmail@web41402.mail.yahoo.com>
Date: Mon, 26 Apr 2004 08:44:37 -0700 (PDT)
From: Parag Nemade <cranium2003@yahoo.com>
Subject: ping takes much time to myself?
To: net dev <netdev@oss.sgi.com>
Cc: kernerl mail <linux-kernel@vger.kernel.org>,
       linux net <linux-net@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
     i want to add my own variables with icmp header.
so i modified icmp header and added 2 variables to
make icmp header len is 16 bytes. but when i build
kernel image and boot it and then ping to myself why
am i still getting 8 bytes header i.e. 84 bytes packet
and why not 92 bytes packet?
56 bytes data + 16 bytes icmp header + 20 bytes ip
header = 92 bytes
also ping results shown below takes much time to ping
myself. what gone wrong? how to make it behave like
normal ping?

[root@localhost root]# ping localhost
PING localhost.localdomain (127.0.0.1) 56(84) bytes of
data.
64 bytes from localhost.localdomain (127.0.0.1):
icmp_seq=1 ttl=64 time=1488806
ms
64 bytes from localhost.localdomain (127.0.0.1):
icmp_seq=2 ttl=64 time=1489805
ms

--- localhost.localdomain ping statistics ---
2 packets transmitted, 2 received, 0% packet loss,
time 999ms
rtt min/avg/max/mdev =
1488806.484/1489305.976/1489805.469/500.981 ms
[root@localhost root]#
regards,
parag.


	
		
__________________________________
Do you Yahoo!?
Yahoo! Photos: High-quality 4x6 digital prints for 25¢
http://photos.yahoo.com/ph/print_splash
