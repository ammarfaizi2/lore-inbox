Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbTE0C40 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 22:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbTE0C40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 22:56:26 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:33035 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262636AbTE0C4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 22:56:22 -0400
Date: Tue, 27 May 2003 12:09:54 +0900 (JST)
Message-Id: <20030527.120954.117939073.yoshfuji@linux-ipv6.org>
To: us15@os.inf.tu-dresden.de, jmorris@intercode.com.au, davem@redhat.com
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: Linux 2.5.70 (Compiler warnings)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030527044519.0014a289.us15@os.inf.tu-dresden.de>
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
	<20030527044519.0014a289.us15@os.inf.tu-dresden.de>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030527044519.0014a289.us15@os.inf.tu-dresden.de> (at Tue, 27 May 2003 04:45:19 +0200), "Udo A. Steinberg" <us15@os.inf.tu-dresden.de> says:

> crypto/sha512.c:51: warning: integer constant is too large for "long" type
> crypto/sha512.c:51: warning: integer constant is too large for "long" type
:

Patch should be simple.

Index: linux25-LINUS/crypto/sha512.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/crypto/sha512.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 sha512.c
--- linux25-LINUS/crypto/sha512.c	17 Jan 2003 02:47:13 -0000	1.1.1.1
+++ linux25-LINUS/crypto/sha512.c	27 May 2003 02:59:35 -0000
@@ -48,33 +48,33 @@
 }
 
 const u64 sha512_K[80] = {
-        0x428a2f98d728ae22, 0x7137449123ef65cd, 0xb5c0fbcfec4d3b2f,
-        0xe9b5dba58189dbbc, 0x3956c25bf348b538, 0x59f111f1b605d019,
-        0x923f82a4af194f9b, 0xab1c5ed5da6d8118, 0xd807aa98a3030242,
-        0x12835b0145706fbe, 0x243185be4ee4b28c, 0x550c7dc3d5ffb4e2,
-        0x72be5d74f27b896f, 0x80deb1fe3b1696b1, 0x9bdc06a725c71235,
-        0xc19bf174cf692694, 0xe49b69c19ef14ad2, 0xefbe4786384f25e3,
-        0x0fc19dc68b8cd5b5, 0x240ca1cc77ac9c65, 0x2de92c6f592b0275,
-        0x4a7484aa6ea6e483, 0x5cb0a9dcbd41fbd4, 0x76f988da831153b5,
-        0x983e5152ee66dfab, 0xa831c66d2db43210, 0xb00327c898fb213f,
-        0xbf597fc7beef0ee4, 0xc6e00bf33da88fc2, 0xd5a79147930aa725,
-        0x06ca6351e003826f, 0x142929670a0e6e70, 0x27b70a8546d22ffc,
-        0x2e1b21385c26c926, 0x4d2c6dfc5ac42aed, 0x53380d139d95b3df,
-        0x650a73548baf63de, 0x766a0abb3c77b2a8, 0x81c2c92e47edaee6,
-        0x92722c851482353b, 0xa2bfe8a14cf10364, 0xa81a664bbc423001,
-        0xc24b8b70d0f89791, 0xc76c51a30654be30, 0xd192e819d6ef5218,
-        0xd69906245565a910, 0xf40e35855771202a, 0x106aa07032bbd1b8,
-        0x19a4c116b8d2d0c8, 0x1e376c085141ab53, 0x2748774cdf8eeb99,
-        0x34b0bcb5e19b48a8, 0x391c0cb3c5c95a63, 0x4ed8aa4ae3418acb,
-        0x5b9cca4f7763e373, 0x682e6ff3d6b2b8a3, 0x748f82ee5defb2fc,
-        0x78a5636f43172f60, 0x84c87814a1f0ab72, 0x8cc702081a6439ec,
-        0x90befffa23631e28, 0xa4506cebde82bde9, 0xbef9a3f7b2c67915,
-        0xc67178f2e372532b, 0xca273eceea26619c, 0xd186b8c721c0c207,
-        0xeada7dd6cde0eb1e, 0xf57d4f7fee6ed178, 0x06f067aa72176fba,
-        0x0a637dc5a2c898a6, 0x113f9804bef90dae, 0x1b710b35131c471b,
-        0x28db77f523047d84, 0x32caab7b40c72493, 0x3c9ebe0a15c9bebc,
-        0x431d67c49c100d4c, 0x4cc5d4becb3e42b6, 0x597f299cfc657e2a,
-        0x5fcb6fab3ad6faec, 0x6c44198c4a475817,
+        0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL, 0xb5c0fbcfec4d3b2fULL,
+        0xe9b5dba58189dbbcULL, 0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
+        0x923f82a4af194f9bULL, 0xab1c5ed5da6d8118ULL, 0xd807aa98a3030242ULL,
+        0x12835b0145706fbeULL, 0x243185be4ee4b28cULL, 0x550c7dc3d5ffb4e2ULL,
+        0x72be5d74f27b896fULL, 0x80deb1fe3b1696b1ULL, 0x9bdc06a725c71235ULL,
+        0xc19bf174cf692694ULL, 0xe49b69c19ef14ad2ULL, 0xefbe4786384f25e3ULL,
+        0x0fc19dc68b8cd5b5ULL, 0x240ca1cc77ac9c65ULL, 0x2de92c6f592b0275ULL,
+        0x4a7484aa6ea6e483ULL, 0x5cb0a9dcbd41fbd4ULL, 0x76f988da831153b5ULL,
+        0x983e5152ee66dfabULL, 0xa831c66d2db43210ULL, 0xb00327c898fb213fULL,
+        0xbf597fc7beef0ee4ULL, 0xc6e00bf33da88fc2ULL, 0xd5a79147930aa725ULL,
+        0x06ca6351e003826fULL, 0x142929670a0e6e70ULL, 0x27b70a8546d22ffcULL,
+        0x2e1b21385c26c926ULL, 0x4d2c6dfc5ac42aedULL, 0x53380d139d95b3dfULL,
+        0x650a73548baf63deULL, 0x766a0abb3c77b2a8ULL, 0x81c2c92e47edaee6ULL,
+        0x92722c851482353bULL, 0xa2bfe8a14cf10364ULL, 0xa81a664bbc423001ULL,
+        0xc24b8b70d0f89791ULL, 0xc76c51a30654be30ULL, 0xd192e819d6ef5218ULL,
+        0xd69906245565a910ULL, 0xf40e35855771202aULL, 0x106aa07032bbd1b8ULL,
+        0x19a4c116b8d2d0c8ULL, 0x1e376c085141ab53ULL, 0x2748774cdf8eeb99ULL,
+        0x34b0bcb5e19b48a8ULL, 0x391c0cb3c5c95a63ULL, 0x4ed8aa4ae3418acbULL,
+        0x5b9cca4f7763e373ULL, 0x682e6ff3d6b2b8a3ULL, 0x748f82ee5defb2fcULL,
+        0x78a5636f43172f60ULL, 0x84c87814a1f0ab72ULL, 0x8cc702081a6439ecULL,
+        0x90befffa23631e28ULL, 0xa4506cebde82bde9ULL, 0xbef9a3f7b2c67915ULL,
+        0xc67178f2e372532bULL, 0xca273eceea26619cULL, 0xd186b8c721c0c207ULL,
+        0xeada7dd6cde0eb1eULL, 0xf57d4f7fee6ed178ULL, 0x06f067aa72176fbaULL,
+        0x0a637dc5a2c898a6ULL, 0x113f9804bef90daeULL, 0x1b710b35131c471bULL,
+        0x28db77f523047d84ULL, 0x32caab7b40c72493ULL, 0x3c9ebe0a15c9bebcULL,
+        0x431d67c49c100d4cULL, 0x4cc5d4becb3e42b6ULL, 0x597f299cfc657e2aULL,
+        0x5fcb6fab3ad6faecULL, 0x6c44198c4a475817ULL,
 };
 
 #define e0(x)       (RORu64(x,28) ^ RORu64(x,34) ^ RORu64(x,39))
@@ -83,24 +83,24 @@
 #define s1(x)       (RORu64(x,19) ^ RORu64(x,61) ^ (x >> 6))
 
 /* H* initial state for SHA-512 */
-#define H0         0x6a09e667f3bcc908
-#define H1         0xbb67ae8584caa73b
-#define H2         0x3c6ef372fe94f82b
-#define H3         0xa54ff53a5f1d36f1
-#define H4         0x510e527fade682d1
-#define H5         0x9b05688c2b3e6c1f
-#define H6         0x1f83d9abfb41bd6b
-#define H7         0x5be0cd19137e2179
+#define H0         0x6a09e667f3bcc908ULL
+#define H1         0xbb67ae8584caa73bULL
+#define H2         0x3c6ef372fe94f82bULL
+#define H3         0xa54ff53a5f1d36f1ULL
+#define H4         0x510e527fade682d1ULL
+#define H5         0x9b05688c2b3e6c1fULL
+#define H6         0x1f83d9abfb41bd6bULL
+#define H7         0x5be0cd19137e2179ULL
 
 /* H'* initial state for SHA-384 */
-#define HP0 0xcbbb9d5dc1059ed8
-#define HP1 0x629a292a367cd507
-#define HP2 0x9159015a3070dd17
-#define HP3 0x152fecd8f70e5939
-#define HP4 0x67332667ffc00b31
-#define HP5 0x8eb44a8768581511
-#define HP6 0xdb0c2e0d64f98fa7
-#define HP7 0x47b5481dbefa4fa4
+#define HP0 0xcbbb9d5dc1059ed8ULL
+#define HP1 0x629a292a367cd507ULL
+#define HP2 0x9159015a3070dd17ULL
+#define HP3 0x152fecd8f70e5939ULL
+#define HP4 0x67332667ffc00b31ULL
+#define HP5 0x8eb44a8768581511ULL
+#define HP6 0xdb0c2e0d64f98fa7ULL
+#define HP7 0x47b5481dbefa4fa4ULL
 
 static inline void LOAD_OP(int I, u64 *W, const u8 *input)
 {

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
