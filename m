Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267542AbTACQpk>; Fri, 3 Jan 2003 11:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267583AbTACQpk>; Fri, 3 Jan 2003 11:45:40 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:38404 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267542AbTACQpj>; Fri, 3 Jan 2003 11:45:39 -0500
Date: Fri, 3 Jan 2003 14:53:38 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Disconnect <lkml@sigkill.net>, linux-kernel@vger.kernel.org
Subject: Re: [STUPID] Best looking code to transfer to a t-shirt
Message-ID: <20030103165337.GH20463@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Disconnect <lkml@sigkill.net>,
	linux-kernel@vger.kernel.org
References: <1041609546.15509.2.camel@sparky> <Pine.LNX.4.33L2.0301030831190.32697-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0301030831190.32697-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 03, 2003 at 08:32:55AM -0800, Randy.Dunlap escreveu:
> | On Fri, 2003-01-03 at 08:25, Maciej Soltysiak wrote:
> | > Hi,
> | >
> | > I am in a t-shirt transfering frenzy and was wondering which part of the
> | > kernel code it would be best to have on my t-shirt.
> | > I was looking at my favourite: netfilter code, but it is to clean, short
> | > and simple functions, no tons of pointers, no mallocs, no hex numbers, too
> | > many defines used. I was looking for something terribly complicated and
> | > looking awesome to the eye.
> | >
> | > How about we have a poll of the most frightening pieces of the kernel ?
> | > What are your ideas?
> 
> (not 'code')
> Take the ASCII art from the Sparc and PA-RISC die() functions, like so:
> 
> 
> 
>           die_on_sparc:                      die_on_parisc:
>                                        _______________________________
>                                       < Your System ate a SPARC! Gah! >
>           \|/ ____ \|/                 -------------------------------
>           "@'/ .. \`@"                        \   ^__^
>           /_| \__/ |_\                         \  (xx)\_______
>              \__U_/                               (__)\       )\/\
>                                                    U  ||----w |
>                                                       ||     ||

Hey, dont forget this one:

void ipgre_err(struct sk_buff *skb, u32 info)
{
#ifndef I_WISH_WORLD_WERE_PERFECT

/* It is not :-( All the routers (except for Linux) return only
   8 bytes of packet payload. It means, that precise relaying of
   ICMP in the real Internet is absolutely infeasible.

   Moreover, Cisco "wise men" put GRE key to the third word
   in GRE header. It makes impossible maintaining even soft state for keyed
   GRE tunnels with enabled checksum. Tell them "thank you".

   Well, I wonder, rfc1812 was written by Cisco employee,
   what the hell these idiots break standrads established
   by themself???
 */

        struct iphdr *iph = (struct iphdr*)skb->data;

net/ipv4/ip_gre.c::317

8)

- Arnaldo
