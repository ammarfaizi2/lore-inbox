Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751711AbWJERYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWJERYN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWJERYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:24:13 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:37391 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1751355AbWJERYL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:24:11 -0400
Date: Fri, 06 Oct 2006 02:26:35 +0900 (JST)
Message-Id: <20061006.022635.85990065.yoshfuji@linux-ipv6.org>
To: jmorris@namei.org
Cc: joro-lkml@zlug.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH][RFC] net/ipv6: seperate sit driver to extra module
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.64.0610051148230.23631@d.namei>
References: <20061005154152.GA2102@zlug.org>
	<Pine.LNX.4.64.0610051148230.23631@d.namei>
Organization: USAGI/WIDE Project
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

In article <Pine.LNX.4.64.0610051148230.23631@d.namei> (at Thu, 5 Oct 2006 11:49:38 -0400 (EDT)), James Morris <jmorris@namei.org> says:

> On Thu, 5 Oct 2006, Joerg Roedel wrote:
> 
> > Is there a reason why the tunnel driver for IPv6-in-IPv4 is currently
> > compiled into the ipv6 module? This driver is only needed in gateways
> > between different IPv6 networks. On all other hosts with ipv6 enabled it
> > is not required. To have this driver in a seperate module will save
> > memory on those machines.
> > I appended a small and trival patch to 2.6.18 which does exactly this.
> 
> Looks ok to me, although given that users used to get this by default when 
> selecting IPv6, perhaps the default in Kconfig should be y.

Agreed.  And, we could add #ifdef in addrconf.c.

--yoshfuji
