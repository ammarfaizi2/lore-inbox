Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286386AbSAGG2f>; Mon, 7 Jan 2002 01:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286670AbSAGG21>; Mon, 7 Jan 2002 01:28:27 -0500
Received: from [202.54.26.202] ([202.54.26.202]:26503 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S286386AbSAGG2Q>;
	Mon, 7 Jan 2002 01:28:16 -0500
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256B3A.002382DF.00@sandesh.hss.hns.com>
Date: Mon, 7 Jan 2002 11:52:58 +0530
Subject: [PATCH] locked page handling in shrink_cache()
Mime-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=xWseNyNQTyz9w5GrzNa9mgPTH818sG6DS8o5J9D1If6EmlWRW2AD279j"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=xWseNyNQTyz9w5GrzNa9mgPTH818sG6DS8o5J9D1If6EmlWRW2AD279j
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline



Whenever the shrink_cache wakes up after a laundered page in unlocked, it should
move that page to the end of inactive list so that
the page can be freed immediately and shrink_cache dosen't have to wait for
complete list scan before freeing this page.

The patch is created against standard redhat 7.1 distribution 2.4.16 kernel.
Let me know if I need to create it for a different kernel release.

Regards
Amol
(See attached file: vmscan.c-2.4.16)

--0__=xWseNyNQTyz9w5GrzNa9mgPTH818sG6DS8o5J9D1If6EmlWRW2AD279j
Content-type: application/octet-stream; 
	name="vmscan.c-2.4.16"
Content-Disposition: attachment; filename="vmscan.c-2.4.16"
Content-transfer-encoding: base64

LS0tIHZtc2Nhbl9vcmlnLmMJTW9uIEphbiAgNyAxMTo0Nzo0MyAyMDAyCisrKyB2bXNjYW4uYwlN
b24gSmFuICA3IDExOjQ5OjA3IDIwMDIKQEAgLTM4Nyw2ICszODcsOCBAQAogCQkJCXdhaXRfb25f
cGFnZShwYWdlKTsKIAkJCQlwYWdlX2NhY2hlX3JlbGVhc2UocGFnZSk7CiAJCQkJc3Bpbl9sb2Nr
KCZwYWdlbWFwX2xydV9sb2NrKTsKKwkJCQlsaXN0X2RlbChwYWdlLT5scnUpOworCQkJCWxpc3Rf
YWRkKHBhZ2UtPmxydSxpbmFjdGl2ZV9saXN0LnByZXYpOwogCQkJfQogCQkJY29udGludWU7CiAJ
CX0K

--0__=xWseNyNQTyz9w5GrzNa9mgPTH818sG6DS8o5J9D1If6EmlWRW2AD279j--

