Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbSLIMig>; Mon, 9 Dec 2002 07:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265320AbSLIMig>; Mon, 9 Dec 2002 07:38:36 -0500
Received: from f34.law11.hotmail.com ([64.4.17.34]:43017 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S265306AbSLIMif>;
	Mon, 9 Dec 2002 07:38:35 -0500
X-Originating-IP: [212.3.234.82]
From: "lao nightwolf" <laonightwolf@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: irregular packet-loss with use of bonding on TG3
Date: Mon, 09 Dec 2002 12:43:40 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F34AI5RTHrS0WEc6emT00002afb@hotmail.com>
X-OriginalArrivalTime: 09 Dec 2002 12:43:40.0593 (UTC) FILETIME=[99DEA210:01C29F80]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We've been using bonding for the first time and are encountering packet-loss 
using it.
We have installed RH 7.2 on Compaq DL360's with the Broadcom Tigon3 network 
cards.  We've tested the configuration internally and everything seemed to 
work.  Now when the platform came live last week we have irregular 
packet-loss on all servers with bonding enabled.  The servers were compiled 
with kernel-2.4.19 patched with kernel-2.4.20pre11 patch (which contained 
v1.1 of the tg3 drivers).
As I saw updates for this driver in the 2.4.20 kernel (v1.2, dated 
14/11/2002), I upgraded all servers to latest stable kernel.  But it didn't 
fix our problem.
The two network interfaces of each server (7 in total) are connencted to 2 
AD3 Alteons Switches (one interface to alteon1, the other interface to 
alteon2).
We do NOT have any packet-loss to the alteons.  If we look at the health 
check log of the alteon we can see that even the alteon isn't always able to 
contact the servers with bonding enabled.
Packet-loss to the servers differs from 1% to 50%.

Another curious thing:

>From our location we monitor two ping windows to 2 servers from the 
platform.  Ping times are constantly 18-19ms, with sometimes some 
packet-loss.

When we do logon onto these two servers and execute the 'ps waux' command 
several times, we can see increase ping times drastically to 50-100ms!! It 
also increases packet-loss!  As I can conclude from this is, when traffic 
rises to the servers packet-loss to those servers is also rising.

When we ping from the first to the second server (within the same platform) 
we can see that packet-loss is also much higher, even 100% packet-loss for 
some time (and connection loss to our SSH connection).

Hope someone can point us in the right direction.  Could it have any affect 
by enabling trunking on the alteon switches?  Or has it something to do with 
the linux tg3 driver?

Best Regards,
Kevin

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail

