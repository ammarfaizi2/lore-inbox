Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263081AbSJ1H51>; Mon, 28 Oct 2002 02:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbSJ1H51>; Mon, 28 Oct 2002 02:57:27 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:3768 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263081AbSJ1H50>;
	Mon, 28 Oct 2002 02:57:26 -0500
From: "David Stevens" <dlstevens@us.ibm.com>
Importance: Normal
Sensitivity: 
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF57A7ECE2.6A498177-ON88256C60.002B9601@boulder.ibm.com>
Date: Mon, 28 Oct 2002 01:03:03 -0700
Subject: [PATCH] missing aio_exit() call, 2.5.44 
X-MIMETrack: Serialize by Router on D03NM035/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/28/2002 01:03:15 AM
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=07BBE6F3DFB810918f9e8a93df938690918c07BBE6F3DFB81091"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=07BBE6F3DFB810918f9e8a93df938690918c07BBE6F3DFB81091
Content-type: text/plain; charset=us-ascii


Ben,
      Sorry if this is a duplicate. Jay Vosburgh and I were doing some
testing with AIO and found that we were running out of kiocb's, tracked to
a missing call to aio_exit() on process exit. In 2.4.19, there was also
another call in exec.c, which I didn't check out for application to 2.5.44.

                              +-DLS

(See attached file: aiofix.patch)


--0__=07BBE6F3DFB810918f9e8a93df938690918c07BBE6F3DFB81091
Content-type: application/octet-stream; 
	name="aiofix.patch"
Content-Disposition: attachment; filename="aiofix.patch"
Content-transfer-encoding: base64

LS0tIC90bXAvbGludXgtMi41LjQ0L2tlcm5lbC9mb3JrLmMJRnJpIE9jdCAxOCAyMTowMToxMSAy
MDAyCisrKyBsaW51eC0yLjUuNDRBSU8va2VybmVsL2ZvcmsuYwlTYXQgT2N0IDI2IDIxOjAxOjE0
IDIwMDIKQEAgLTM1Myw2ICszNTMsNyBAQAogCQlsaXN0X2RlbCgmbW0tPm1tbGlzdCk7CiAJCW1t
bGlzdF9uci0tOwogCQlzcGluX3VubG9jaygmbW1saXN0X2xvY2spOworCQlleGl0X2FpbyhtbSk7
CiAJCWV4aXRfbW1hcChtbSk7CiAJCW1tZHJvcChtbSk7CiAJfQo=

--0__=07BBE6F3DFB810918f9e8a93df938690918c07BBE6F3DFB81091--

