Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270688AbRH1Ku4>; Tue, 28 Aug 2001 06:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270705AbRH1Kus>; Tue, 28 Aug 2001 06:50:48 -0400
Received: from iproxy1.ericsson.dk ([130.228.248.98]:11186 "EHLO
	iproxy1.ericsson.dk") by vger.kernel.org with ESMTP
	id <S270688AbRH1Kuj>; Tue, 28 Aug 2001 06:50:39 -0400
Message-ID: <3B8B7724.EEC95BDD@ted.ericsson.dk>
Date: Tue, 28 Aug 2001 12:49:08 +0200
From: Fabbione <fabio.m.d.nitto@ted.ericsson.dk>
Reply-To: fabbione@fabbione.net
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Possibly OT] ipt_unclean.c on kernel-2.4.7-9
In-Reply-To: <E15bW2B-0001Ur-00@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well probably the documentation should be more explicit. I know that's
experimental
code but someone has to use it in order to increase its quality.
My idea of building the rules was to DROP as much as possible all the
"dirty"
packets before the packets can match the rules that allow connections.

Regarding ECN I've it on on most of my boxes without any problems (I
don't care
if I cannot look to lego.com). but I don't want to restart again the ECN
discussion
there were sometimes ago in the ML.

Cheers
Fabio

Rusty Russell wrote:
> 
> In message <3B8A262C.82ED7793@ted.ericsson.dk> you write:
> > Hi gurus,
> >       I've possibly found a bug in the iptables unclean match support
> > but I was not able to find the email of the mantainer so I'm posting
> > here....
> >
> > the module is incorrectly matching ftp session. Ex:
> >
> > iptables -j DROP -A INPUT --match unclean
> > iptables -j ACCEPT -A INPUT -p tcp --dport 21
> >
> > in this case all my packets directed to the ftp server where dropped by
> > the
> > "unclean" match and this make impossible to open ftp session.
> 
> Please do not do this.  "unclean" should be renamed "interesting": you
> should log these packets, but probably not drop them, otherwise some
> things may break.
> 
> Like ECN...
> 
> Cheers,
> Rusty.
> --
> Premature optmztion is rt of all evl. --DK
