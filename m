Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267597AbTBDX5k>; Tue, 4 Feb 2003 18:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267598AbTBDX5k>; Tue, 4 Feb 2003 18:57:40 -0500
Received: from f137.law12.hotmail.com ([64.4.19.137]:27403 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S267597AbTBDX5j>;
	Tue, 4 Feb 2003 18:57:39 -0500
X-Originating-IP: [156.153.255.126]
From: "Dave Slicer" <slice1900@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: disabling nagle
Date: Wed, 05 Feb 2003 00:01:22 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F137jnt61tqeaVRMPjc00012673@hotmail.com>
X-OriginalArrivalTime: 05 Feb 2003 00:01:22.0750 (UTC) FILETIME=[B7F325E0:01C2CCA9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Feb 04, 2003 at 11:39:16AM -0800, Fiona Sou-Yee Wong wrote:
>I have kernel version 2.4.18 and I was looking for a patch to have the
>option to disable NAGLE's algorithm.
>Is there a patch available for kernels 2.4 and greater and if not, what
>other options do I have?


Others already answered this specific question, but I wonder how hard it 
would be to create a patch to disable TCP's timeout and retransmit 
mechanisms on a given interface?  This would allow those of us who have no 
alternative other than PPP over ssh for VPN to greatly improve performance.  
Over a well behaved connection this works acceptably, but given any delays 
or packet loss it is essentially unusable.  I know the real answer is using 
something other than TCP as the transport layer for the tunnel (IPSEC, IP 
over IP, UDP, etc.) but that isn't always possible.  So I'd like a way to 
treat the ppp interface the VPN tunnel creates as a completely reliable 
transport for which normal TCP/IP retransmits and timeouts don't apply.  
It'd just bullheadedly go along transmitting data and assuming it was 
received -- the underlying TCP transport can take care of making the link 
reliable.

Is this even remotely reasonable?  If it would cause performance degradation 
it'd have to be a config option or never make the kernel at all (Linus may 
never accept it regardless I suppose)  But ignoring that for a moment, is it 
just too hairy to contemplate?  I've done a few patches here and there for 
Linux in the past, but nothing like this (and nothing involving networking) 
so it is far beyond my capability.  But if something was cooked up that 
works well enough I'd be willing to try polishing it and porting between 
kernel versions where necessary.

But I'd take any suggestions for alterations in /proc/sys/net/ipv4/* that 
might help the current state of things.


_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail

