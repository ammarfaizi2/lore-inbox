Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270523AbRH1JLk>; Tue, 28 Aug 2001 05:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270569AbRH1JLV>; Tue, 28 Aug 2001 05:11:21 -0400
Received: from softwa4.lnk.telstra.net ([139.130.12.214]:47854 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S270557AbRH1JLG>;
	Tue, 28 Aug 2001 05:11:06 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: fabbione@fabbione.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Possibly OT] ipt_unclean.c on kernel-2.4.7-9 
In-Reply-To: Your message of "Mon, 27 Aug 2001 12:51:24 +0200."
             <3B8A262C.82ED7793@ted.ericsson.dk> 
Date: Tue, 28 Aug 2001 09:43:10 +1000
Message-Id: <E15bW2B-0001Ur-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3B8A262C.82ED7793@ted.ericsson.dk> you write:
> Hi gurus,
> 	I've possibly found a bug in the iptables unclean match support
> but I was not able to find the email of the mantainer so I'm posting
> here....
> 
> the module is incorrectly matching ftp session. Ex:
> 
> iptables -j DROP -A INPUT --match unclean
> iptables -j ACCEPT -A INPUT -p tcp --dport 21
> 
> in this case all my packets directed to the ftp server where dropped by
> the
> "unclean" match and this make impossible to open ftp session.

Please do not do this.  "unclean" should be renamed "interesting": you
should log these packets, but probably not drop them, otherwise some
things may break.

Like ECN...

Cheers,
Rusty.
--
Premature optmztion is rt of all evl. --DK
