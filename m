Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbUAaXgS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 18:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbUAaXgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 18:36:18 -0500
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:46737 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S265170AbUAaXgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 18:36:16 -0500
Date: Sat, 31 Jan 2004 15:35:51 -0800
From: Jim McCloskey <mcclosk@ucsc.edu>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: net-pf-10, 2.6.1
Message-ID: <20040131233551.GA660@toraigh>
References: <E1AmU8a-00005E-00@localhost> <Pine.LNX.4.44.0401301532260.9270-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401301532260.9270-100000@gaia.cela.pl>
X-Operating-System: Linux/2.4.23-ck1 (i686)
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Russell King (rmk+lkml@arm.linux.org.uk) wrote:  

  |>  On Fri, Jan 30, 2004 at 12:36:28AM -0800, jim wrote: 
  |>  > Is there any guidance about this little annoyance yet? Most of
  |>  > the advice I've seen (on other lists) suggests putting the
  |>  > following in modprobe.conf:                
  |>  >                                
  |>  >    install net-pf-10 /bin/true          
  |>                                    
  |>  You want:  
  |>                         
  |>    alias net-pf-10 off     
                             
* Maciej Zenczykowski <maze@cela.pl> wrote:
  
  |> try   
  |>              
  |> "alias net-pf-10 off" in /etc/modules.conf 

* Greg Norris wrote:

  |> Did you run "update-modules" afterward?

Thank you all for helping. I'm sorry I didn't make clear initially
that this (aliasing net-pf-10 to off) was the first thing I tried. I
resorted to Google when it didn't work. I've tried it again but the
error-messages continue.  /lib/modules/modprobe.conf now has:

-rw-r--r--    1 root     root         7341 Jan 30 15:26 modprobe.conf

   alias net-pf-1  unix
   alias net-pf-2  ipv4
   alias net-pf-3  ax25
   alias net-pf-4  ipx
   alias net-pf-5  appletalk
   alias net-pf-6  netrom
   alias net-pf-7  bridge
   alias net-pf-8  atm
   alias net-pf-9  x25
   alias net-pf-10 off
   alias net-pf-11 rose
   alias net-pf-12 decnet

and contains no other reference to net-pf-10. But still:

Jan 31 14:53:01 ohlone /USR/SBIN/CRON[1092]: (mail) CMD (  if [ -x /usr/lib/exim/exim3 -a -f /etc/exim/exim.conf ]; then /usr/lib/exim/exim3 -q ; fi)
Jan 31 14:53:01 ohlone kernel: request_module: failed /sbin/modprobe -- net-pf-10. error = 256

for every time exim runs.

Others have reported the same effect, e.g:

http://linuxfromscratch.org/pipermail/lfs-hackers/2004-January/000297.html

This didn't happen in 2.6.0 (or earlier).

This is a very small problem indeed, of course. It's just weird ...

Jim
