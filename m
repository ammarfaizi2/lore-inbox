Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUGMBvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUGMBvW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 21:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUGMBvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 21:51:21 -0400
Received: from [203.178.140.15] ([203.178.140.15]:39686 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261426AbUGMBvQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 21:51:16 -0400
Date: Tue, 13 Jul 2004 10:51:20 +0900 (JST)
Message-Id: <20040713.105120.00197019.yoshfuji@linux-ipv6.org>
To: cra@WPI.EDU
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: v2.6 IGMPv3 implementation
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040713012152.GL7822@angus.ind.WPI.EDU>
References: <20040712203056.GI7822@angus.ind.WPI.EDU>
	<20040713.062226.130914590.yoshfuji@linux-ipv6.org>
	<20040713012152.GL7822@angus.ind.WPI.EDU>
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

In article <20040713012152.GL7822@angus.ind.WPI.EDU> (at Mon, 12 Jul 2004 21:21:52 -0400), "Charles R. Anderson" <cra@WPI.EDU> says:

> On Tue, Jul 13, 2004 at 06:22:26AM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> > These ioctls are "historic" and deprecated API.
> > So, just kill them to avoid confusion.
> > We use socket options.
> 
> Thank you.  I have now read RFC3678 carefully and I have more
> questions.  The kernel still declares the structs used for these
> obsolete ioctls, but instead defines sockoptions for them:
:
> Is it intended that glibc use these sockoptions internally for its
> implementation of the approved Advanced API functions, which are then
> exported to user programs:
> 
> setipv4sourcefilter()
> getipv4sourcefilter()
> setsourcefilter()
> getsourcefilter()

Yes.

> Does the following limitation from RFC3678 Appendix A (rationale for
> the ioctl interface) apply to the Linux kernel getsockopt(), or can

No, so we can do both (set/get) by sockopt.

--yoshfuji
