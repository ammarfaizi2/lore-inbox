Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263236AbUB1BJf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 20:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263238AbUB1BJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 20:09:31 -0500
Received: from bay14-f68.bay14.hotmail.com ([64.4.49.68]:44812 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263236AbUB1BJZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 20:09:25 -0500
X-Originating-IP: [24.136.227.168]
X-Originating-Email: [filamoon2@hotmail.com]
From: "johnny zhao" <filamoon2@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: udp packet loss even with large socket buffer
Date: Fri, 27 Feb 2004 20:09:24 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY14-F68kiyPoHZgzD000006ad@hotmail.com>
X-OriginalArrivalTime: 28 Feb 2004 01:09:24.0447 (UTC) FILETIME=[811BAEF0:01C3FD97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a problem when trying to receive udp packets containing video data 
sent by Microsoft Windows Messenger. Here is a detailed description:

Linux box:
    Linux-2.4.21-0.13mdksmp, P4 2.6G HT
socket mode:
    blocked mode
code used:
    while ( recvfrom(...) )
socket buffer size:
    8388608, set by using sysctl -w net.core.rmem_default and rmem_max

I used ethereal(using libpcap) to monitor the network traffic. All the 
packets were transferred and captured by libpcap. But my program constantly 
suffers from packet loss. According to ethereal, the average time interval 
between 2 packets  is 70-80ms, and the minimum interval can go down to ~1ms. 
Each packet is smaller than 1500 bytes (ethernet MTU).

Can anybody help me? I googled and found a similar case that had been solved 
by increasing the socket buffer size. But it doesn't work for me. I think 8M 
is a crazily large size :(

Thank you!

_________________________________________________________________
Get fast, reliable access with MSN 9 Dial-up. Click here for Special Offer! 
http://click.atdmt.com/AVE/go/onm00200361ave/direct/01/

