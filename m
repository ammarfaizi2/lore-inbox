Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbTIJLq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 07:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTIJLq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 07:46:56 -0400
Received: from 12-250-237-26.client.attbi.com ([12.250.237.26]:10631 "EHLO
	mail.fawad.dom") by vger.kernel.org with ESMTP id S262587AbTIJLqy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 07:46:54 -0400
Message-ID: <3F5F0F2C.5080407@fawad.net>
Date: Wed, 10 Sep 2003 06:46:52 -0500
From: Fawad Halim <fawad@fawad.net>
Organization: LinuxPakistan Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030818
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linksys connectivity problem using 2.6.0-test4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I'm having trouble connecting to the http based admin ports on my 
LinkSys VPN router (BEFVP41) using the 2.6.0-test4 kernel on Redhat 9. 
The connectivity works fine with 2.4.20-19.9 from Redhat as well as 
other 2.4.x kernels. With the 2.6 kernel, I can ping the machine, but 
can't connect to the http ports (80, 8080)

# uname -a
Linux chuckie 2.6.0-test4-fh1 #1 Mon Sep 1 05:43:07 CDT 2003 i686 athlon 
i386 GNU/Linux

# nmap 192.168.3.1

Starting nmap 3.30 ( http://www.insecure.org/nmap/ ) at 2003-09-10 06:42 CDT
Interesting ports on 192.168.3.1:
(The 1642 ports scanned but not shown below are in state: closed)
Port       State       Service
80/tcp     open        http
8080/tcp   open        http-proxy

Nmap run completed -- 1 IP address (1 host up) scanned in 2.468 seconds

# ping -c 1 192.168.3.1
PING 192.168.3.1 (192.168.3.1) 56(84) bytes of data.
64 bytes from 192.168.3.1: icmp_seq=1 ttl=149 time=1.44 ms

--- 192.168.3.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 1.448/1.448/1.448/0.000 ms

# telnet 192.168.3.1 80
Trying 192.168.3.1...
telnet: connect to address 192.168.3.1: Connection refused

The VPN router is doing NAT correctly for both kernels, and connectivity 
to services other than the router itself is fine.

I am not sure where to even begin debugging this problem.

Regards
-fawad

