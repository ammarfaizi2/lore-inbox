Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288511AbSA0Tyx>; Sun, 27 Jan 2002 14:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288512AbSA0Tyo>; Sun, 27 Jan 2002 14:54:44 -0500
Received: from gumby.it.wmich.edu ([141.218.23.21]:3202 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S288511AbSA0Tyi>; Sun, 27 Jan 2002 14:54:38 -0500
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Kristian <kristian.peters@korseby.net>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <20020127111917.3c019701.kristian.peters@korseby.net>
In-Reply-To: <3C5119E0.6E5C45B6@zip.com.au>
	<000701c1a5d5$812ef580$6caaa8c0@kevin> <3C53711B.F8D89811@zip.com.au>
	<3C53A116.81432588@zip.com.au>
	<20020127101131.0f71e978.kristian.peters@korseby.net> 
	<20020127111917.3c019701.kristian.peters@korseby.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 27 Jan 2002 14:54:21 -0500
Message-Id: <1012161271.22707.50.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might want to try sending your cdroms into sleep when dma mode wont
work anymore.  That usually fixes things for me.    hdparm -Y  ....the
kernel should wake them up immediately and things should work again.  


On Sun, 2002-01-27 at 05:19, Kristian wrote:
> Hello again.
> 
> Ok. Sorry. My fault. The second patch produces the same throughput... I didn't realized that the kernel disabled DMA during rebooting. My drives only went to DMA again after a cold boot. Don't know what's going on here. But after a normal reboot, my drives are in PIO only and don't support DMA.
> 
> cdparanoia on /dev/scd0 now gives the same result as with the first patch.
> real    1m8.055s
> user    0m6.740s
> sys     0m2.850s
> 
> *Kristian
> 
>   :... [snd.science] ...:
>  ::
>  :: http://www.korseby.net
>  :: http://gsmp.sf.net
>   :.........................:: ~/$ kristian@korseby.net :
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


