Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288498AbSAHWRg>; Tue, 8 Jan 2002 17:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288499AbSAHWR1>; Tue, 8 Jan 2002 17:17:27 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:9230 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288498AbSAHWRL>; Tue, 8 Jan 2002 17:17:11 -0500
Message-ID: <3C3B6E96.8FB0341A@zip.com.au>
Date: Tue, 08 Jan 2002 14:11:34 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael H. Warfield" <mhw@wittsend.com>
CC: David Weinehall <tao@acc.umu.se>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Ivan Passos <ivan@cyclades.com>, linux-kernel@vger.kernel.org
Subject: Re: Serial Driver Name Question (kernels 2.4.x)
In-Reply-To: <3C33E0D3.B6E932D6@zip.com.au> <3C33BCF3.20BE9E92@cyclades.com> <200201030637.g036bxe03425@vindaloo.ras.ucalgary.ca> <200201062012.g06KCIu16158@vindaloo.ras.ucalgary.ca> <3C38BC19.72ECE86@zip.com.au> <200201070636.g076asR25565@vindaloo.ras.ucalgary.ca> <3C3A7DA7.381D033D@zip.com.au>, <3C3A7DA7.381D033D@zip.com.au>; <20020108071548.J5235@khan.acc.umu.se> <3C3A9048.CB80061A@zip.com.au>,
		<3C3A9048.CB80061A@zip.com.au> <20020108165851.B26294@alcove.wittsend.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael H. Warfield" wrote:
> 
> The trouble there is the problem with conventional lock files under
> /var/lock which only use the base name of the device name so cua/42
> and cuf/42 both have the same lock file of /var/lock/LCK..42 and
> would collide.

OK, thanks.  So it looks like we stick with

	http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre2/tty_name.patch

Which just puts %d's at the end of all the device names in the
non-devfs case.

I'll have another go at that patch, check for missed drivers,
then send it out again.  OK?
