Return-Path: <linux-kernel-owner+w=401wt.eu-S1030311AbXAED2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbXAED2k (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 22:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbXAED2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 22:28:40 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:46714 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030311AbXAED2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 22:28:39 -0500
From: Mike Frysinger <vapier@gentoo.org>
Organization: wh0rd.org
To: Christoph Hellwig <hch@infradead.org>, "Andrew Morton" <akpm@osdl.org>
Subject: [patch] dont export asm/page.h to userspace
Date: Thu, 4 Jan 2007 22:28:30 -0500
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fXcnFA9uItc7Etf"
Message-Id: <200701042228.31456.vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_fXcnFA9uItc7Etf
Content-Type: multipart/signed;
  boundary="nextPart4972951.mKCAEE2y9X";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4972951.mKCAEE2y9X
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 1/4/07, Christoph Hellwig <hch@infradead.org> wrote:
> It should not be exported to userspace at all.  Care to submit a patch?

trivial patch attached
-mike

--nextPart4972951.mKCAEE2y9X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iQIVAwUARZ3F30FjO5/oN/WBAQLnvw/9HFZrCCTvif/fWazG0U2+ao9bYTPqBPRN
v1i0KYKubOitVK898/ccZtEWrkc7OU8fV5VXKEAfvBDtVdPkecwdAgwa9pAMShbJ
8ce3FhP1broANmbHueHKsQVlxoBLfbVo0wtKPzZiMzg5JtTwDPuLMDDqrBnLIuqp
WYfKqM8wiJd7PNO2oIBWarXmTJWrf8047Opv9tv2UvPKCaDS8nchtxSCSEPJFDVo
iIZfAvYxhBzmDTF5rwOWz4WAw6McQWt6yEdahP3mhXMCUEqg7s3Flvk8+PG/dGD3
SBf9jQuP9TtSKGnKubgI9BWBZEBzarkNyop/NwqLlCLLtBhsgHYaYZCmN7lzN4+7
JiQCUjMvj9qBVnZDRKX3QKXLLsdjAho6yTVhABxoj+7ayh2oaI5R6sHbhJbuCVMB
z7S9E6+cmrYNdbMCYNRBybC0rSPRmRmtc7BXPlR0WbfJCr+4yBTHT4sRv+3N7Tbk
weL4FmST6FLtciGk92n4xHxo71EX3/coVEsohzzXIE6YfY/nmGI4q12P+rkFX1xh
KH/y01wHmNIVG6ePCAXCYXK2CJ+hxPf3Xv6iXTQLdoycjQqpw9PpN54YzZ2OqDTq
CbPjBmmR6s8MmuERKsl2FOoLSP7KYnY4yg40fdBitRCdcGWSoJJbKSmEbjxeAAHV
EGUmn7rZLMI=
=yblK
-----END PGP SIGNATURE-----

--nextPart4972951.mKCAEE2y9X--

--Boundary-00=_fXcnFA9uItc7Etf
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-dont-export-asm-page.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="linux-dont-export-asm-page.patch"

diff --git a/include/asm-generic/Kbuild.asm b/include/asm-generic/Kbuild.asm
index a37e95f..642d277 100644
--- a/include/asm-generic/Kbuild.asm
+++ b/include/asm-generic/Kbuild.asm
@@ -32,4 +32,3 @@ unifdef-y += user.h
 # These probably shouldn't be exported
 unifdef-y += shmparam.h
 unifdef-y += elf.h
-unifdef-y += page.h

--Boundary-00=_fXcnFA9uItc7Etf--
