Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317388AbSFCOv7>; Mon, 3 Jun 2002 10:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317386AbSFCOv6>; Mon, 3 Jun 2002 10:51:58 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:30101 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317385AbSFCOv4>; Mon, 3 Jun 2002 10:51:56 -0400
Date: Mon, 3 Jun 2002 16:23:38 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Gerald Teschl <gerald.teschl@univie.ac.at>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <zwane@commfireservices.com>
Subject: Re: isapnp problems with opl3sa2 
In-Reply-To: <3CFB5B04.2090508@univie.ac.at>
Message-ID: <Pine.LNX.4.44.0206031429090.8552-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002, Gerald Teschl wrote:

> the isapnp activation of this card fails (this has been broken ever 
> since the 2.4 series).So I did some investigations and eventually found 
> out that the reason is the following check from isapnp_check_dma(..) in 
> isapnp.c:

You should be able to load it without any parameters with ISAPNP, i have a 
box at home with that card which only requires a modprobe opl3sa2. Could 
you show me how you're loading it as well as dmesg and /proc/isapnp output 
after loading.

> A few further remarks concerning my patch:
> *) The patch also adds a line "opl3sa2_state[card].activated = 1" which 
> is an obvious omission in the original driver.

Thanks, put it right at the end before the return and i'll be happy.

> *) I have to force the driver to use both dma=0 and dma2=1. From what I
> understand dma=0 should be sufficient, but this will not work. Looks like
> a bug in isapnp.c to me. However, this should do no harm since according
> to /proc/isapnp, the card only offers these values anyway.

isapnp.c is fine

> -----------------------------------------------
> --- drivers/sound/opl3sa2.c.orig        Thu May  2 23:36:45 2002
> +++ drivers/sound/opl3sa2.c     Sun Jun  2 15:19:44 2002

When you rediff, can you diff so that the patch can be applied with a 
strip of '1' ie diff -u linux/drivers...

Cheers,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		


