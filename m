Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVDSGbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVDSGbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 02:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVDSGbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 02:31:13 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:39685 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261345AbVDSGaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 02:30:11 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sha512: fix whitespace
Date: Tue, 19 Apr 2005 09:28:40 +0300
User-Agent: KMail/1.5.4
Cc: Matt Mackall <mpm@selenic.com>
References: <200504190918.10279.vda@port.imtp.ilyichevsk.odessa.ua> <200504190921.34294.vda@port.imtp.ilyichevsk.odessa.ua> <200504190926.53565.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200504190926.53565.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YUKZCr33s1WTfT1"
Message-Id: <200504190928.40353.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_YUKZCr33s1WTfT1
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

While we're at it, fix inconsistent tab/space usage.

No code changes.
--
vda

--Boundary-00=_YUKZCr33s1WTfT1
Content-Type: text/x-diff;
  charset="koi8-r";
  name="3.ws.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="3.ws.patch"

diff -urpN 2.6.12-rc2.2.ror/crypto/sha512.c 2.6.12-rc2.3.ws/crypto/sha512.c
--- 2.6.12-rc2.2.ror/crypto/sha512.c	Mon Apr 18 23:37:20 2005
+++ 2.6.12-rc2.3.ws/crypto/sha512.c	Mon Apr 18 23:48:18 2005
@@ -35,42 +35,42 @@ struct sha512_ctx {
 
 static inline u64 Ch(u64 x, u64 y, u64 z)
 {
-        return z ^ (x & (y ^ z));
+	return z ^ (x & (y ^ z));
 }
 
 static inline u64 Maj(u64 x, u64 y, u64 z)
 {
-        return (x & y) | (z & (x | y));
+	return (x & y) | (z & (x | y));
 }
 
 static const u64 sha512_K[80] = {
-        0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL, 0xb5c0fbcfec4d3b2fULL,
-        0xe9b5dba58189dbbcULL, 0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
-        0x923f82a4af194f9bULL, 0xab1c5ed5da6d8118ULL, 0xd807aa98a3030242ULL,
-        0x12835b0145706fbeULL, 0x243185be4ee4b28cULL, 0x550c7dc3d5ffb4e2ULL,
-        0x72be5d74f27b896fULL, 0x80deb1fe3b1696b1ULL, 0x9bdc06a725c71235ULL,
-        0xc19bf174cf692694ULL, 0xe49b69c19ef14ad2ULL, 0xefbe4786384f25e3ULL,
-        0x0fc19dc68b8cd5b5ULL, 0x240ca1cc77ac9c65ULL, 0x2de92c6f592b0275ULL,
-        0x4a7484aa6ea6e483ULL, 0x5cb0a9dcbd41fbd4ULL, 0x76f988da831153b5ULL,
-        0x983e5152ee66dfabULL, 0xa831c66d2db43210ULL, 0xb00327c898fb213fULL,
-        0xbf597fc7beef0ee4ULL, 0xc6e00bf33da88fc2ULL, 0xd5a79147930aa725ULL,
-        0x06ca6351e003826fULL, 0x142929670a0e6e70ULL, 0x27b70a8546d22ffcULL,
-        0x2e1b21385c26c926ULL, 0x4d2c6dfc5ac42aedULL, 0x53380d139d95b3dfULL,
-        0x650a73548baf63deULL, 0x766a0abb3c77b2a8ULL, 0x81c2c92e47edaee6ULL,
-        0x92722c851482353bULL, 0xa2bfe8a14cf10364ULL, 0xa81a664bbc423001ULL,
-        0xc24b8b70d0f89791ULL, 0xc76c51a30654be30ULL, 0xd192e819d6ef5218ULL,
-        0xd69906245565a910ULL, 0xf40e35855771202aULL, 0x106aa07032bbd1b8ULL,
-        0x19a4c116b8d2d0c8ULL, 0x1e376c085141ab53ULL, 0x2748774cdf8eeb99ULL,
-        0x34b0bcb5e19b48a8ULL, 0x391c0cb3c5c95a63ULL, 0x4ed8aa4ae3418acbULL,
-        0x5b9cca4f7763e373ULL, 0x682e6ff3d6b2b8a3ULL, 0x748f82ee5defb2fcULL,
-        0x78a5636f43172f60ULL, 0x84c87814a1f0ab72ULL, 0x8cc702081a6439ecULL,
-        0x90befffa23631e28ULL, 0xa4506cebde82bde9ULL, 0xbef9a3f7b2c67915ULL,
-        0xc67178f2e372532bULL, 0xca273eceea26619cULL, 0xd186b8c721c0c207ULL,
-        0xeada7dd6cde0eb1eULL, 0xf57d4f7fee6ed178ULL, 0x06f067aa72176fbaULL,
-        0x0a637dc5a2c898a6ULL, 0x113f9804bef90daeULL, 0x1b710b35131c471bULL,
-        0x28db77f523047d84ULL, 0x32caab7b40c72493ULL, 0x3c9ebe0a15c9bebcULL,
-        0x431d67c49c100d4cULL, 0x4cc5d4becb3e42b6ULL, 0x597f299cfc657e2aULL,
-        0x5fcb6fab3ad6faecULL, 0x6c44198c4a475817ULL,
+	0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL, 0xb5c0fbcfec4d3b2fULL,
+	0xe9b5dba58189dbbcULL, 0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
+	0x923f82a4af194f9bULL, 0xab1c5ed5da6d8118ULL, 0xd807aa98a3030242ULL,
+	0x12835b0145706fbeULL, 0x243185be4ee4b28cULL, 0x550c7dc3d5ffb4e2ULL,
+	0x72be5d74f27b896fULL, 0x80deb1fe3b1696b1ULL, 0x9bdc06a725c71235ULL,
+	0xc19bf174cf692694ULL, 0xe49b69c19ef14ad2ULL, 0xefbe4786384f25e3ULL,
+	0x0fc19dc68b8cd5b5ULL, 0x240ca1cc77ac9c65ULL, 0x2de92c6f592b0275ULL,
+	0x4a7484aa6ea6e483ULL, 0x5cb0a9dcbd41fbd4ULL, 0x76f988da831153b5ULL,
+	0x983e5152ee66dfabULL, 0xa831c66d2db43210ULL, 0xb00327c898fb213fULL,
+	0xbf597fc7beef0ee4ULL, 0xc6e00bf33da88fc2ULL, 0xd5a79147930aa725ULL,
+	0x06ca6351e003826fULL, 0x142929670a0e6e70ULL, 0x27b70a8546d22ffcULL,
+	0x2e1b21385c26c926ULL, 0x4d2c6dfc5ac42aedULL, 0x53380d139d95b3dfULL,
+	0x650a73548baf63deULL, 0x766a0abb3c77b2a8ULL, 0x81c2c92e47edaee6ULL,
+	0x92722c851482353bULL, 0xa2bfe8a14cf10364ULL, 0xa81a664bbc423001ULL,
+	0xc24b8b70d0f89791ULL, 0xc76c51a30654be30ULL, 0xd192e819d6ef5218ULL,
+	0xd69906245565a910ULL, 0xf40e35855771202aULL, 0x106aa07032bbd1b8ULL,
+	0x19a4c116b8d2d0c8ULL, 0x1e376c085141ab53ULL, 0x2748774cdf8eeb99ULL,
+	0x34b0bcb5e19b48a8ULL, 0x391c0cb3c5c95a63ULL, 0x4ed8aa4ae3418acbULL,
+	0x5b9cca4f7763e373ULL, 0x682e6ff3d6b2b8a3ULL, 0x748f82ee5defb2fcULL,
+	0x78a5636f43172f60ULL, 0x84c87814a1f0ab72ULL, 0x8cc702081a6439ecULL,
+	0x90befffa23631e28ULL, 0xa4506cebde82bde9ULL, 0xbef9a3f7b2c67915ULL,
+	0xc67178f2e372532bULL, 0xca273eceea26619cULL, 0xd186b8c721c0c207ULL,
+	0xeada7dd6cde0eb1eULL, 0xf57d4f7fee6ed178ULL, 0x06f067aa72176fbaULL,
+	0x0a637dc5a2c898a6ULL, 0x113f9804bef90daeULL, 0x1b710b35131c471bULL,
+	0x28db77f523047d84ULL, 0x32caab7b40c72493ULL, 0x3c9ebe0a15c9bebcULL,
+	0x431d67c49c100d4cULL, 0x4cc5d4becb3e42b6ULL, 0x597f299cfc657e2aULL,
+	0x5fcb6fab3ad6faecULL, 0x6c44198c4a475817ULL,
 };
 
 #define e0(x)       (ror64(x,28) ^ ror64(x,34) ^ ror64(x,39))
@@ -116,16 +116,16 @@ sha512_transform(u64 *state, u64 *W, con
 	int i;
 
 	/* load the input */
-        for (i = 0; i < 16; i++)
-                LOAD_OP(i, W, input);
+	for (i = 0; i < 16; i++)
+		LOAD_OP(i, W, input);
 
-        for (i = 16; i < 80; i++)
-                BLEND_OP(i, W);
+	for (i = 16; i < 80; i++)
+		BLEND_OP(i, W);
 
 	/* load the state into our registers */
-	a=state[0];   b=state[1];   c=state[2];   d=state[3];  
-	e=state[4];   f=state[5];   g=state[6];   h=state[7];  
-  
+	a=state[0]; b=state[1]; c=state[2]; d=state[3];
+	e=state[4]; f=state[5]; g=state[6]; h=state[7];
+
 	/* now iterate */
 	for (i=0; i<80; i+=8) {
 		t1 = h + e1(e) + Ch(e,f,g) + sha512_K[i  ] + W[i  ];
@@ -145,9 +145,9 @@ sha512_transform(u64 *state, u64 *W, con
 		t1 = a + e1(f) + Ch(f,g,h) + sha512_K[i+7] + W[i+7];
 		t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
 	}
-  
-	state[0] += a; state[1] += b; state[2] += c; state[3] += d;  
-	state[4] += e; state[5] += f; state[6] += g; state[7] += h;  
+
+	state[0] += a; state[1] += b; state[2] += c; state[3] += d;
+	state[4] += e; state[5] += f; state[6] += g; state[7] += h;
 
 	/* erase our data */
 	a = b = c = d = e = f = g = h = t1 = t2 = 0;
@@ -156,7 +156,7 @@ sha512_transform(u64 *state, u64 *W, con
 static void
 sha512_init(void *ctx)
 {
-        struct sha512_ctx *sctx = ctx;
+	struct sha512_ctx *sctx = ctx;
 	sctx->state[0] = H0;
 	sctx->state[1] = H1;
 	sctx->state[2] = H2;
@@ -172,29 +172,29 @@ sha512_init(void *ctx)
 static void
 sha384_init(void *ctx)
 {
-        struct sha512_ctx *sctx = ctx;
-        sctx->state[0] = HP0;
-        sctx->state[1] = HP1;
-        sctx->state[2] = HP2;
-        sctx->state[3] = HP3;
-        sctx->state[4] = HP4;
-        sctx->state[5] = HP5;
-        sctx->state[6] = HP6;
-        sctx->state[7] = HP7;
-        sctx->count[0] = sctx->count[1] = sctx->count[2] = sctx->count[3] = 0;
-        memset(sctx->buf, 0, sizeof(sctx->buf));
+	struct sha512_ctx *sctx = ctx;
+	sctx->state[0] = HP0;
+	sctx->state[1] = HP1;
+	sctx->state[2] = HP2;
+	sctx->state[3] = HP3;
+	sctx->state[4] = HP4;
+	sctx->state[5] = HP5;
+	sctx->state[6] = HP6;
+	sctx->state[7] = HP7;
+	sctx->count[0] = sctx->count[1] = sctx->count[2] = sctx->count[3] = 0;
+	memset(sctx->buf, 0, sizeof(sctx->buf));
 }
 
 static void
 sha512_update(void *ctx, const u8 *data, unsigned int len)
 {
-        struct sha512_ctx *sctx = ctx;
+	struct sha512_ctx *sctx = ctx;
 
 	unsigned int i, index, part_len;
 
 	/* Compute number of bytes mod 128 */
 	index = (unsigned int)((sctx->count[0] >> 3) & 0x7F);
-	
+
 	/* Update number of bits */
 	if ((sctx->count[0] += (len << 3)) < (len << 3)) {
 		if ((sctx->count[1] += 1) < 1)
@@ -202,9 +202,9 @@ sha512_update(void *ctx, const u8 *data,
 				sctx->count[3]++;
 		sctx->count[1] += (len >> 29);
 	}
-	
-        part_len = 128 - index;
-	
+
+	part_len = 128 - index;
+
 	/* Transform as many times as possible. */
 	if (len >= part_len) {
 		memcpy(&sctx->buf[index], data, part_len);
@@ -228,11 +228,11 @@ sha512_update(void *ctx, const u8 *data,
 static void
 sha512_final(void *ctx, u8 *hash)
 {
-        struct sha512_ctx *sctx = ctx;
-	
-        static u8 padding[128] = { 0x80, };
+	struct sha512_ctx *sctx = ctx;
+
+	static u8 padding[128] = { 0x80, };
 
-        u8 bits[128];
+	u8 bits[128];
 	unsigned int index, pad_len;
 	int i;
 
@@ -255,70 +255,70 @@ sha512_final(void *ctx, u8 *hash)
 	/* Store state in digest */
 	for (i = 0; i < 8; i++)
 		((__be64*)hash)[i] = __cpu_to_be64(sctx->state[i]);
-	
+
 	/* Zeroize sensitive information. */
 	memset(sctx, 0, sizeof(struct sha512_ctx));
 }
 
 static void sha384_final(void *ctx, u8 *hash)
 {
-        struct sha512_ctx *sctx = ctx;
-        u8 D[64];
+	struct sha512_ctx *sctx = ctx;
+	u8 D[64];
 
-        sha512_final(sctx, D);
+	sha512_final(sctx, D);
 
-        memcpy(hash, D, 48);
-        memset(D, 0, 64);
+	memcpy(hash, D, 48);
+	memset(D, 0, 64);
 }
 
 static struct crypto_alg sha512 = {
-        .cra_name       = "sha512",
-        .cra_flags      = CRYPTO_ALG_TYPE_DIGEST,
-        .cra_blocksize  = SHA512_HMAC_BLOCK_SIZE,
-        .cra_ctxsize    = sizeof(struct sha512_ctx),
-        .cra_module     = THIS_MODULE,
-        .cra_list       = LIST_HEAD_INIT(sha512.cra_list),
-        .cra_u          = { .digest = {
-                                .dia_digestsize = SHA512_DIGEST_SIZE,
-                                .dia_init       = sha512_init,
-                                .dia_update     = sha512_update,
-                                .dia_final      = sha512_final }
-        }
+	.cra_name	= "sha512",
+	.cra_flags	= CRYPTO_ALG_TYPE_DIGEST,
+	.cra_blocksize	= SHA512_HMAC_BLOCK_SIZE,
+	.cra_ctxsize	= sizeof(struct sha512_ctx),
+	.cra_module	= THIS_MODULE,
+	.cra_list	= LIST_HEAD_INIT(sha512.cra_list),
+	.cra_u		= { .digest = {
+				.dia_digestsize	= SHA512_DIGEST_SIZE,
+				.dia_init	= sha512_init,
+				.dia_update	= sha512_update,
+				.dia_final	= sha512_final }
+	}
 };
 
 static struct crypto_alg sha384 = {
-        .cra_name       = "sha384",
-        .cra_flags      = CRYPTO_ALG_TYPE_DIGEST,
-        .cra_blocksize  = SHA384_HMAC_BLOCK_SIZE,
-        .cra_ctxsize    = sizeof(struct sha512_ctx),
-        .cra_module     = THIS_MODULE,
-        .cra_list       = LIST_HEAD_INIT(sha384.cra_list),
-        .cra_u          = { .digest = {
-                                .dia_digestsize = SHA384_DIGEST_SIZE,
-                                .dia_init       = sha384_init,
-                                .dia_update     = sha512_update,
-                                .dia_final      = sha384_final }
-        }
+	.cra_name	= "sha384",
+	.cra_flags	= CRYPTO_ALG_TYPE_DIGEST,
+	.cra_blocksize	= SHA384_HMAC_BLOCK_SIZE,
+	.cra_ctxsize	= sizeof(struct sha512_ctx),
+	.cra_module	= THIS_MODULE,
+	.cra_list	= LIST_HEAD_INIT(sha384.cra_list),
+	.cra_u		= { .digest = {
+				.dia_digestsize	= SHA384_DIGEST_SIZE,
+				.dia_init	= sha384_init,
+				.dia_update	= sha512_update,
+				.dia_final	= sha384_final }
+	}
 };
 
 MODULE_ALIAS("sha384");
 
 static int __init init(void)
 {
-        int ret = 0;
+	int ret = 0;
 
-        if ((ret = crypto_register_alg(&sha384)) < 0)
-                goto out;
-        if ((ret = crypto_register_alg(&sha512)) < 0)
-                crypto_unregister_alg(&sha384);
+	if ((ret = crypto_register_alg(&sha384)) < 0)
+		goto out;
+	if ((ret = crypto_register_alg(&sha512)) < 0)
+		crypto_unregister_alg(&sha384);
 out:
-        return ret;
+	return ret;
 }
 
 static void __exit fini(void)
 {
-        crypto_unregister_alg(&sha384);
-        crypto_unregister_alg(&sha512);
+	crypto_unregister_alg(&sha384);
+	crypto_unregister_alg(&sha512);
 }
 
 module_init(init);

--Boundary-00=_YUKZCr33s1WTfT1--

