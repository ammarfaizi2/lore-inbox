Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266126AbTLIU0u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266125AbTLIU0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:26:34 -0500
Received: from chaos.analogic.com ([204.178.40.224]:10880 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266098AbTLIUXj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:23:39 -0500
Date: Tue, 9 Dec 2003 15:24:06 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Dominik Kubla <dominik@kubla.de>
cc: Stephen Satchell <list@satchell.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Swap performance statistics in 2.6 -- which /proc file has it?
In-Reply-To: <3FD62845.8090301@kubla.de>
Message-ID: <Pine.LNX.4.53.0312091520120.3865@chaos>
References: <BF1FE1855350A0479097B3A0D2A80EE00184D619@hdsmsx402.hd.intel.com>
  <1070911748.2408.39.camel@dhcppc4>  <3FD546D5.2000003@nishanet.com> 
 <1070975964.5966.5.camel@ssatchell1.pyramid.net>  <Pine.LNX.4.53.0312090854080.8425@chaos>
 <1070981185.6243.58.camel@ssatchell1.pyramid.net> <Pine.LNX.4.53.0312091014250.525@chaos>
 <3FD62845.8090301@kubla.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Dominik Kubla wrote:

> Richard B. Johnson wrote:
> > If you need statistics v.s. time, you need to write an application
> > that samples things at some fixed interval. In a previous life,
> > I requested that "nr_free_pages()" be accessible from user-space,
> > probably via /proc. That's all you need. Maybe that could be
> > added now?  In any event, samping free pages at some fixed-time
> > interval should give you all the information you need.
>
> vmstat -a
> sar -B
> sar -r
>
> O'Reilly's "System Performance Tuning" might make for an interesting read,
> especially pages 110ff (also its Linux informations are a bit out of date).
>
> Regards,
>    Dominik Kubla

Hmm. I was talking about real stuff, not some theory.....

Script started on Tue Dec  9 15:19:25 2003
# vmstat -a
usage: vmstat [-V] [-n] [delay [count]]
              -V prints version.
              -n causes the headers not to be reprinted regularly.
              delay is the delay between updates in seconds.
              count is the number of updates.
# sar -B
bash: sar: command not found
# sar -r
bash: sar: command not found
# exit
exit
Script done on Tue Dec  9 15:20:03 2003

Maybe it was a different system???

Script started on Tue Dec  9 15:21:24 2003
# rlogin hal
Password:
Last login: Tue Oct 28 12:00:38 on console
Sun Microsystems Inc.	SunOS 5.5.1	Generic	May 1996
# vmstat -a
Usage: vmstat [-cisS] [disk ...] [interval [count]]
# sar -B
sar: illegal option -- B
usage: sar [-ubdycwaqvmpgrkA][-o file] t [n]
	sar [-ubdycwaqvmpgrkA][-s hh:mm][-e hh:mm][-i ss][-f file]
# sar -r
sar: can't open /var/adm/sa/sa09
No such file or directory
# uname -a
SunOS hal 5.5.1 Generic sun4m sparc SUNW,SPARCstation-5
# exit
rlogin: connection closed.
# exit
exit
Script done on Tue Dec  9 15:22:32 2003

... Guess not.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


