Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318435AbSHKWlv>; Sun, 11 Aug 2002 18:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318436AbSHKWlv>; Sun, 11 Aug 2002 18:41:51 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:57361 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318435AbSHKWlu>; Sun, 11 Aug 2002 18:41:50 -0400
Date: Sun, 11 Aug 2002 19:45:30 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 : net/network.o error
Message-ID: <20020811224530.GB3890@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208111252530.11441-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208111252530.11441-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Aug 11, 2002 at 12:54:36PM -0400, Frank Davis escreveu:
> Hello all,
>   While 'make bzImage', I received the following error.
> Regards,
> Frank
> 
> net/network.o: In function `unregister_8022_client':
> net/network.o(.text+0x13ab0): undefined reference to `save_flags'
> net/network.o(.text+0x13ab5): undefined reference to `cli'
> net/network.o(.text+0x13aea): undefined reference to `restore_flags'
> net/network.o: In function `unregister_snap_client':
> net/network.o(.text+0x13c96): undefined reference to `save_flags'
> net/network.o(.text+0x13c9b): undefined reference to `cli'
> net/network.o(.text+0x13cf9): undefined reference to `restore_flags'
> make: *** [vmlinux] Error 1

SMP, these functions are going to die, nowadays they still work on UP, but
they, AFAIK, will be nuked. In this specific case I have already merged a
fix with DaveM, wait for 2.5.32 8) They now use BR_NETPROTO_LOCK and use
the new LLC.

- Arnaldo
