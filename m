Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBBD1r>; Thu, 1 Feb 2001 22:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRBBD1i>; Thu, 1 Feb 2001 22:27:38 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:11283 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S129098AbRBBD1S>; Thu, 1 Feb 2001 22:27:18 -0500
Message-ID: <3A7A28B0.7030105@redhat.com>
Date: Thu, 01 Feb 2001 21:25:36 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Fritzler <mid@earth.zigamorph.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: novatel minstrel on 2.4
In-Reply-To: <Pine.LNX.4.21.0102020204180.26932-100000@earth.zigamorph.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Fritzler wrote:

> We've been trying to set up a laptop here to use a Novatel Minstrel PCMCIA
> modem (wireless Richocet network).  The card shows up as a serial port
> (ttySx) and accepts AT commands just like a normal modem.
>

I'm in the process of bringing up a Novatel Merlin now (tomorrow morning 
actually). I don't know how similar it is, but they do at least use some 
common hardware on the Merlin and Sage products.

> It dials fine, PPP connects, gets IPs, etc just as it should.  However,
> any packet over about 400 bytes gets dropped on the recieve.  Also, the RX
> errors on ppp0 increment occasionally.  
> 

According to http://people.freebsd.org/~nsayer/ you have to set the mru 
to 576 for the Merlin. There is some fairly detailed info on 
http://www.mrollins.com/newtmerlin.html about setting it up for (of all 
things) a Newton including all the expected commands which implies that 
you should adjust the mru setting on the card and then match that with ppp.

> TCP connections connect (because the SYN's are small), but as soon as you
> start trying to do bulk transfers (`ls -la` in an ssh window, or an HTTP
> GET), the connection stalls.  Pinging other hosts also works fine, except
> when you do -s with a value larger than 300 or so.
> 
> It doesn't work with anything we've tried on 2.4 (changing mtu/mru, serial
> port speed, etc). However, under 2.2.x, we were able to get connections to
> stay running and not stall by setting the MTU on ppp0 to 120 after the ppp
> comes up.  As you can imagine, this makes the modem seem even slower than
> it already is.
> 
> Not that its relevent, but pppstats shows 0 in the 'vjcomp' fields of
> both rx and tx (as well as 'vjerr').  I've tried starting pppd with and
> without 'novj' just in case.  Same result.
> 
> Any ideas?  The 'rx error' count going up is kind of suspicious.  My
> attempts at getting pppd to print more debugging output have been
> futile; aparently the debug and kdebug options no longer work ('debug'
> produces the LCP traffic, yes, but thats working fine).
> 
> af
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/


-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
