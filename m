Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262798AbSJEXNP>; Sat, 5 Oct 2002 19:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262801AbSJEXNO>; Sat, 5 Oct 2002 19:13:14 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:15092 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262798AbSJEXNO>; Sat, 5 Oct 2002 19:13:14 -0400
Subject: Re: Bizarre network issue
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: law@dodinc.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D9F7169.8020008@dodinc.com>
References: <3D9F7169.8020008@dodinc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Oct 2002 00:27:24 +0100
Message-Id: <1033860444.4079.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-06 at 00:10, Lawrence A. Wimble wrote:
> 1. ARP ... tcpdump shows both the request AND reply.
> 2. PING ... Getting approx 120ms round trip with the MHX-910s (23ms null 
> modem)
> 3. UDP ... Works perfectly with netcat in both directions.
> 
> Here's what *is not* working:
> 
> 4. TCP .... tcpdump shows the SYN packet, but no SYN/ACK ever appears
> 5. ICMP 3/3 ... If I try a UDP session when there's no-body "listening" 
> on that
>     remote port, no "Port Unreachable" message is ever sent back to the 
> sending host.

I'll take a quick guess. Your faked mac address has bit 0 of the first
byte set.


