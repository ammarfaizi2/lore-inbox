Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266763AbSK1Vvd>; Thu, 28 Nov 2002 16:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266772AbSK1Vvd>; Thu, 28 Nov 2002 16:51:33 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:55014 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S266763AbSK1Vvb>;
	Thu, 28 Nov 2002 16:51:31 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Russell King <rmk@arm.linux.org.uk>
Date: Thu, 28 Nov 2002 22:58:35 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: [OT] Re: connectivity to bkbits.net?
Cc: linux-kernel@vger.kernel.org, lm@bitmover.com
X-mailer: Pegasus Mail v3.50
Message-ID: <8D5CDD20AEF@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Nov 02 at 21:13, Russell King wrote:
> On Thu, Nov 28, 2002 at 06:53:00PM +0200, Kai Henningsen wrote:
> > >From two or three traceroutes, that problem seems to be at the SGI end. I  
> > can't get to them either (nothing after the same IP as for you, at hop  
> > #17, some place at Genuity), but you are practically next door.
> 
> Lesson #1 of firewalling: drop everything.
> Lesson #2 of firewalling: only accept what you absolutely have to.
> 
> Try pointing a web browser at sgi.com port 80.  I _bet_ you get a
> response.  The site is reachable, they just block UDP (and probably
> a lot of other stuff.)
> 
> traceroute uses UDP, so if a site drops UDP (rather than blocking it)
> it will appear as a black hole.

Fortunately people do not sleep, and Michael C. Toren invented 
tcptraceroute, so you get same level of diagnostic, but by using
TCP instead of UDP probe... Very useful these days, as almost all
sites have TCP port 80 open ;-)
                                            Petr Vandrovec
                                            
                                            

vana:/mnt2$ tcptraceroute www.sgi.com
Selected device eth0, address 147.32.240.58, port 34029 for outgoing packets
Tracing the path to www.sgi.com (128.167.58.40) on TCP port 80, 30 hops max
 1  vc-gw.cvut.cz (147.32.240.254)  1.321 ms  1.153 ms  6.154 ms
 2  147.32.253.80 (147.32.253.80)  0.423 ms  0.339 ms  0.307 ms
 3  195.113.144.173 (195.113.144.173)  0.419 ms  0.372 ms  0.321 ms
 4  r41prg-pos13-0-stm16.cesnet.cz (195.113.156.110)  0.559 ms  0.635 ms  0.647 ms
 5  prag-b1-pos4-0.telia.net (213.248.77.117)  0.867 ms  0.800 ms  0.884 ms
 6  hbg-bb1-pos1-3-2.telia.net (213.248.64.181)  26.808 ms  26.885 ms  26.638 ms
 7  kbn-bb1-pos2-0-0.telia.net (213.248.64.29)  32.324 ms  32.372 ms  32.316 ms
 8  nyk-bb1-pos2-0-0.telia.net (213.248.64.110)  111.833 ms  111.701 ms  111.697 ms
 9  chi-bb1-pos0-1-0.telia.net (213.248.80.6)  137.653 ms  137.799 ms  137.962 ms
10  genuity2.k.telia.net (213.248.84.66)  134.193 ms  133.843 ms  133.846 ms
11  so-2-3-0.chcgil2-br1.bbnplanet.net (4.24.7.133)  132.150 ms  132.127 ms  132.033 ms
12  so-7-0-0.chcgil2-br2.bbnplanet.net (4.24.5.218)  132.175 ms  132.197 ms  132.248 ms
13  p4-0.dnvtco1-br2.bbnplanet.net (4.24.9.62)  187.552 ms  187.429 ms  188.031 ms
14  p15-0.snjpca1-br2.bbnplanet.net (4.0.6.225)  181.492 ms  181.259 ms  181.456 ms
15  p1-0.sjccolo-dbe2.bbnplanet.net (4.24.6.249)  187.192 ms  188.640 ms  187.578 ms
16  vlan40.sjccolo-isw03-rc1.bbnplanet.net (128.11.200.91)  187.261 ms  187.584 ms  187.468 ms
17  128.11.16.169 (128.11.16.169)  187.644 ms  187.481 ms  187.460 ms
18  www.sgi.com (128.167.58.40) [open]  181.586 ms  182.415 ms  181.513 ms
vana:/mnt2$
