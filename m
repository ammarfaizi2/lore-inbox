Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271538AbRHPJ1s>; Thu, 16 Aug 2001 05:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271539AbRHPJ1i>; Thu, 16 Aug 2001 05:27:38 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:63502 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S271538AbRHPJ1a>; Thu, 16 Aug 2001 05:27:30 -0400
Date: Thu, 16 Aug 2001 11:27:37 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Colonel <klink@clouddancer.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: WANTED: Re: VM lockup with 2.4.8 / 2.4.8pre8
In-Reply-To: <20010816042734.D3E7C783F5@mail.clouddancer.com>
Message-ID: <Pine.LNX.4.33.0108161121100.31256-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2001, Colonel wrote:

> In clouddancer.list.kernel, you wrote:
> >
> >>
> >> >I also propose to half badness of processes with pid < 1000 - those
> >> >processes are usually also important, because they are called during
> >> >boot-time and they usually handle important system affairs.
> >>
> >>
> >> The belief that boot started processes remain under a pid < 1000 is
> >> flawed.  Simple example: the postfix mail server.
> >>
> >
> >agreed, but FWIW my postfix master daemon is pid 434
>
>
> Ah, yes that reminds me that when you take down a service and then
> start it again, you lose that nice low pid.  FWIW, my master is 23034
> now.  As D Ford stated, paying attention to pid value is not useful.

On a server which is anything but idle, 16bit pids cycle every 1 or 2
days. And many daemons do get restarted (syslog on RH systems), and they
do fork to perform their task (all from [x]inetd, sendmail, and the like).
PID means nothing, expecially when uptime > 100 days its pretty much a
random number (a lot of chances you already restarted almost everything,
unless your configuration is *very* stable).

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

