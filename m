Return-Path: <linux-kernel-owner+w=401wt.eu-S1751065AbXAIFV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbXAIFV5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 00:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbXAIFV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 00:21:57 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:45328 "EHLO
	yue.st-paulia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbXAIFVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 00:21:55 -0500
Date: Tue, 09 Jan 2007 14:22:44 +0900 (JST)
Message-Id: <20070109.142244.31020926.yoshfuji@linux-ipv6.org>
To: davem@davemloft.net
Cc: craig@codefountain.com, davem@davemloft.net, komurojun-mbn@nifty.com,
       bunk@stusta.de, jgarzik@pobox.com, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] Re: [BUG KERNEL 2.6.20-rc1] ftp: get or put stops
 during file-transfer
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20070109051139.GA2229@craigdell.detnet.com>
References: <20070104122330.GA2233@craigdell.detnet.com>
	<20070109.102453.32711440.yoshfuji@linux-ipv6.org>
	<20070109051139.GA2229@craigdell.detnet.com>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Tue_Jan__9_14_22_44_2007_334)--"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Next_Part(Tue_Jan__9_14_22_44_2007_334)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dave, please apply.  Thank you.

In article <20070109051139.GA2229@craigdell.detnet.com> (at Tue, 9 Jan 2007 07:11:39 +0200), Craig Schlenter <craig@codefountain.com> says:

> All credit goes to Komuro <komurojun-mbn@nifty.com> for tracking
> this down. The patch is untested but it looks *cough* obviously
> correct.
> 
> Signed-off-by: Craig Schlenter <craig@codefountain.com>
Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

----Next_Part(Tue_Jan__9_14_22_44_2007_334)--
Content-Type: Message/Rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Return-Path: <craig@codefountain.com>
X-Original-To: yoshfuji@yue.st-paulia.net
Delivered-To: yoshfuji@yue.st-paulia.net
Received: from sapphire.st-paulia.net (unknown [IPv6:2001:200:1b0:1000:201:80ff:fe5c:5cf])
	by yue.st-paulia.net (Postfix) with ESMTP id 359CC33B40
	for <yoshfuji@yue.st-paulia.net>; Tue,  9 Jan 2007 14:15:28 +0900 (JST)
Received: by sapphire.st-paulia.net (Postfix)
	id 3058B23CDD; Tue,  9 Jan 2007 14:06:02 +0900 (JST)
Delivered-To: yoshfuji@sapphire.st-paulia.net
Received: from nezu.linux-ipv6.org (unknown [IPv6:2001:200:0:1c01:20f:1fff:fe67:32e9])
	by sapphire.st-paulia.net (Postfix) with ESMTP id 0685123CA4
	for <yoshfuji@sapphire.st-paulia.net>; Tue,  9 Jan 2007 14:05:59 +0900 (JST)
Received: from craigdell.detnet.com (myw-stp-196-34-113-243.sentechsa.net [196.34.113.243])
	by nezu.linux-ipv6.org (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l095EPFC016814
	for <yoshfuji@linux-ipv6.org>; Tue, 9 Jan 2007 14:14:27 +0900
Received: from craigdell.detnet.com (craigdell.detnet.com [127.0.0.1])
	by craigdell.detnet.com (8.13.8/8.13.8) with ESMTP id l095BucK002873;
	Tue, 9 Jan 2007 07:11:56 +0200
Received: (from craig@localhost)
	by craigdell.detnet.com (8.13.8/8.13.8/Submit) id l095BeQm002869;
	Tue, 9 Jan 2007 07:11:40 +0200
X-Authentication-Warning: craigdell.detnet.com: craig set sender to craig@codefountain.com using -f
Date: Tue, 9 Jan 2007 07:11:39 +0200
From: Craig Schlenter <craig@codefountain.com>
To: YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= <yoshfuji@linux-ipv6.org>,
	davem@davemloft.net
Cc: komurojun-mbn@nifty.com, bunk@stusta.de, jgarzik@pobox.com,
	viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] Re: [BUG KERNEL 2.6.20-rc1] ftp: get or put stops during file-transfer
Message-ID: <20070109051139.GA2229@craigdell.detnet.com>
References: <20061230.231952.16573563.yoshfuji@linux-ipv6.org> <20070105054546.953196e5.komurojun-mbn@nifty.com> <20070104122330.GA2233@craigdell.detnet.com> <20070109.102453.32711440.yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20070109.102453.32711440.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.4.2.2i
Mime-Version: 1.0 (modified by Mew)
Content-Transfer-Encoding: base64 (modified by Mew)

SGkgRGF2ZQ0KDQpZT1NISUZVSkkgSGlkZWFraSAvIOWQieiXpOiLseaYjiBoYXMgc3VnZ2VzdGVk
IHRoYXQgSSBzZW5kIHRoZSBwYXRjaA0KYmVsb3cgdG8gZml4IHRoZSBmdHAgc3RhbGxzIHByZXNl
bnQgaW4gdGhlIGN1cnJlbnQga2VybmVscy4NCg0KQWxsIGNyZWRpdCBnb2VzIHRvIEtvbXVybyA8
a29tdXJvanVuLW1ibkBuaWZ0eS5jb20+IGZvciB0cmFja2luZw0KdGhpcyBkb3duLiBUaGUgcGF0
Y2ggaXMgdW50ZXN0ZWQgYnV0IGl0IGxvb2tzICpjb3VnaCogb2J2aW91c2x5DQpjb3JyZWN0Lg0K
DQpTaWduZWQtb2ZmLWJ5OiBDcmFpZyBTY2hsZW50ZXIgPGNyYWlnQGNvZGVmb3VudGFpbi5jb20+
DQoNClRoYW5rIHlvdSENCg0KLS1DcmFpZw0KDQpkaWZmIC0tZ2l0IGEvbmV0L2lwdjQvdGNwX2lw
djQuYyBiL25ldC9pcHY0L3RjcF9pcHY0LmMNCmluZGV4IGJmN2EyMjQuLjEyZGU5MGEgMTAwNjQ0
DQotLS0gYS9uZXQvaXB2NC90Y3BfaXB2NC5jDQorKysgYi9uZXQvaXB2NC90Y3BfaXB2NC5jDQpA
QCAtNjQ4LDcgKzY0OCw3IEBAIHN0YXRpYyB2b2lkIHRjcF92NF9zZW5kX2FjayhzdHJ1Y3QgdGNw
X3RpbWV3YWl0X3NvY2sgKnR3c2ssDQogCQkJCSAgIFRDUE9MRU5fVElNRVNUQU1QKTsNCiAJCXJl
cC5vcHRbMV0gPSBodG9ubCh0Y3BfdGltZV9zdGFtcCk7DQogCQlyZXAub3B0WzJdID0gaHRvbmwo
dHMpOw0KLQkJYXJnLmlvdlswXS5pb3ZfbGVuID0gVENQT0xFTl9UU1RBTVBfQUxJR05FRDsNCisJ
CWFyZy5pb3ZbMF0uaW92X2xlbiArPSBUQ1BPTEVOX1RTVEFNUF9BTElHTkVEOw0KIAl9DQogDQog
CS8qIFN3YXAgdGhlIHNlbmQgYW5kIHRoZSByZWNlaXZlLiAqLw0K

----Next_Part(Tue_Jan__9_14_22_44_2007_334)----
