Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279509AbRKASiM>; Thu, 1 Nov 2001 13:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279510AbRKASh4>; Thu, 1 Nov 2001 13:37:56 -0500
Received: from butterblume.comunit.net ([192.76.134.57]:61452 "EHLO
	butterblume.comunit.net") by vger.kernel.org with ESMTP
	id <S279509AbRKAShe> convert rfc822-to-8bit; Thu, 1 Nov 2001 13:37:34 -0500
Date: Thu, 1 Nov 2001 19:37:31 +0100 (CET)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: haegar@space.comunit.de
To: Fernando Netto <Fernando_Netto@cmsoftware.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a MAX TCP/UDP CONNECTIONS limit in Kernel?
In-Reply-To: <70B75822B253D511AA910002440963EB1D8FD6@CMSERVICES>
Message-ID: <Pine.LNX.4.40.0111011931471.7334-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001, Fernando Netto wrote:

> I´m having problems with concurrent TCP/UDP connections in my machine and
> wondered if there is a limit in Kernel of "how many connections can be open
> simoultaneously".

Are you talking of inbound, or outbound connections?

Inbound-connections are mostly limited by the available filehandles and by
how much server-processes your box can handle.

Outbound-connections are limited by the local portrange, changeable
in /proc/sys/net/ipv4/ip_local_port_range
(ran into this on one of my proxy servers, having thousands of connections
in the state CLOSING, TIME_WAIT and LAST_ACK - after
echo "1024 16383" >/proc/sys/net/ipv4/ip_local_port_range the box at
least stays working)

> If someone know something about limitations and how to tune it up about this
> matter, please don´t forget to put my address in CC as I´m not a signer of
> this list.

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

