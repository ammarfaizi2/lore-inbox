Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264033AbRFNUvt>; Thu, 14 Jun 2001 16:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264031AbRFNUvj>; Thu, 14 Jun 2001 16:51:39 -0400
Received: from intranet.resilience.com ([209.245.157.33]:63654 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S264033AbRFNUv0>; Thu, 14 Jun 2001 16:51:26 -0400
Mime-Version: 1.0
Message-Id: <p05100301b74ed3224ec5@[10.128.7.49]>
In-Reply-To: <15145.2693.704919.651626@pizda.ninka.net>
In-Reply-To: <3B273A20.8EE88F8F@vnet.ibm.com>
 <3B28C6C1.3477493F@mandrakesoft.com>
 <15144.51504.8399.395200@pizda.ninka.net>
 <p0510030eb74ea25caa73@[207.213.214.37]>
 <15145.2693.704919.651626@pizda.ninka.net>
Date: Thu, 14 Jun 2001 13:50:47 -0700
To: "David S. Miller" <davem@redhat.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Going beyond 256 PCI buses
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Tom Gall <tom_gall@vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:03 PM -0700 2001-06-14, David S. Miller wrote:
>Jonathan Lundell writes:
>  > As I recall, even a midline chipset such as the ServerWorks LE
>  > supports the use of two north bridges, which implies two PCI bus
>  > domains.
>
>It hides this fact by making config space accesses respond in such a
>way that it appears that it is all behind one PCI controller.  The
>BIOS even avoids allowing any of the MEM and I/O resources from
>overlapping.

So we end up with a single domain and max 256 buses. Still, it's not 
behavior one can count on. Sun's U2P PCI controller certainly creates 
a new PCI domain for each controller. It's easier in architectures 
other than IA32, in a way, since they typically don't have the 64KB 
IO-space addressing limitation that makes heavily bridged systems 
problematical on IA32 (one tends to run out of IO space).
-- 
/Jonathan Lundell.
