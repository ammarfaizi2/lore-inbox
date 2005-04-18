Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVDRPJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVDRPJg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 11:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVDRPJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 11:09:36 -0400
Received: from [213.170.72.194] ([213.170.72.194]:51106 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S262099AbVDRPJb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 11:09:31 -0400
Message-ID: <4263CDA9.7070207@yandex.ru>
Date: Mon, 18 Apr 2005 19:09:29 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
References: <20050403084415.GA20326@gondor.apana.org.au> <424FB06B.3060607@yandex.ru> <20050403093044.GA20608@gondor.apana.org.au> <424FBB56.5090503@yandex.ru> <20050403100043.GA20768@gondor.apana.org.au> <1112522762.3899.182.camel@localhost.localdomain> <20050403101752.GA20866@gondor.apana.org.au> <1112527158.3899.213.camel@localhost.localdomain> <20050403114045.GA21255@gondor.apana.org.au> <4250175D.5070704@yandex.ru> <20050403213207.GA24462@gondor.apana.org.au>
In-Reply-To: <20050403213207.GA24462@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Well, with Mark Adler's help I've realized that extending zlib isn't 
than simple task.

Herbert Xu wrote:
> What I was suggesting is to invert the calculation that deflateBound
> is doing so that it gives a lower bound on the input buffer size
> that does not exceed a given output buffer size.
Actually, for JFFS2 we need to leave the uncompressable data 
uncompressed. So if the pcompress interface have only been for JFFS2, 
I'd just return an error rather then expand data. Is such behavior 
acceptable for common Linux's parts pike CryptoAPI ?

And more, frankly, I don't like the "independent" partial compression 
approach in JFFS2 and in JFFS3 (if it will ever happen) I'd make these 
pieces dependent. For this purpose we'd need some deflate-like CryptoAPI 
interface. I'm not going to implement it at the moment, I'm just curious 
- what do you guys think about a generalized deflate-like CryptoAPI 
compression interface?

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
