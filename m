Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129730AbQLGIc7>; Thu, 7 Dec 2000 03:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLGIcv>; Thu, 7 Dec 2000 03:32:51 -0500
Received: from dns.growzone.com.au ([202.9.32.1]:16915 "EHLO
	mail.growzone.com.au") by vger.kernel.org with ESMTP
	id <S129226AbQLGIcj>; Thu, 7 Dec 2000 03:32:39 -0500
Message-Id: <200012070801.eB781RY23347@gandalf.growzone.com.au>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-net <linux-net@vger.kernel.org>
X-Face: ]IrGs{LrofDtGfsrG!As5=G'2HRr2zt:H>djXb5@v|Dr!jOelxzAZ`!}("]}]
	Q!)1w#X;)nLlb'XhSu,QL>;)L/l06wsI?rv-xy6%Y1e"BUiV%)mU;]f-5<#U6
	UthZ0QrF7\_p#q}*Cn}jd|XT~7P7ik]Q!2u%aTtvc;)zfH\:3f<[a:)M
Organization: GrowZone OnLine
X-Mailer: nmh-1.0.4 exmh-2.2
X-OS: Linux-2.4.0 RedHat 7.0
X-URL: http://www.growzone.com.au/tony
Subject: Re: How to programatically determine if policy-based routing is compiled into the kernel? 
In-Reply-To: message-id <3A2F3FE7.5CDD0EDA@candelatech.com> 
	 of Thu, Dec 07 00:44:39 2000
Date: Thu, 07 Dec 2000 18:01:27 +1000
From: Tony Nugent <tony@growzone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Dec 07 2000 at 00:44, Ben Greear wrote:

> I have a product that is dependent on policy-based (source routing)
> and would like to be able to scream loudly at install and startup if
> policy-based routing is not enabled in the kernel.
> 
> Is there some way to determine this?  Specifically, I'd love
> a way to find out through the /proc system, but an ioctl or
> similar call would be OK.  I'd even settle for some other tool,
> like 'ip', if I could just figure out what commands to tell it.

Run a command that attempts to use policy-based routing (doing
something "benign" like a listing).  If it fails then good chance
that it isn't compiled in :-)

[ or it may simply mean that the appropriate modules are not loaded,
so beware that one :]

That command would need to be /sbin/ip or /sbin/tc or whatever.

If you want to ferrit out what proc looks like with and without
routing policy enabled, that would be another way to do it.

Cheers
Tony
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
