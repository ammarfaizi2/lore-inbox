Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130543AbQKGQNV>; Tue, 7 Nov 2000 11:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130209AbQKGQNL>; Tue, 7 Nov 2000 11:13:11 -0500
Received: from conr-adsl-dhcp-net2-3.txucom.net ([207.70.168.3]:4934 "EHLO
	synergy.linux-help.org") by vger.kernel.org with ESMTP
	id <S130004AbQKGQM7>; Tue, 7 Nov 2000 11:12:59 -0500
Date: Tue, 7 Nov 2000 10:15:35 -0600
From: Bill West <wingman@nospamsynergy.linux-help.org>
To: linux-kernel@vger.kernel.org
Subject: Re: pppd and 2.4.0pre10
Message-ID: <20001107101535.A15731@synergy.linux-help.org>
In-Reply-To: <Pine.LNX.4.21.0011041757570.32560-100000@tahallah.clara.co.uk> <3A05E5B1.F3E1CA09@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A05E5B1.F3E1CA09@eyal.emu.id.au>; from livid@eyal.emu.id.au on Mon, Nov 06, 2000 at 09:56:49AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2000 at 09:56:49AM +1100, Eyal Lebedinsky wrote:
> Alex Buell wrote:
> > 
> > tahallah[alex]:/home/alex > ppp-on
> > 
> > tahallah[alex]:/home/alex > /usr/sbin/pppd: This system lacks kernel
> > support for PPP.  This could be because the PPP kernel module could not be
> > loaded, or because PPP was not included in the kernel configuration.  If
> > PPP was included as a module, try `/sbin/modprobe -v ppp'.  If that fails,
> 
> I have something different with ppp on 2.4.0-test10. I very often get
> the ppp link up, I can ping the ISP end of the connection, but nothing
> else. All the pppd messages look just fine coming up.
> 

And something even more different. Dialin ppp connections to my 2.4.pre10
box with pppd version 2.4.0 is successful but uses all available CPU
resources. Load avg's stay around 1.5 with just pppd using resources.

excerpt from top:

107 processes: 104 sleeping, 3 running, 0 zombie, 0 stopped
CPU states:  99.4% user,   0.6% system,   0.0% nice,   0.0% idle
Mem:  255632K av, 238360K used,  17272K free,      0K shrd,   9052K buff
Swap: 191480K av,      0K used, 191480K free                 89068K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
15493 root      18   0   996  996   832 R       0 98.8  0.3  20:48 pppd


This is a dialin and not a dialout connection.


remove nospam to reply directly
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
