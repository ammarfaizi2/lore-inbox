Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266717AbTAKAOb>; Fri, 10 Jan 2003 19:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266763AbTAKAO1>; Fri, 10 Jan 2003 19:14:27 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:46085 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S266717AbTAKAMn>; Fri, 10 Jan 2003 19:12:43 -0500
Date: Sat, 11 Jan 2003 11:21:10 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: latten@austin.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: IPSec
In-Reply-To: <200301102245.h0AMjgQ39564@faith.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0301111111330.26890-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003 latten@austin.ibm.com wrote:

> I am configuring IPSec and was wondering are there
> any plans to add AES to the crypto algorithms IPSec uses?

AES CBC is supported with 2.5.56 (specify 'rijndael-cbc' for setkey).
AES counter mode is not yet supported.

Also, for those wanting to use Blowfish, you'll need the patch below 
against iputils-ss021109-try.


- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -urN -X dontdif iputils/include-glibc/net/pfkeyv2.h iputils.w1/include-glibc/net/pfkeyv2.h
--- iputils/include-glibc/net/pfkeyv2.h	Sat Nov  9 13:45:52 2002
+++ iputils.w1/include-glibc/net/pfkeyv2.h	Sat Jan 11 11:19:45 2003
@@ -17,7 +17,7 @@
 
 /* private allocations - based on RFC2407/IANA assignment */
 #define SADB_X_EALG_CAST128CBC	5	/*6*/
-#define SADB_X_EALG_BLOWFISHCBC	4	/*7*/
+#define SADB_X_EALG_BLOWFISHCBC	7
 #define SADB_X_EALG_RIJNDAELCBC	12
 #define SADB_X_EALG_AES		12
 

