Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbSLWCcW>; Sun, 22 Dec 2002 21:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbSLWCcW>; Sun, 22 Dec 2002 21:32:22 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:50193 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S266292AbSLWCcV>; Sun, 22 Dec 2002 21:32:21 -0500
Date: Mon, 23 Dec 2002 00:40:17 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       joe user <joe_user35@hotmail.com>
Subject: Re: [PATCH] /proc/net/tcp + ipv6 hang
Message-ID: <20021223024017.GO4942@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Anders Gustafsson <andersg@0x63.nu>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	joe user <joe_user35@hotmail.com>
References: <20021223015723.GA17439@gagarin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021223015723.GA17439@gagarin>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 23, 2002 at 02:57:23AM +0100, Anders Gustafsson escreveu:
> this patch fixes an infinite loop when reading /proc/net/tcp and having
> daemons listening on ipv6.

Perfect! Thanks for the fix, looking at it now it seems soooo obvious, /me
slaps himself in the face 8)

David, pleasey apply, I think there is still at least one bug with this code,
will be testing this as soon as possible.

Anders, if you're feeling brave, from the top of my head, think about what
happens if somebody only reads the first, say, 10 bytes of /proc/net/tcp, will
we unlocking a not held lock at tcp_seq_stop, no? :-)

Another fix for this one will be apreciated 8)

- Arnaldo
