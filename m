Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280980AbRLETtq>; Wed, 5 Dec 2001 14:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284614AbRLETtg>; Wed, 5 Dec 2001 14:49:36 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:13325 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280980AbRLETtQ>; Wed, 5 Dec 2001 14:49:16 -0500
Date: Wed, 5 Dec 2001 16:32:25 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Paul Larson <plars@austin.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: compile fails on 2.4.17-pre3
In-Reply-To: <3C0E7534.3EC4B202@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0112051632080.20575-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I'm going to release -pre4 with tcp_diag.c and tcp_diag.h now. 

On Wed, 5 Dec 2001, Jeff Garzik wrote:

> Paul Larson wrote:
> > 
> > Is everybody seeing this and it's obvious, or do I need to send my
> > .config?
> > 
> > ld -m elf_i386  -r -o ipv4.o utils.o route.o inetpeer.o proc.o
> > protocol.o ip_input.o ip_fragment.o ip_forward.o ip_options.o
> > ip_output.o ip_sockglue.o tcp.o tcp_input.o tcp_output.o tcp_timer.o
> > tcp_ipv4.o tcp_minisocks.o tcp_diag.o raw.o udp.o arp.o icmp.o devinet.o
> > af_inet.o igmp.o sysctl_net_ipv4.o fib_frontend.o fib_semantics.o
> > fib_hash.o
> > ld: cannot open tcp_diag.o: No such file or directory
> > make[3]: *** [ipv4.o] Error 1
> > make[3]: Leaving directory `/usr/src/linux/net/ipv4'
> > make[2]: *** [first_rule] Error 2
> > make[2]: Leaving directory `/usr/src/linux/net/ipv4'
> > make[1]: *** [_subdir_ipv4] Error 2
> > make[1]: Leaving directory `/usr/src/linux/net'
> > make: *** [_dir_net] Error 2
> 
> fix:
> 
> 1) remove "tcp_diag.o" from net/ipv4/Makefile
> 2) remove two lines from net/ipv4/tcp.c which reference tcpdiag_init
> 
> The file is in vger so I assume it's easily fixed by adding that file as
> well.  http://vger.kernel.org/
> 
> 	Jeff
> 
> -- 
> Jeff Garzik      | Only so many songs can be sung
> Building 1024    | with two lips, two lungs, and one tongue.
> MandrakeSoft     |         - nomeansno
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

