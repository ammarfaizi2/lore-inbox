Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265701AbSJTADt>; Sat, 19 Oct 2002 20:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265704AbSJTADt>; Sat, 19 Oct 2002 20:03:49 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:39689 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265701AbSJTADt>; Sat, 19 Oct 2002 20:03:49 -0400
Date: Sat, 19 Oct 2002 21:09:43 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: only produce one record in fib_seq_show
Message-ID: <20021020000943.GL14009@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20021019233236.GI14009@conectiva.com.br> <20021019.165451.110952098.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021019.165451.110952098.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Oct 19, 2002 at 04:54:51PM -0700, David S. Miller escreveu:
> This change is problematic, the FIB etc. lookup engine internal
> structure must be entirely private to the implementation.
> 
> That allows it to be changed arbitrarily and the rest of the
> kernel will not notice.
> 
> You should probably move the seq_file handling here directly back into
> the routing code.
> 
> Really, we should not be exporting all of these lookup tables merely
> for the sake of ip_proc.c, in fact move all this seq_file stuff back
> into the arp/udp/fib/etc. places they came from.  Exporting these
> tables just for this makes no sense the more I think about it.

Humm, OKey chief, but the rest of the kernel in this case would be just
ip_proc, but I see, having it exported may well lead to someone to use it for
other purposes, ok, ok, back to work.

I'll start with fib, as it was not merged yet and its a fix that has to get in.

What about the CONFIG_IP_PROC_FS idea? Does it sounds reasonable or is it utter
crap? :-)

- Arnaldo
