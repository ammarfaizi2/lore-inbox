Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132606AbRD1JXR>; Sat, 28 Apr 2001 05:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132623AbRD1JXH>; Sat, 28 Apr 2001 05:23:07 -0400
Received: from [209.195.52.31] ([209.195.52.31]:2828 "HELO [209.195.52.31]")
	by vger.kernel.org with SMTP id <S132606AbRD1JWx>;
	Sat, 28 Apr 2001 05:22:53 -0400
From: David Lang <david.lang@digitalinsight.com>
To: valery <valery.brasseur@atosorigin.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Date: Sat, 28 Apr 2001 01:14:03 -0700 (PDT)
Subject: Re: linux and high volume web sites
In-Reply-To: <3AEA86DF.696CD1A7@atosorigin.com>
Message-ID: <Pine.LNX.4.33.0104280109430.15628-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

watch the resonate heartbeat and see if it is getting lost in the network
traffic (the resonate logs will show missing heartbeat packets). think
seriously of setting the resonate stuff to run at a higher priority so
that it doesn't get behind.

depending on how high your network traffic is seriously look at putting in
a second nic and switch to move the NFS traffic off the network that has
the internet traffic and hearbeat.

I had the same problem with central dispatch a couple years ago when first
implementing it. the exact details of the problem that I ran into should
have been fixed by now (mostly having to do with large number of virtual
IP addresses) but the symptoms were the same.

David Lang


 On
Sat, 28 Apr 2001, valery wrote:

> Date: Sat, 28 Apr 2001 11:01:19 +0200
> From: valery <valery.brasseur@atosorigin.com>
> To: linux kernel <linux-kernel@vger.kernel.org>
> Subject: linux and high volume web sites
>
> I have a high volume web site under linux :
> kernel is 2.2.17
> hardware is 5 bi-PIII 700Mhz / 512Mb, eepro100
> all server are diskless (nfs on an netapp filer) except for tmp and swap
>
> dispatch is done by the Resonate product
>
> web server is apache+php (something like 400 processes), database
> backend is a mysql on the same hardware
>
>
> in high volume from time to time machines are "freezing" then after a
> few seconds they "reappear" and response timne is
>
>
> how can I investigate all these problems ?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
