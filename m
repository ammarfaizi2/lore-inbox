Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315386AbSEGIfx>; Tue, 7 May 2002 04:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315387AbSEGIfw>; Tue, 7 May 2002 04:35:52 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:27141 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S315386AbSEGIfv>;
	Tue, 7 May 2002 04:35:51 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200205070815.JAA11610@gw.chygwyn.com>
Subject: Re: Kernel deadlock using nbd over acenic driver.
To: chen_xiangping@emc.com (chen, xiangping)
Date: Tue, 7 May 2002 09:15:51 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F553D1A3A@srgraham.eng.emc.com> from "chen, xiangping" at May 06, 2002 11:05:52 AM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I suggest trying 2.4.19-pre8 first. This has the fix for the deadlock that I'm
aware of in it. If that still doesn't work, then try and send me as much
information as the system will let you extract. What I'm most interested
in is:

 o State of the sockets (netstat -t on both client and server)
 o Values of /proc/sys/net/ipv4/tcp_[rw]mem and tcp_mem
 o Does the nbd client get stuck in the D state before or after any other
   processes doing I/O through nbd? This is useful as it tells me whether
   the problem is on a transmit or receive.
 o Was your system low on memory at the time ?
 o Were you trying to use nbd as a swap device ?

Steve.
 
> 
> Hi,
> 
> I am using 2.4.16 with xfs patch from SGI. It may not be the acenic
> driver problem, I can reproduce the deadlock in a 100 base-T network
> using eepro100 driver. Closing the server did not release the deadlock.
> What else can I try?
> 
> 
[original messages cut here]
