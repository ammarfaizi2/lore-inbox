Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279628AbRKATgQ>; Thu, 1 Nov 2001 14:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279630AbRKATgH>; Thu, 1 Nov 2001 14:36:07 -0500
Received: from [217.6.75.131] ([217.6.75.131]:48050 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S279628AbRKATf6> convert rfc822-to-8bit; Thu, 1 Nov 2001 14:35:58 -0500
Message-ID: <3BE1A649.4718E3B2@internetwork-ag.de>
Date: Thu, 01 Nov 2001 20:45:13 +0100
From: Till Immanuel Patzschke <tip@internetwork-ag.de>
Organization: interNetwork AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sven Koch <haegar@sdinet.de>
CC: Fernando Netto <Fernando_Netto@cmsoftware.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Is there a MAX TCP/UDP CONNECTIONS limit in Kernel?
In-Reply-To: <Pine.LNX.4.40.0111011931471.7334-100000@space.comunit.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... there may be some sort of "implicit" limit resulting from the kernel memory.
I've run into the same problem but a fix is easy.  Get the 3.5G patch from
Andrea's patch series (the -aa one), and modify it to NOT have 3.5GB of user
memory but 2.5 or 2 GB for example. Worked fine for me...
Cheers,

Immanuel


Sven Koch wrote:

> On Thu, 1 Nov 2001, Fernando Netto wrote:
>
> > I´m having problems with concurrent TCP/UDP connections in my machine and
> > wondered if there is a limit in Kernel of "how many connections can be open
> > simoultaneously".
>
> Are you talking of inbound, or outbound connections?
>
> Inbound-connections are mostly limited by the available filehandles and by
> how much server-processes your box can handle.
>
> Outbound-connections are limited by the local portrange, changeable
> in /proc/sys/net/ipv4/ip_local_port_range
> (ran into this on one of my proxy servers, having thousands of connections
> in the state CLOSING, TIME_WAIT and LAST_ACK - after
> echo "1024 16383" >/proc/sys/net/ipv4/ip_local_port_range the box at
> least stays working)
>
> > If someone know something about limitations and how to tune it up about this
> > matter, please don´t forget to put my address in CC as I´m not a signer of
> > this list.
>
> c'ya
> sven
>
> --
>
> The Internet treats censorship as a routing problem, and routes around it.
> (John Gilmore on http://www.cygnus.com/~gnu/)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
Till Immanuel Patzschke                 mailto: tip@internetwork-ag.de
interNetwork AG                         Phone:  +49-(0)611-1731-121
Bierstadter Str. 7                      Fax:    +49-(0)611-1731-31
D-65189 Wiesbaden                       Web:    http://www.internetwork-ag.de



