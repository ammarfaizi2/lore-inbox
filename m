Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWJVRP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWJVRP3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 13:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWJVRP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 13:15:29 -0400
Received: from mout1.freenet.de ([194.97.50.132]:26066 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1751315AbWJVRP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 13:15:28 -0400
Date: Sun, 22 Oct 2006 19:17:47 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.19-rc2-mm2 sysfs: sysfs_write_file() writes zero terminated data
Reply-To: balagi@justmail.de
From: "Thomas Maier" <balagi@justmail.de>
Cc: akpm@osdl.org, gregkh@suse.de
Content-Type: multipart/mixed; boundary=----------NFxvzGQJ0V9KI8IVEZkTFr
Message-ID: <op.tht1yneaiudtyh@master>
User-Agent: Opera Mail/9.02 (Win32)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------NFxvzGQJ0V9KI8IVEZkTFr
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Hello,

since most of the files in sysfs are text files,
it would be nice, if the "store" function called
during sysfs_write_file() gets a zero terminated
string / data.
The current implementation seems not to ensure this.
(But only if it is the first time the zeroed buffer
page is allocated.)

So the buffer can be scanned by sscanf() easily,
for example.

This patch simply sets a \0 char behind the
data in buffer->page.

Signed-off-by: Thomas Maier <balagi@justmail.de>
------------NFxvzGQJ0V9KI8IVEZkTFr
Content-Disposition: attachment; filename=sysfs_write_file-zero-term-string.patch
Content-Type: application/octet-stream; name=sysfs_write_file-zero-term-string.patch
Content-Transfer-Encoding: Base64

ZGlmZiAtdXJwTiBsaW51eC0yLjYuMTktcmMyLW1tMi5zeXNmcy9mcy9zeXNmcy9m
aWxlLmMgMi1zeXNmc193cml0ZV9maWxlLXN0cmluZy9mcy9zeXNmcy9maWxlLmMK
LS0tIGxpbnV4LTIuNi4xOS1yYzItbW0yLnN5c2ZzL2ZzL3N5c2ZzL2ZpbGUuYwky
MDA2LTEwLTIyIDE4OjM4OjQ3LjAwMDAwMDAwMCArMDIwMAorKysgMi1zeXNmc193
cml0ZV9maWxlLXN0cmluZy9mcy9zeXNmcy9maWxlLmMJMjAwNi0xMC0yMiAxODo0
NTozOC4wMDAwMDAwMDAgKzAyMDAKQEAgLTE5NSw2ICsxOTUsOSBAQCBmaWxsX3dy
aXRlX2J1ZmZlcihzdHJ1Y3Qgc3lzZnNfYnVmZmVyICogCiAJCWNvdW50ID0gUEFH
RV9TSVpFIC0gMTsKIAllcnJvciA9IGNvcHlfZnJvbV91c2VyKGJ1ZmZlci0+cGFn
ZSxidWYsY291bnQpOwogCWJ1ZmZlci0+bmVlZHNfcmVhZF9maWxsID0gMTsKKwkv
KiBpZiBidWYgaXMgYXNzdW1lZCB0byBjb250YWluIGEgc3RyaW5nLCB0ZXJtaW5h
dGUgaXQgYnkgXDAsCisJICAgc28gZS5nLiBzc2NhbmYoKSBjYW4gc2NhbiB0aGUg
c3RyaW5nIGVhc2lseSAqLworCWJ1ZmZlci0+cGFnZVtjb3VudF0gPSAwOwogCXJl
dHVybiBlcnJvciA/IC1FRkFVTFQgOiBjb3VudDsKIH0KIAo=

------------NFxvzGQJ0V9KI8IVEZkTFr--

