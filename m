Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbUCTKON (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 05:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbUCTKON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 05:14:13 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:58771
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263310AbUCTKOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 05:14:08 -0500
Message-ID: <405C195B.10004@redhat.com>
Date: Sat, 20 Mar 2004 02:13:47 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] error value for opening block devices
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030003010301040404040407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030003010301040404040407
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Opening a non-existing block device currently yields an ENXIO error.
Doing the same for char devices produces the correct error ENODEV.

The attached patch fixes the symptoms.  Somebody with more knowledge
will have to decide whether there are any negative side effects.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖

--------------030003010301040404040407
Content-Type: text/plain;
 name="d-blk-enodev"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="d-blk-enodev"

LS0tIGZzL2Jsb2NrX2Rldi5jLXNhdmUJMjAwNC0wMy0xMiAxMTo0NDoxNC4wMDAwMDAwMDAg
LTA4MDAKKysrIGZzL2Jsb2NrX2Rldi5jCTIwMDQtMDMtMjAgMDE6NTM6MTkuMDAwMDAwMDAw
IC0wODAwCkBAIC01NTAsNyArNTUwLDcgQEAgc3RhdGljIGludCBkb19vcGVuKHN0cnVjdCBi
bG9ja19kZXZpY2UgKgogewogCXN0cnVjdCBtb2R1bGUgKm93bmVyID0gTlVMTDsKIAlzdHJ1
Y3QgZ2VuZGlzayAqZGlzazsKLQlpbnQgcmV0ID0gLUVOWElPOworCWludCByZXQgPSAtRU5P
REVWOwogCWludCBwYXJ0OwogCiAJZmlsZS0+Zl9tYXBwaW5nID0gYmRldi0+YmRfaW5vZGUt
PmlfbWFwcGluZzsKQEAgLTU2Myw2ICs1NjMsNyBAQCBzdGF0aWMgaW50IGRvX29wZW4oc3Ry
dWN0IGJsb2NrX2RldmljZSAqCiAJfQogCW93bmVyID0gZGlzay0+Zm9wcy0+b3duZXI7CiAK
KwlyZXQgPSAtRU5YSU87CiAJZG93bigmYmRldi0+YmRfc2VtKTsKIAlpZiAoIWJkZXYtPmJk
X29wZW5lcnMpIHsKIAkJYmRldi0+YmRfZGlzayA9IGRpc2s7Cg==
--------------030003010301040404040407--
