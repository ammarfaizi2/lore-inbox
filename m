Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbULGRee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbULGRee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 12:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbULGReL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 12:34:11 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:35854 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261862AbULGRd7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 12:33:59 -0500
Date: Wed, 08 Dec 2004 02:35:30 +0900 (JST)
Message-Id: <20041208.023530.26430801.yoshfuji@linux-ipv6.org>
To: mitch@sfgoth.com
Cc: kernel@linuxace.com, davem@davemloft.net, shemminger@osdl.org,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] fix select() for SOCK_RAW sockets
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20041207150834.GA75700@gaz.sfgoth.com>
References: <20041207045302.GA23746@linuxace.com>
	<20041207054840.GD61527@gaz.sfgoth.com>
	<20041207150834.GA75700@gaz.sfgoth.com>
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

In article <20041207150834.GA75700@gaz.sfgoth.com> (at Tue, 7 Dec 2004 07:08:34 -0800), Mitchell Blank Jr <mitch@sfgoth.com> says:

> Phil: Here's a real patch for you to test.  I actually left inet_dgram_ops
> alone since it's an exported symbol (two of the users just want the .do_ioctl
> value which is the same between SOCK_DGRAM and SOCK_RAW; the other is ipv6
> where it's clearly dealing with a UDP socket -- therefore I think its safest
> to leave inet_dgram_ops to have the UDP behavior)

Probably, we need to do the same for ipv6, don't we?

--yoshfuji
