Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261719AbRFEMxG>; Tue, 5 Jun 2001 08:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261805AbRFEMw4>; Tue, 5 Jun 2001 08:52:56 -0400
Received: from t2.redhat.com ([199.183.24.243]:43763 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261719AbRFEMwt>; Tue, 5 Jun 2001 08:52:49 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <15132.54565.311995.865807@pizda.ninka.net> 
In-Reply-To: <15132.54565.311995.865807@pizda.ninka.net>  <15132.41562.879696.484467@pizda.ninka.net> <15132.40298.80954.434805@pizda.ninka.net> <15132.22933.859130.119059@pizda.ninka.net> <13942.991696607@redhat.com> <3B1C1872.8D8F1529@mandrakesoft.com> <15132.15829.322534.88410@pizda.ninka.net> <20010605155550.C22741@metastasis.f00f.org> <25587.991730769@redhat.com> <25831.991731935@redhat.com> <14071.991744970@redhat.com> 
To: "David S. Miller" <davem@redhat.com>
Cc: Chris Wedgwood <cw@f00f.org>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        bjornw@axis.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: Missing cache flush. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 05 Jun 2001 13:52:41 +0100
Message-ID: <17788.991745561@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



davem@redhat.com said:
>  How about flush_cache_range_force() instead?
> I want something in the name that tells the reader "this flushes the
> caches, even though under every other ordinary circumstance you would
> not need to". 

OL, then. I would have thought it made more sense to have the
flush_dcache_range() unconditionally do what its name implies, and to have a
separate flush_dcache_range_for_dma() function which is optional. But that
decision was already made - I suppose we can't change the semantics now.

--
dwmw2


