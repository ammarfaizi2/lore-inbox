Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262907AbVCWUXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbVCWUXP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 15:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbVCWUUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 15:20:05 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:46803
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262892AbVCWUSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:18:30 -0500
Date: Wed, 23 Mar 2005 12:17:48 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: clemens@endorphin.org, jmorris@redhat.com, linux-kernel@vger.kernel.org,
       cryptoapi@lists.logix.cz, linux-crypto@vger.kernel.org
Subject: Re: [9/*] [CRYPTO] Remap when walk_out crosses page in crypt()
Message-Id: <20050323121748.70de8a7f.davem@davemloft.net>
In-Reply-To: <20050322112504.GC7224@gondor.apana.org.au>
References: <20050321094047.GA23084@gondor.apana.org.au>
	<20050322112231.GA7224@gondor.apana.org.au>
	<20050322112416.GB7224@gondor.apana.org.au>
	<20050322112504.GC7224@gondor.apana.org.au>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 22:25:04 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Hi:
> 
> This is needed so that we can keep the in_place assignment outside the
> inner loop.  Without this in pathalogical situations we can start out
> having walk_out being different from walk_in, but when walk_out crosses
> a page it may converge with walk_in.

All 9 patches applied, thanks Herbert.

Patches 7 through 9 were generated differently from the others,
look at the directory prefixes (or rather, a lack thereof):

===== cipher.c 1.26 vs edited =====
--- 1.26/crypto/cipher.c	2005-03-22 21:56:21 +11:00
+++ edited/cipher.c	2005-03-22 21:59:53 +11:00

I had to hand edit these before sending them through my patch
application scripts which expect -p1 diffs ;-)
