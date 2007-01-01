Return-Path: <linux-kernel-owner+w=401wt.eu-S1755138AbXAABFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138AbXAABFS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 20:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755160AbXAABFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 20:05:18 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:41403 "EHLO
	yue.st-paulia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138AbXAABFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 20:05:17 -0500
Date: Mon, 01 Jan 2007 10:05:58 +0900 (JST)
Message-Id: <20070101.100558.123823206.yoshfuji@linux-ipv6.org>
To: ioe-lkml@rameria.de
Cc: bernd@firmix.at, jengelh@linux01.gwdg.de, pavel@ucw.cz, amit2030@yahoo.com,
       linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] [DISCUSS] Make the variable NULL after freeing it.
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200701010143.02870.ioe-lkml@rameria.de>
References: <Pine.LNX.4.61.0612280952450.15825@yvahk01.tjqt.qr>
	<1167572312.3318.47.camel@gimli.at.home>
	<200701010143.02870.ioe-lkml@rameria.de>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200701010143.02870.ioe-lkml@rameria.de> (at Mon, 1 Jan 2007 01:43:00 +0100), Ingo Oeser <ioe-lkml@rameria.de> says:

> On Sunday, 31. December 2006 14:38, Bernd Petrovitsch wrote:
> > That depends on the decision/definition if (so called) "double free" is
> > an error or not (and "free(NULL)" must work in POSIX-compliant
> > environments).
> 
> A double free of non-NULL is certainly an error.
> So the idea of setting it to NULL is ok, since then you can
> kfree the variable over and over again without any harm.

I dislike (or, say, I hate) this idea; people should fix up
such broken code paths.

--yoshfuji
