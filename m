Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292183AbSBOVwL>; Fri, 15 Feb 2002 16:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292182AbSBOVwD>; Fri, 15 Feb 2002 16:52:03 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:2799 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S292183AbSBOVvx>; Fri, 15 Feb 2002 16:51:53 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020215153717.F1211@altus.drgw.net> 
In-Reply-To: <20020215153717.F1211@altus.drgw.net>  <20020213.013557.74564240.davem@redhat.com> <E16awZq-0004s4-00@the-village.bc.nu> <3C6A3F66.75D57124@zip.com.au> 
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        ralf@uni-koblenz.de
Subject: Re: [patch] printk and dma_addr_t 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Feb 2002 21:51:16 +0000
Message-ID: <3438.1013809876@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hozer@drgw.net said:
>  I need something like this for the MTD patch I've got that supports
> 64  bit buswidths on 32 bit machines and needs to printk the data on
> error.

> I found that #define CFI_FMT '%lx' or whatever to be more
> straightforward, and easier to understand. 

I got annoyed with the original implementation that turned up in CVS, with 
a completely separate printk line #ifdef CFI_WORD_64, and I changed it to 
always cast to (long long) before printing. Although I half suspect I'll 
end up redoing it again before actually sending it to Linus.

--
dwmw2


