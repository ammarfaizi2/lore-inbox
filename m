Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289518AbSAJQRF>; Thu, 10 Jan 2002 11:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289519AbSAJQQz>; Thu, 10 Jan 2002 11:16:55 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:35337 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S289518AbSAJQQj>; Thu, 10 Jan 2002 11:16:39 -0500
Date: Thu, 10 Jan 2002 14:16:29 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: davem@redhat.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC] s/TCP_ESTABLISHED/PROTO_ESTABLISHED/g
Message-ID: <20020110161629.GF1010@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	davem@redhat.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

	Part of the sock cleanup made me remove the #include <linux/tcp.h> from
include/linux/ip.h and from include/net/sock.h, i.e., it is not needed in
those headers, but then I had to go to udp.c, ipx.c, decnet, etc, and add a
#include <linux/tcp.h> because it needs TCP_ESTABLISHED, TCP_CLOSE, etc,
this is a pet peeve to me, as a janitor :-) Can I change this to
PROTO_ESTABLISHED, PROTO_CLOSE, etc, and have it on a different header, say
include/net/protocol.h?  Its strange to have IPX, DecNET, etc having to
include net/tcp.h (that in turn includes ip.h, etc).

	If this is ok I can bundle it in the sock cleanup or send it
separately, your call.

- Arnaldo
