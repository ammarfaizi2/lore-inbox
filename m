Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbVHHPQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVHHPQU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 11:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbVHHPQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 11:16:20 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:45900 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750753AbVHHPQT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 11:16:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m3SZ1aKJ+tEyTWr/8Dfwwuprrhqm3/RMQKThIVVcwVBCLRZZ4XBeFjDtMlwkD5Jvh2xm7NItSHXz09qwu+BaSpT/qkX5fCqS/x5Q9xcdiwELYUTtnTk6KmhqhBy4vu6TwMu18eXWiAM9OVMRgULgDzJYFz1pUf8uzAzS4ZgNero=
Message-ID: <9268368b05080808167189591b@mail.gmail.com>
Date: Mon, 8 Aug 2005 11:16:16 -0400
From: Daniel Petrini <d.pensator@gmail.com>
To: Folkert van Heusden <folkert@vanheusden.com>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 5
Cc: Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, vatsa@in.ibm.com, ck@vds.kolivas.org,
       tony@atomide.com, tuukka.tikkanen@elektrobit.com, george@mvista.com,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050808150829.GW22838@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508031559.24704.kernel@kolivas.org>
	 <200508060239.41646.kernel@kolivas.org>
	 <20050806174739.GU4029@stusta.de>
	 <200508071512.22668.kernel@kolivas.org>
	 <20050808150829.GW22838@vanheusden.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folkert,

Yes, there are some utilities. You can use pmstats-0.2 (look for the
link in past messages) or timertop (sent some minutes ago in LKML).
Regards,
Daniel

On 8/8/05, Folkert van Heusden <folkert@vanheusden.com> wrote:
> Are there any tools for checking the current number of ticks?
> I currently do:
> #!/bin/sh
> 
> S1=`cat /proc/interrupts | grep "^  0: " | awk '{ print $2; }'`
> sleep 1
> S2=`cat /proc/interrupts | grep "^  0: " | awk '{ print $2; }'`
> echo $((S2-S1))
> 
> But that gives me output like this on a quiet system with only firefox,
> a couple of gnometerms and a bittorrent downloader values like:
> folkert@ehm:~$ for i in `seq 1 10` ; do ./ticks ; done
> 566
> 511
> 630
> 501
> 522
> 533
> 503
> 516
> 518
> 515
> which I find quiet high, aren't they?
> 
> 
> On Sun, Aug 07, 2005 at 03:12:21PM +1000, Con Kolivas wrote:
> > Respin of the dynamic ticks patch for i386 by Tony Lindgen and Tuukka Tikkanen
> > with further code cleanups. Are were there yet?
> >
> > Cheers,
> > Con
> > ---
> >
> >
> 
> 
> Folkert van Heusden
> 
> --
> Auto te koop, zie: http://www.vanheusden.com/daihatsu.php
> --------------------------------------------------------------------
> Get your PGP/GPG key signed at www.biglumber.com!
> --------------------------------------------------------------------
> Phone: +31-6-41278122, PGP-key: 1F28D8AE
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
10LE - Linux
INdT - Manaus - Brazil
