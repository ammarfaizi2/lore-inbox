Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVC1Jbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVC1Jbj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 04:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVC1Jbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 04:31:39 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:46342 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261393AbVC1Jbd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 04:31:33 -0500
Date: Mon, 28 Mar 2005 18:33:31 +0900 (JST)
Message-Id: <20050328.183331.119479139.yoshfuji@linux-ipv6.org>
To: jengelh@linux01.gwdg.de
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       from-linux-kernel@I-love.sakura.ne.jp, yoshfuji@linux-ipv6.org
Subject: Re: Off-by-one bug at unix_mkname ?
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.61.0503281124450.18443@yvahk01.tjqt.qr>
References: <20050328.172108.30349253.yoshfuji@linux-ipv6.org>
	<20050328.173938.26746686.yoshfuji@linux-ipv6.org>
	<Pine.LNX.4.61.0503281124450.18443@yvahk01.tjqt.qr>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.61.0503281124450.18443@yvahk01.tjqt.qr> (at Mon, 28 Mar 2005 11:25:39 +0200 (MEST)), Jan Engelhardt <jengelh@linux01.gwdg.de> says:

> 
> On Mar 28 2005 17:39, YOSHIFUJI Hideaki / 吉藤英明 wrote:
> 
> >+		 *	This may look like an off by one error but it is
> >+		 *	a bit more subtle. 108 is the longest valid AF_UNIX
> >+		 *	path for a binding. sun_path[108] doesnt as such
> >+		 *	exist. However in kernel space we are guaranteed that
> >+		 *	it is a valid memory location in our kernel
> >+		 *	address buffer.
> >+		 */
> 
> Now, does 2.6. _still_ guarantee that 108 is a valid offset?

Yes, it does.

--yoshfuji
