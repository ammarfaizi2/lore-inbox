Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288005AbSBDAf0>; Sun, 3 Feb 2002 19:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288012AbSBDAfR>; Sun, 3 Feb 2002 19:35:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37646 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288005AbSBDAfG>; Sun, 3 Feb 2002 19:35:06 -0500
Subject: Re: [PATCH] Symbol troubles in 2.4.18pre... kernels
To: michal@harddata.com (Michal Jaegermann)
Date: Mon, 4 Feb 2002 00:48:12 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br (Marcelo Tosatti),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20020203171615.A12981@mail.harddata.com> from "Michal Jaegermann" at Feb 03, 2002 05:16:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16XXIq-0005ml-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> depmod: 	sis_malloc
> 
> The trouble is that these modules are exported by drivers/video/sis/sis_main.c
> so depmod has valid complaints if the first was configured and the other
> not.  So this is a source error or a configuration error depending if
> these two are supposed to be independent or not.

There isnt a good way to fix this in the config language - suggestions
welcome

> 'isa_eth_io_copy_and_sum' is defined only for some architectures but
> assorted modules, like drivers/net/3c503.o and few others, can be
> configured, say, for Alpha and 'depmod' once again complains about
> unresolved symbols.  I do not think that anybody will really miss that
> on Alpha but maybe configuring them in should be disallowed?

This is a bug in the Alpha port. Fix the port. Its not ecactly the
most complex function to implement.

> Some sound modules are using 'mdelay', defined in linux/delay.h,
> but are not including this header.  Here, at last, the patch is trivial. :-)

Yep - looks good to me
