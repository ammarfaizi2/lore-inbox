Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265885AbUGIUBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265885AbUGIUBz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 16:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUGIUBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 16:01:55 -0400
Received: from [203.178.140.15] ([203.178.140.15]:43780 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S265885AbUGIUBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 16:01:46 -0400
Date: Sat, 10 Jul 2004 05:01:47 +0900 (JST)
Message-Id: <20040710.050147.104096421.yoshfuji@linux-ipv6.org>
To: linux-kernel@borntraeger.net, linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, bastian@waldi.eu.org, yoshfuji@linux-ipv6.org,
       davem@redhat.com
Subject: Re: [PATCH] s390 - mark IPv6 support for QETH as broken
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200407092115.18097.linux-kernel@borntraeger.net>
References: <20040709140630.GA27350@wavehammer.waldi.eu.org>
	<20040709120336.74e57ceb.akpm@osdl.org>
	<200407092115.18097.linux-kernel@borntraeger.net>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200407092115.18097.linux-kernel@borntraeger.net> (at Fri, 9 Jul 2004 21:15:17 +0200), Christian Borntraeger <linux-kernel@borntraeger.net> says:

> Andrew Morton wrote:
> > Bastian Blank <bastian@waldi.eu.org> wrote:
> > >  The attached patch marks IPv6 support for QETH broken, it is known to
> > >  need an extra patch to compile which was submitted one year ago but
> > >  never accepted.
> >
> > Well fixing it would be the preferable approach.  Where is the "extra
> > patch" and what was the complaint?
> 
> http://oss.sgi.com/projects/netdev/archive/2003-02/msg00061.html

I don't see why it does NOT compile as you said.
It tried to add scheme for driver-specific interface identifier 
(including EUI-64 based on hardware address) generation scheme 
(in addition to the current ont; device-type-specific one).

> The problem is that on s390 several virtual servers share the PHY and MAC 
> part of the card and therefore have the same MAC address. Unfortunately 
> IPv6 uses this MAC address to build an address. Now all virtual servers 
> have the same auto configured IPv6 address - which is bad.
> The proposed solution was to enable network card drivers to define their own 
> ipv6 address auto configuration. 

I think it would be good to store interface identifier when
initializing interface, by RTM_NEWLINK attribute probably.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
