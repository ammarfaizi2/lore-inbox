Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288936AbSAGHDT>; Mon, 7 Jan 2002 02:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287817AbSAGHC6>; Mon, 7 Jan 2002 02:02:58 -0500
Received: from [202.54.26.202] ([202.54.26.202]:21901 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S287750AbSAGHCy>;
	Mon, 7 Jan 2002 02:02:54 -0500
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256B3A.0026A967.00@sandesh.hss.hns.com>
Date: Mon, 7 Jan 2002 12:27:21 +0530
Subject: [PATCH] [errata] locked page handling in shrink_cache
Mime-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=WBXISaANvUjcTwNF6f8iONRoiSSz8Nre8VKiI0lCEZ42NYMxahR8Oz9B"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=WBXISaANvUjcTwNF6f8iONRoiSSz8Nre8VKiI0lCEZ42NYMxahR8Oz9B
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline



please ignore previous patch ...
----

Whenever the shrink_cache wakes up after a laundered page in unlocked, it should
move that page to the end of inactive list so that
the page can be freed immediately and shrink_cache dosen't have to wait for
complete list scan before freeing this page.

The patch is created against standard redhat 7.1 distribution 2.4.16 kernel.
Let me know if I need to create it for a different kernel release.

regards
Amol

(See attached file: vmscan.c-2.4.16)

--0__=WBXISaANvUjcTwNF6f8iONRoiSSz8Nre8VKiI0lCEZ42NYMxahR8Oz9B
Content-type: application/octet-stream; 
	name="vmscan.c-2.4.16"
Content-Disposition: attachment; filename="vmscan.c-2.4.16"
Content-transfer-encoding: base64

LS0tIHZtc2Nhbl9vcmlnLmMJTW9uIEphbiAgNyAxMTo0Nzo0MyAyMDAyCisrKyB2bXNjYW4uYwlN
b24gSmFuICA3IDExOjQ5OjA3IDIwMDIKQEAgLTM4Nyw2ICszODcsOCBAQAogCQkJCXdhaXRfb25f
cGFnZShwYWdlKTsKIAkJCQlwYWdlX2NhY2hlX3JlbGVhc2UocGFnZSk7CiAJCQkJc3Bpbl9sb2Nr
KCZwYWdlbWFwX2xydV9sb2NrKTsKKwkJCQlsaXN0X2RlbCgmcGFnZS0+bHJ1KTsKKwkJCQlsaXN0
X2FkZCgmcGFnZS0+bHJ1LGluYWN0aXZlX2xpc3QucHJldik7CiAJCQl9CiAJCQljb250aW51ZTsK
IAkJfQo=

--0__=WBXISaANvUjcTwNF6f8iONRoiSSz8Nre8VKiI0lCEZ42NYMxahR8Oz9B--

