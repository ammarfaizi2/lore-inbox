Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbTH1AeG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 20:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263331AbTH1AeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 20:34:06 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:55819 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262948AbTH1AeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 20:34:04 -0400
Date: Thu, 28 Aug 2003 09:34:20 +0900 (JST)
Message-Id: <20030828.093420.37091433.yoshfuji@linux-ipv6.org>
To: jfbeam@bluetronic.net
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: /proc/net/* read drops data
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.GSO.4.33.0308271935550.7750-100000@sweetums.bluetronic.net>
References: <Pine.GSO.4.33.0308271658370.7750-100000@sweetums.bluetronic.net>
	<Pine.GSO.4.33.0308271935550.7750-100000@sweetums.bluetronic.net>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.33.0308271935550.7750-100000@sweetums.bluetronic.net> (at Wed, 27 Aug 2003 19:58:17 -0400 (EDT)), Ricky Beam <jfbeam@bluetronic.net> says:

> On Wed, 27 Aug 2003, Ricky Beam wrote:
> >This smells like a simple "off by one" bug, but I've been too busy to go
> >look at the code.
> 
> Ah hah!  it's a block size problem... netstat reads 1024 at a time.
> 
> Using dd...
> 
> [root:pts/5{9}]gir:~/[7:55pm]:dd if=/proc/net/udp bs=1024 | wc
> 2+1 records in
> 2+1 records out
>      18     216    2304

Good idea. I'll chase this bug.

--yoshfuji
