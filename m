Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265552AbTGHJWm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 05:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbTGHJWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 05:22:42 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:24230 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S265552AbTGHJWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 05:22:41 -0400
Date: Tue, 8 Jul 2003 06:34:27 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Richard Curnow <Richard.Curnow@superh.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre4 won't link without CONFIG_QUOTA
In-Reply-To: <20030708092128.GB5725@malvern.uk.w2k.superh.com>
Message-ID: <Pine.LNX.4.55L.0307080633430.10728@freak.distro.conectiva>
References: <20030708092128.GB5725@malvern.uk.w2k.superh.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm waiting from a hch's patch to fix that and have -pre4 released
tomorrow.

On Tue, 8 Jul 2003, Richard Curnow wrote:

> Hi Christoph,
>
> I'm building without quota support.  I get the following error at link
> time:
>
> fs/fs.o(.text..SHmedia32+0x33fa0): In function `v1_get_stats':
> : undefined reference to `dqstats'
> fs/fs.o(.text..SHmedia32+0x33fa4): In function `v1_get_stats':
> : undefined reference to `dqstats'
> make: *** [vmlinux] Error 1
>
> Looking in fs/Makefile, fs/quota.c it's apparent that quota.o is being
> included unconditionally in the link now, and quota.c references
> dqstats, but dqstats is defined in fs/dquot.c which is only linked in if
> CONFIG_QUOTA is set.
>
> I'm sorry I'm not familiar enough with this area of the code to suggest
> a fix.
>
> Cheers
> Richard
>
> --
> Richard \\\ SuperH Core+Debug Architect /// .. At home ..
>   P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
> Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
