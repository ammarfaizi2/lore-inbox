Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266691AbUBMGgF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 01:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266711AbUBMGgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 01:36:05 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:12500
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S266691AbUBMGgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 01:36:02 -0500
Message-ID: <402C7044.6050409@redhat.com>
Date: Thu, 12 Feb 2004 22:35:48 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: invalid fadvise parameter
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060603080009070601020005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060603080009070601020005
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The len parameter for fadvise has a signed type and negative values
passed must be rejected.  The attached patch does the job.

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFALHBE2ijCOnn/RHQRAlFAAJ99cQ5raRpz2OuSRSi3Xf4WdYuPvwCgycGi
0QZLMcHfqOcxjEzDl2tGDuA=
=igyM
-----END PGP SIGNATURE-----

--------------060603080009070601020005
Content-Type: text/plain;
 name="d-fadvise"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="d-fadvise"

LS0tIG1tL2ZhZHZpc2UuYwkyMDA0LTAxLTE5IDIwOjA5OjAzLjAwMDAwMDAwMCAtMDgwMAor
KysgbW0vZmFkdmlzZS5jLW5ldwkyMDA0LTAyLTEyIDIyOjMzOjMyLjAwMDAwMDAwMCAtMDgw
MApAQCAtMzMsNyArMzMsNyBAQAogCQlyZXR1cm4gLUVCQURGOwogCiAJbWFwcGluZyA9IGZp
bGUtPmZfbWFwcGluZzsKLQlpZiAoIW1hcHBpbmcpIHsKKwlpZiAoIW1hcHBpbmcgfHwgbGVu
IDwgMCkgewogCQlyZXQgPSAtRUlOVkFMOwogCQlnb3RvIG91dDsKIAl9Cg==
--------------060603080009070601020005--
