Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267300AbTAGFKQ>; Tue, 7 Jan 2003 00:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267301AbTAGFKQ>; Tue, 7 Jan 2003 00:10:16 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:23267 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267300AbTAGFKP>; Tue, 7 Jan 2003 00:10:15 -0500
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Define hash_mem in lib/hash.c to apply hash_long to an arbitraty piece of memory.
References: <15898.24480.346258.361959@notabene.cse.unsw.edu.au>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 07 Jan 2003 06:18:42 +0100
In-Reply-To: <15898.24480.346258.361959@notabene.cse.unsw.edu.au>
Message-ID: <87znqd8rm5.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (broccoli)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> writes:

> +unsigned long hash_mem(void *buf, unsigned int len, unsigned int bits)
> +{
> +	int hash = 0;

Shouldn't that be unsigned long?

BTW, in my experience using a good hash function is usually more
important than using a fast hash function. Especially the use of '^'
here could lead to very bad performance in obscure cases because of
bit canceling.

-- 
	Falk
