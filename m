Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUDEL4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 07:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbUDEL4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 07:56:55 -0400
Received: from 66.Red-80-38-104.pooles.rima-tde.net ([80.38.104.66]:50562 "HELO
	fulanito.nisupu.com") by vger.kernel.org with SMTP id S262045AbUDEL4y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 07:56:54 -0400
Message-ID: <002601c41b05$4d1896a0$1530a8c0@HUSH>
From: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
To: "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>,
       <linux-kernel@vger.kernel.org>
References: <002101c41b00$3f0f8c30$1530a8c0@HUSH> <200404051453.47023.vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Network issues in 2.6
Date: Mon, 5 Apr 2004 13:58:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> eth0      Link encap:Ethernet  HWaddr 00:01:03:27:81:75
>           inet addr:192.168.20.1  Bcast:192.168.20.255  Mask:255.255.255.0
>           UP BROADCAST MULTICAST  MTU:1500  Metric:1

Hm. Thats strange. Your interface is not UP. It's not supposed to
do any tx/rx at all. Try to up it. If it does not work,
strace 'ifconfig eth0 up' under both kernels and compare.

It is UP (of course) :-)
Only "RUNNING" is missing, comparing 2.4 to 2.6.  Other than that, both
ifconfig output are identical (and those 'carrier' counts, obviously).

The thing is, the more I research the more it looks like a local problem, as
I don't find a lot of references in google, and those who are enjoying the
same problem are as clueless as I am.


