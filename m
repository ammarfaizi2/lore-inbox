Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281450AbRKZD3m>; Sun, 25 Nov 2001 22:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281161AbRKZD3d>; Sun, 25 Nov 2001 22:29:33 -0500
Received: from [199.247.156.30] ([199.247.156.30]:5054 "HELO
	whitehorse.blackwire.com") by vger.kernel.org with SMTP
	id <S281450AbRKZD3P>; Sun, 25 Nov 2001 22:29:15 -0500
From: pjordan@whitehorse.blackwire.com
Date: Sun, 25 Nov 2001 19:23:42 -0800
To: linux-kernel@vger.kernel.org
Cc: ja@ssi.bg
Subject: Re: net/ipv4/arp.c: arp_rcv, rfc2131 BREAKS communication
Message-ID: <20011125192342.A16939@panama>
In-Reply-To: <Pine.LNX.4.33.0111251117310.823-100000@u.domain.uli> <20011125181921.A16765@panama>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011125181921.A16765@panama>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When an address resolution packet is received, the receiving Ethernet module gives the packet to the Address Resolution module which goes through an
> algorithm similar to the following. Negative conditionals indicate an end of processing and a discarding of the packet. 
 
>     ?Am I the target protocol address?
>     Yes:

> Maybe the right fix then is to set DHA to all ones. ffffffffffff. ?

No. Shake my head, the above is a reference to TIP, not THA.
and DHA is already set correctly anyway. (what was I drinking..)

Anyway.. RFC2131 only talks about the format of the arp request and not of
the arp reply.  I will test again to see if OF is testing THA or TIP.
 My guess is TIP.

So how to get the fix incorporated into the kernel though.
I don't see why it would break anything else.

Peter
