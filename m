Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287840AbSANRpW>; Mon, 14 Jan 2002 12:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287848AbSANRpD>; Mon, 14 Jan 2002 12:45:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40197 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287840AbSANRo7>; Mon, 14 Jan 2002 12:44:59 -0500
Subject: Re: Memory problem with bttv driver
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Mon, 14 Jan 2002 17:56:54 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020114184334.0a1712d4.skraw@ithnet.com> from "Stephan von Krawczynski" at Jan 14, 2002 06:43:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QBLq-0002Mu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The bt848 drivers are working beautifully
> > for me in 2.4.18pre
> 
> Well, I had a quick look at the code, and it seems that vmalloc is just
> failing, the source line is obvious./proc/meminfo before modprobe and xawtv:
> 
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  1054728192 120070144 934658048        0 10420224 65257472
> Swap: 1085652992        0 1085652992
> 
> Can this be highmem-related?

That would make complete sense if so. The bttv uses vmalloc_32(), as the
card has 32bit limits, and I am not running bttv (nor I suspect are most
people) with highmem enabled
