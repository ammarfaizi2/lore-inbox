Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbVDAPFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbVDAPFu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 10:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVDAPFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 10:05:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46483 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262757AbVDAPFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 10:05:45 -0500
Subject: Re: [RFC] CryptoAPI & Compression
From: David Woodhouse <dwmw2@infradead.org>
To: "Artem B. Bityuckiy" <dedekind@yandex.ru>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
In-Reply-To: <424D6175.8000700@yandex.ru>
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au>
	 <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org>
	 <1112366647.3899.66.camel@localhost.localdomain>
	 <424D6175.8000700@yandex.ru>
Content-Type: text/plain
Date: Fri, 01 Apr 2005 16:05:25 +0100
Message-Id: <1112367926.3899.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-01 at 18:57 +0400, Artem B. Bityuckiy wrote:
> Yes, the compression will be better. But the implementation will be more 
> complicated.
> We can try to use the "bound" functions to predict how many bytes to 
> pass to the deflate's input, but there is no guarantee they'll fit into 
> the output buffer. In this case we'll need to try again.

Can we not predict the maximum number of bytes it'll take to flush the
stream when we're not using Z_SYNC_FLUSH?

-- 
dwmw2

