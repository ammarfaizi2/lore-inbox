Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289548AbSAJRGr>; Thu, 10 Jan 2002 12:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289549AbSAJRGi>; Thu, 10 Jan 2002 12:06:38 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:26129 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S289548AbSAJRG3>; Thu, 10 Jan 2002 12:06:29 -0500
Date: Thu, 10 Jan 2002 15:06:26 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] s/TCP_ESTABLISHED/PROTO_ESTABLISHED/g
Message-ID: <20020110170626.GG1010@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020110161629.GF1010@conectiva.com.br> <20020110.082141.74749837.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020110.082141.74749837.davem@redhat.com>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 10, 2002 at 08:21:41AM -0800, David S. Miller escreveu:
>    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
>    Date: Thu, 10 Jan 2002 14:16:29 -0200
> 
>    	Part of the sock cleanup made me remove the #include <linux/tcp.h> from
>    include/linux/ip.h and from include/net/sock.h, i.e., it is not needed in
>    those headers, but then I had to go to udp.c, ipx.c, decnet, etc, and add a
>    #include <linux/tcp.h> because it needs TCP_ESTABLISHED, TCP_CLOSE, etc,
>    this is a pet peeve to me, as a janitor :-) Can I change this to
>    PROTO_ESTABLISHED, PROTO_CLOSE, etc, and have it on a different header, say
>    include/net/protocol.h?  Its strange to have IPX, DecNET, etc having to
>    include net/tcp.h (that in turn includes ip.h, etc).
>    
>    	If this is ok I can bundle it in the sock cleanup or send it
>    separately, your call.
> 
> These other protocols are just borrowing state machine states from
> TCP.  I really see no reason to rename them, because then if you did
> the TCP usage wouldn't make look right anymore. :-)
> 
> I don't mind moving the header include from sock.h to the protocols
> though.

just to make sure I understood: "to the protocols" means creating
IPX_ESTABLISHED, etc, or does it mean having the protocols include tcp.h?

- Arnaldo
