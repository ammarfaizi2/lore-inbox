Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVDCLxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVDCLxp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 07:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVDCLxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 07:53:45 -0400
Received: from [213.170.72.194] ([213.170.72.194]:37855 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261699AbVDCLxm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 07:53:42 -0400
Message-ID: <424FD944.7080606@yandex.ru>
Date: Sun, 03 Apr 2005 15:53:40 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       jmorris@redhat.com, svenning@post5.tele.dk,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Subject: Re: [RFC] CryptoAPI & Compression
References: <1111766900.4566.20.camel@sauron.oktetlabs.ru> <20050326044421.GA24358@gondor.apana.org.au> <1112030556.17983.35.camel@sauron.oktetlabs.ru> <20050331095151.GA13992@gondor.apana.org.au> <424FD653.7020204@yandex.ru> <20050403114704.GC21255@gondor.apana.org.au>
In-Reply-To: <20050403114704.GC21255@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> Can you please point me to the paragraph in RFC 1950 that says this?

Ok, if to do s/correct/compliant/, here it is:

Section 2.3, page 7

-----------------------------------------------------------------------
A compliant compressor must produce streams with correct CMF, FLG and 
ADLER32, but need not support preset dictionaries.
...

A compliant decompressor must check CMF, FLG, and ADLER32, and
provide an error indication if any of these have incorrect values.
A compliant decompressor must give an error indication if CM is
not one of the values defined in this specification (only the
value 8 is permitted in this version), since another value could
indicate the presence of new features that would cause subsequent
data to be interpreted incorrectly
-----------------------------------------------------------------------

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
