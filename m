Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTJ3Dla (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 22:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTJ3Dla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 22:41:30 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:13330 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262174AbTJ3Dl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 22:41:27 -0500
Date: Thu, 30 Oct 2003 12:41:24 +0900 (JST)
Message-Id: <20031030.124124.26191552.yoshfuji@linux-ipv6.org>
To: jmorris@redhat.com
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       davem@redhat.com, yoshfuji@linux-ipv6.org
Subject: Re: Bug somewhere in crypto or ipsec stuff
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Xine.LNX.4.44.0310292221320.23405-100000@thoron.boston.redhat.com>
References: <20031030.121732.12858700.yoshfuji@linux-ipv6.org>
	<Xine.LNX.4.44.0310292221320.23405-100000@thoron.boston.redhat.com>
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

In article <Xine.LNX.4.44.0310292221320.23405-100000@thoron.boston.redhat.com> (at Wed, 29 Oct 2003 22:22:50 -0500 (EST)), James Morris <jmorris@redhat.com> says:

> On Thu, 30 Oct 2003, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:
> 
> 
> > I would just disallow name == NULL,
> > well, what algorithm do you expect?
> 
> Good question.  It seems to me to be a bug in the calling code if it is 
> trying to look up nothing -- I'd rather not paper that over.

Do you mean that we need to fix the caller?

Well, people may want to get just any algorithm.
In such case,
 - crypto allows name == NULL, and return any algorithm
   (for example, an algorithm that we see first.)
 - caller may filter name == NULL case if it is ambiguous in their context.

--yoshfuji
