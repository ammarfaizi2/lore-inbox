Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262782AbVDAPfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbVDAPfE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 10:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbVDAPeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 10:34:23 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:5052 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262773AbVDAPd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 10:33:56 -0500
Date: Fri, 1 Apr 2005 17:33:47 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Artem B. Bityuckiy" <dedekind@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
       "Artem B. Bityuckiy" <dedekind@yandex.ru>,
       Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
Message-ID: <20050401153347.GA16835@wohnheim.fh-wedel.de>
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org> <1112366647.3899.66.camel@localhost.localdomain> <424D6175.8000700@yandex.ru> <1112367926.3899.70.camel@localhost.localdomain> <Pine.LNX.4.58.0504011622350.9305@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0504011622350.9305@phoenix.infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 April 2005 16:22:50 +0100, Artem B. Bityuckiy wrote:
> 
> Another question, does JFFSx *really* need the peaces of a 4K page to be 
> independently uncompressable? It it wouldn't be required, we would achieve 
> better compression if we have saved the zstream state. :-) But it is too 
> late to change things at least for JFFS2.

Absolutely.  You can argue that 4KiB is too small and 8|16|32|64|...
would be much better, yielding in better compression ratio.  But
having to read and uncompress the whole file when appending a few
bytes is utter madness.

Jörn

-- 
I don't understand it. Nobody does.
-- Richard P. Feynman
