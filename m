Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbUDELyC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 07:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbUDELyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 07:54:01 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:51978 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262088AbUDELx6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 07:53:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Network issues in 2.6
Date: Mon, 5 Apr 2004 14:53:47 +0300
X-Mailer: KMail [version 1.4]
References: <002101c41b00$3f0f8c30$1530a8c0@HUSH>
In-Reply-To: <002101c41b00$3f0f8c30$1530a8c0@HUSH>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200404051453.47023.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 April 2004 14:21, Carlos Fernandez Sanz wrote:
> I upgraded from 2.4.22 to 2.6.5 (to test HPT374' support, which BTW, works
> fine).
>
> However, I'm having serious network issues now. The NIC is a 3com 3c905B.
> ifconfig shows this:
>
> eth0      Link encap:Ethernet  HWaddr 00:01:03:27:81:75
>           inet addr:192.168.20.1  Bcast:192.168.20.255  Mask:255.255.255.0
>           UP BROADCAST MULTICAST  MTU:1500  Metric:1
>           RX packets:11241 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:9739 errors:0 dropped:0 overruns:0 carrier:9732
>           collisions:0 txqueuelen:1000
>           RX bytes:2994485 (2.8 Mb)  TX bytes:835146 (815.5 Kb)
>           Interrupt:9 Base address:0xd800
>
> Note that for TX packets, the carrier number is almost the same as the
> total packets.... booting in 2.4.22, there are zero problems.  The only
> difference in the ifconfig, other than that, is that in 2.4.22, I have
> "RUNNING" in the options (but I didn't find how to force that).

Hm. Thats strange. Your interface is not UP. It's not supposed to
do any tx/rx at all. Try to up it. If it does not work, 
strace 'ifconfig eth0 up' under both kernels and compare.
-- 
vda
