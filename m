Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274581AbRITRu0>; Thu, 20 Sep 2001 13:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274592AbRITRuQ>; Thu, 20 Sep 2001 13:50:16 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:36359 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S274581AbRITRuG>; Thu, 20 Sep 2001 13:50:06 -0400
Message-ID: <3BAA2BF6.467CEB10@osdlab.org>
Date: Thu, 20 Sep 2001 10:48:38 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus <torvalds@transmeta.com>, lkml <linux-kernel@vger.kernel.org>,
        sfr@canb.auug.org.au, crutcher+kernel@datastacks.com
Subject: Re: [PATCH] fix register_sysrq() in 2.4.9++
In-Reply-To: <E15k7pZ-0005i0-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> u> +
> > +static inline int register_sysrq_key(int key, struct sysrq_key_op *op_p)
> > +{
> > +     return -1;
> > +}
> 
> make it report ok as other non compiled in stuff does - then you can avoid
> masses of ifdefs

Yeah, I considered that, and it doesn't matter to me whether it
reports 0 or -1, but it's the data pointer that (mostly) requires
the #ifdefs, unless the data is always present or a dummy data pointer
is used.... ?

~Randy
