Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272790AbRIGRan>; Fri, 7 Sep 2001 13:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272792AbRIGRad>; Fri, 7 Sep 2001 13:30:33 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:50694 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272790AbRIGRa2>; Fri, 7 Sep 2001 13:30:28 -0400
From: volodya@mindspring.com
Date: Fri, 7 Sep 2001 13:32:47 -0400 (EDT)
Reply-To: volodya@mindspring.com
To: Jeremiah Johnson <miah@netcis.com>
cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Re[6]: 2.4.9 UDP broke?
In-Reply-To: <8638021391.20010907103407@netcis.com>
Message-ID: <Pine.LNX.4.20.0109071329370.8051-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Sep 2001, Jeremiah Johnson wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: MD5
> 
> Hello volodya,
> 
> If I enable both of these options though, UDP totally breaks for me.
> So its definitely something in there.  Maybe I'll get some time and
> test to see which option is actually doing the breaking.

After some testing: 2.4.6 and 2.4.8 require both of these options be
disabled. 2.4.9 wants them enabled. 

Furthemore: after I turned on these option on the only 2.4.9 kernel I
currently have I was able to ping all machines on the network (and they
were able to ping each other). However, before (when options were turned
off) none of the machines on the network could ping each other with
packets of size 6000, though I could see them with tcpdump. 

<whine> 
tulip worked so great earlier, why mess with it ?
</whine>

                         Vladimir Dergachev

> 
> Wednesday, September 05, 2001, 1:28:39 PM, you wrote:
> 
> vmc> On Tue, 4 Sep 2001, Jeremiah Johnson wrote:
> 
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: MD5
> >>
> >> Hello volodya,
> >>
> >> I found the answer to the problem today.  It has to do with a bug in
> >> one of these options:
> >>
> >> CONFIG_TULIP_MWI
> >> CONFIG_TULIP_MMIO
> >>
> 
> vmc> You are absolutely correct - once I enabled both of these it works
> vmc> great. My guess is that whoever tested the patches was concentrated on the
> vmc> case when options were enabled.
> 
> vmc>                                Vladimir Dergachev
> 
> - --
> Best regards,
>  Jeremiah                            mailto:miah@netcis.com
> 
> -----BEGIN PGP SIGNATURE-----
> Version: 2.6
> 
> iQEVAwUAO5kFFJHTj7BlqKb5AQG+9ggAnKz03bYjsYYSsrINzUTKEFCtWs2bRP0t
> sGsIZ55rpi4FH9QFbJGIzxih6C5Mf3p1IJU2fUEP5ci4ddEDJbWbAia/4yz6S2qd
> hAe3pjep/Oy1XBky8PKxIpLkOJMAgFgqeM9aguwFVCuhXxZBvK6NNPaozqZ/nYHl
> 9EM8/kuwfNONaJxYnduqkCRPKdCUPxPZcuwd56Wt3JvJ6meUW249pGEBJhFM63Qe
> +esn3TweBeYj5M80mYcU0CunDRr3D0ABMrdtApCUv0FMIP7ke0LTCQBeZZrUtajW
> +k/gDEySN3tRIuCUltYZ5SYMxtxFZ6eYgerwyhr3s8iKfD+7Tk1BFg==
> =/5Uc
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

