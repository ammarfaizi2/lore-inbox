Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272912AbRI0NrM>; Thu, 27 Sep 2001 09:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272926AbRI0NrD>; Thu, 27 Sep 2001 09:47:03 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:15376 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S272912AbRI0Nqw>;
	Thu, 27 Sep 2001 09:46:52 -0400
Date: Thu, 27 Sep 2001 10:47:06 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Linux 0.01 disk lockup
Message-ID: <20010927104706.B2968@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <Pine.LNX.3.96.1010927150812.28147B-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.3.96.1010927150812.28147B-100000@artax.karlin.mff.cuni.cz>; from mikulas@artax.karlin.mff.cuni.cz on Thu, Sep 27, 2001 at 03:34:11PM +0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 27, 2001 at 03:34:11PM +0200, Mikulas Patocka escreveu:
> Linux 0.01 has a bug in disk request sorting - when interrupt happens
> while sorting is active, the interrupt routine won't clear do_hd - thus
> the disk will stay locked up forever. 
> 
> Function add_request also lacks memory barriers - the compiler could
> reorder writes to variable sorting and writes to request queue - producing
> race conditions. Because gcc 1.40 does not have __asm__("":::"memory"), I
> had to use dummy function call as a memory barrier. 
> 
> The following patch fixes both issues.

Fantastic! who is the maintainer for the 0.x kernel series these days? I
thought that 2.0 was Dave W., 2.2 was Alan, 2.4 Linus, so now we have to
find people for 1.2 and finally get 1.2.14 released, man, how I wanted one
with the dynamic PPP code in back in those days... 8)

- Arnaldo
