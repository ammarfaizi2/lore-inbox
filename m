Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbUB1VgE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 16:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUB1VgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 16:36:04 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:14341 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261930AbUB1VgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 16:36:01 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "johnny zhao" <filamoon2@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: udp packet loss even with large socket buffer
Date: Sat, 28 Feb 2004 23:22:50 +0200
User-Agent: KMail/1.5.4
References: <BAY14-F68kiyPoHZgzD000006ad@hotmail.com>
In-Reply-To: <BAY14-F68kiyPoHZgzD000006ad@hotmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402282255.18609.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 February 2004 03:09, johnny zhao wrote:
> Hi,
>
> I have a problem when trying to receive udp packets containing video data
> sent by Microsoft Windows Messenger. Here is a detailed description:
>
> Linux box:
>     Linux-2.4.21-0.13mdksmp, P4 2.6G HT
> socket mode:
>     blocked mode
> code used:
>     while ( recvfrom(...) )
> socket buffer size:
>     8388608, set by using sysctl -w net.core.rmem_default and rmem_max
>
> I used ethereal(using libpcap) to monitor the network traffic. All the
> packets were transferred and captured by libpcap. But my program constantly
> suffers from packet loss. According to ethereal, the average time interval
> between 2 packets  is 70-80ms, and the minimum interval can go down to
> ~1ms. Each packet is smaller than 1500 bytes (ethernet MTU).
>
> Can anybody help me? I googled and found a similar case that had been
> solved by increasing the socket buffer size. But it doesn't work for me. I
> think 8M is a crazily large size :(

Post a small program demonstrating your problem.
(I'd test udp receive with netcat too)
--
vda

