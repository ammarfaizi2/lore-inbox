Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269878AbUJHMMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269878AbUJHMMw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 08:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269889AbUJHMMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 08:12:52 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:40094 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S269878AbUJHMMt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 08:12:49 -0400
Date: Fri, 8 Oct 2004 14:10:45 +0200
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Mailer: The Bat! (v3.0) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1886784988.20041008141045@dns.toxicfilms.tv>
To: netdev@oss.sgi.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Update tcp_tso_win_divisor sysctl information in ip-sysctl.txt
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----------1E1F21573E4DE261"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------1E1F21573E4DE261
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I noticed that newly added tcp_tso_win_divisor did not go
with a description to ip-sysctl.txt

This patch updates this information.

Regards,
Maciej

diff -u linux.orig/Documentation/networking/ip-sysctl.txt linux/Documentation/networking/ip-sysctl.txt
--- linux.orig/Documentation/networking/ip-sysctl.txt   2004-10-08 13:27:36.000000000 +0200
+++ linux/Documentation/networking/ip-sysctl.txt        2004-10-08 13:28:56.000000000 +0200
@@ -355,6 +355,12 @@
        conections.
        Default: 7

+tcp_tso_win_divisor - INTEGER
+       This allows control over what percentage of the congestion window
+       can be consumed by a single TSO frame.
+       The setting of this parameter is a choice between burstiness and
+       building larger TSO frames.
+       Default: 8

 tcp_frto - BOOLEAN
        Enables F-RTO, an enhanced recovery algorithm for TCP retransmission

------------1E1F21573E4DE261
Content-Type: application/octet-stream; name="ip-sysctl.txt.diff"
Content-transfer-encoding: base64
Content-Disposition: attachment; filename="ip-sysctl.txt.diff"

ZGlmZiAtdSBsaW51eC5vcmlnL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9pcC1zeXNjdGwu
dHh0IGxpbnV4L0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9pcC1zeXNjdGwudHh0Ci0tLSBs
aW51eC5vcmlnL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9pcC1zeXNjdGwudHh0ICAgMjAw
NC0xMC0wOCAxMzoyNzozNi4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4L0RvY3VtZW50YXRp
b24vbmV0d29ya2luZy9pcC1zeXNjdGwudHh0ICAgICAgICAyMDA0LTEwLTA4IDEzOjI4OjU2
LjAwMDAwMDAwMCArMDIwMApAQCAtMzU1LDYgKzM1NSwxMiBAQAogICAgICAgIGNvbmVjdGlv
bnMuCiAgICAgICAgRGVmYXVsdDogNwoKK3RjcF90c29fd2luX2Rpdmlzb3IgLSBJTlRFR0VS
CisgICAgICAgVGhpcyBhbGxvd3MgY29udHJvbCBvdmVyIHdoYXQgcGVyY2VudGFnZSBvZiB0
aGUgY29uZ2VzdGlvbiB3aW5kb3cKKyAgICAgICBjYW4gYmUgY29uc3VtZWQgYnkgYSBzaW5n
bGUgVFNPIGZyYW1lLgorICAgICAgIFRoZSBzZXR0aW5nIG9mIHRoaXMgcGFyYW1ldGVyIGlz
IGEgY2hvaWNlIGJldHdlZW4gYnVyc3RpbmVzcyBhbmQKKyAgICAgICBidWlsZGluZyBsYXJn
ZXIgVFNPIGZyYW1lcy4KKyAgICAgICBEZWZhdWx0OiA4CgogdGNwX2ZydG8gLSBCT09MRUFO
CiAgICAgICAgRW5hYmxlcyBGLVJUTywgYW4gZW5oYW5jZWQgcmVjb3ZlcnkgYWxnb3JpdGht
IGZvciBUQ1AgcmV0cmFuc21pc3Npb24K
------------1E1F21573E4DE261--

