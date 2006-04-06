Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWDFChv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWDFChv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 22:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWDFChv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 22:37:51 -0400
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:30141 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1751340AbWDFChu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 22:37:50 -0400
Date: Thu, 06 Apr 2006 11:37:42 +0900 (JST)
Message-Id: <20060406.113742.15248428.nemoto@toshiba-tops.co.jp>
To: herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] crypto: add alignment handling to digest layer
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060405180520.GA15151@gondor.apana.org.au>
References: <20060309.123608.08076793.nemoto@toshiba-tops.co.jp>
	<20060404.000407.41198995.anemo@mba.ocn.ne.jp>
	<20060405180520.GA15151@gondor.apana.org.au>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2006 04:05:20 +1000, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> Don't we need to copy this to an aligned buffer?

We don't.  I think update functions do not need an aligned buffer for
data which is smaller then the alignment size.

---
Atsushi Nemoto
