Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262941AbUDUOIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbUDUOIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 10:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbUDUOIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 10:08:36 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:32156
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262931AbUDUOIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 10:08:34 -0400
Message-ID: <4086803A.5000308@redhat.com>
Date: Wed, 21 Apr 2004 07:07:54 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a) Gecko/20040420
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
CC: Arjan van de Ven <arjanv@redhat.com>
Subject: [PATCH} Add missing __initdata
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080400090902050209060005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080400090902050209060005
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

One of the stack size optimizations introduced a new static variable in
a function marked with __init.  The problem is the variable is not
marked appropriately and so 1k of data is not freed.  The attached patch
fixes the problem.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖

--------------080400090902050209060005
Content-Type: text/plain;
 name="d-nfsroot"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="d-nfsroot"

LS0tIGZzL25mcy9uZnNyb290LmMtb2xkCTIwMDQtMDQtMTkgMTQ6MTE6MTcuMDAwMDAwMDAw
IC0wNzAwCisrKyBmcy9uZnMvbmZzcm9vdC5jCTIwMDQtMDQtMjEgMDY6NDg6MjMuMDAwMDAw
MDAwIC0wNzAwCkBAIC0yNzMsNyArMjczLDcgQEAgc3RhdGljIGludCBfX2luaXQgcm9vdF9u
ZnNfcGFyc2UoY2hhciAqbgogICovCiBzdGF0aWMgaW50IF9faW5pdCByb290X25mc19uYW1l
KGNoYXIgKm5hbWUpCiB7Ci0Jc3RhdGljIGNoYXIgYnVmW05GU19NQVhQQVRITEVOXTsKKwlz
dGF0aWMgY2hhciBidWZbTkZTX01BWFBBVEhMRU5dIF9faW5pdGRhdGE7CiAJY2hhciAqY3A7
CiAKIAkvKiBTZXQgc29tZSBkZWZhdWx0IHZhbHVlcyAqLwo=
--------------080400090902050209060005--
