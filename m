Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272309AbRIEU1K>; Wed, 5 Sep 2001 16:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272312AbRIEU0w>; Wed, 5 Sep 2001 16:26:52 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:30229 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S272309AbRIEU0f>; Wed, 5 Sep 2001 16:26:35 -0400
From: volodya@mindspring.com
Date: Wed, 5 Sep 2001 16:28:39 -0400 (EDT)
Reply-To: volodya@mindspring.com
To: Jeremiah Johnson <miah@netcis.com>
cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Re[4]: 2.4.9 UDP broke?
In-Reply-To: <111202114514.20010904191953@netcis.com>
Message-ID: <Pine.LNX.4.20.0109051626440.25127-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Sep 2001, Jeremiah Johnson wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: MD5
> 
> Hello volodya,
> 
> I found the answer to the problem today.  It has to do with a bug in
> one of these options:
> 
> CONFIG_TULIP_MWI
> CONFIG_TULIP_MMIO
> 

You are absolutely correct - once I enabled both of these it works
great. My guess is that whoever tested the patches was concentrated on the
case when options were enabled.

                               Vladimir Dergachev

> Since the system is a older dual p100 I didn't really want to sit
> through the 2 hours of compilation to "test" which one it is.  I'm
> willing to bet its CONFIG_TULIP_MWI though since its still marked as
> experimental.  With both of these options disabled 2.4.9 works fine on
> that system though as it does on my other boxes.  Whoever maintains
> the code for those two config options might want to do some testing.
> I can provide more information about the system if needed.
> 
> Sunday, September 02, 2001, 7:25:44 PM, you wrote:
> 
> vmc> I had a very similar experience. In my case it turned out that for some
> vmc> reason no UDP packets above 5524 would not come through (try pinging with
> vmc> larger than default packet sizes). The solution was to restrict NFS to
> vmc> 5000 (actually 4096) size packets. I have not been able to figure out the
> vmc> cause of this yet. (and yes, tcpdump was able to see them fine).
> 
> vmc>                             Vladimir Dergachev
> 
> 
> - --
> Best regards,
>  Jeremiah                            mailto:miah@netcis.com
> 
> -----BEGIN PGP SIGNATURE-----
> Version: 2.6
> 
> iQEVAwUAO5WLyZHTj7BlqKb5AQFiIQf8DG8rppS8oNKQvmQts2rFQzx0MVizZZv/
> p12tm+bcToP8jg6OKL0hzkeL59k3RgJpbjSleHl6VHgGzZ4VfZuvtE7gwA0e/Ch8
> MQck+diQkDY14qM+qxdIhwjuSyt+qDTlOPge/MZKNvtGckYkQ9qKVHiWbKWuxlYS
> U4N8knpXHUZ9fM+hPPqi/0yNfwx6g7QbtLycYJzP0GIDSzP4y/P30HMkSJ9EUzP1
> MQCho4dj2K2WvMyrNVAO70Nj90j1ioU7vJE2LMooKrZmWBpBSMX6MMKr//lJP73H
> RTQLNZmRGbBtblq4QiXai6OpEYkaaE84iutfs9JbssOJ+S2cxNDM1g==
> =XNHF
> -----END PGP SIGNATURE-----
> 

