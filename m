Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288243AbSAHSvP>; Tue, 8 Jan 2002 13:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288233AbSAHSvG>; Tue, 8 Jan 2002 13:51:06 -0500
Received: from intra.cyclades.com ([209.81.55.6]:42500 "HELO
	intra.cyclades.com") by vger.kernel.org with SMTP
	id <S288242AbSAHSu7>; Tue, 8 Jan 2002 13:50:59 -0500
Message-ID: <3C3B405F.4996257D@cyclades.com>
Date: Tue, 08 Jan 2002 10:54:23 -0800
From: Ivan Passos <ivan@cyclades.com>
Organization: Cyclades Corporation
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
Cc: David Weinehall <tao@acc.umu.se>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: Serial Driver Name Question (kernels 2.4.x)
In-Reply-To: <3C38BC19.72ECE86@zip.com.au>, <3C34024A.EDA31D24@zip.com.au> <3C33E0D3.B6E932D6@zip.com.au> <3C33BCF3.20BE9E92@cyclades.com> <200201030637.g036bxe03425@vindaloo.ras.ucalgary.ca> <200201062012.g06KCIu16158@vindaloo.ras.ucalgary.ca> <3C38BC19.72ECE86@zip.com.au> <200201070636.g076asR25565@vindaloo.ras.ucalgary.ca> <3C3A7DA7.381D033D@zip.com.au>,
			<3C3A7DA7.381D033D@zip.com.au>; from akpm@zip.com.au on Mon, Jan 07, 2002 at 09:03:35PM -0800 <20020108071548.J5235@khan.acc.umu.se> <3C3A9048.CB80061A@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
> 
> Well, with the scheme I proposed most drivers won't need the
> ifdef.  It'll just be:
> 
>         serial_driver.name = "cua";
> 
> With devfs enabled that expands to cua/42.  Without devfs it expands
> to cua42.

Check my previous msg. Actually that won't work for other drivers 
other than serial.c, that's why we should use the scheme I suggested 
on that msg.

Hmmmm, I just thought about something that might be a problem with 
this change. I believe Richard Gooch is the right person to tell us 
whether this is a problem or not.

We're just talking about print msgs in tty_io.c (and the scheme I 
suggested -- i.e. to use 'tts/X' for devfs and 'ttyX' for non-devfs 
and have "%s%d" in tty_io.c's printk call -- does cover all driver in 
that aspect), but I'm not sure whether devfs uses the driver.name 
definition for something else. If that's the case, then devfs would 
need to be updated as well to comply with the new driver.name 
definition.

Richard, is this a problem or not?!?!

Later,
-- 
Ivan Passos							 -o)
Integration Manager, Cyclades	- http://www.cyclades.com	 /\\
Project Leader, NetLinOS	- http://www.netlinos.org	_\_V
--------------------------------------------------------------------
