Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTLEIfI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 03:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTLEIfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 03:35:08 -0500
Received: from mxsf05.cluster1.charter.net ([209.225.28.205]:9741 "EHLO
	mxsf05.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S263205AbTLEIfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 03:35:03 -0500
Date: Fri, 5 Dec 2003 03:33:49 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
Message-ID: <20031205083349.GA15152@forming>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031205045404.GA307@tesore.local> <16336.13962.285442.228795@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16336.13962.285442.228795@alkaid.it.uu.se>
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.6.0-test11-Jm i686
X-Uptime: 13:59:28 up 22:25,  8 users,  load average: 1.03, 1.05, 1.06
User-Agent: Mutt/1.5.4i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Fri, Dec 05, 2003 at 08:40:58AM +0100, Mikael Pettersson wrote:
> Jesse Allen writes:
>  > Hi,
>  > 
>  > I have a NForce2 board and can easily reproduce a lockup with grep on an IDE 
>  > hard disk at UDMA 100.  The lockup occurs when both Local APIC + IO-APIC are 
>  > enabled.  It was suggested to me to use NMI watchdog to catch it.  However, the 
>  > NMI watchdog doesn't seem to work.
>  > 
>  > When I set the kernel parameter "nmi_watchdog=1" I get this message in 
>  > /var/log/syslog:
>  > Dec  4 20:10:30 tesore kernel: ..MP-BIOS bug: 8254 timer not connected to 
>  > IO-APIC
>  > Dec  4 20:10:30 tesore kernel: timer doesn't work through the IO-APIC - 
>  > disabling NMI Watchdog!
>  > 
>  > "nmi_watchdog=2" seems to work at first, In /var/log/messages:
>  > Dec  4 20:13:11 tesore kernel: testing NMI watchdog ... OK.
>  > but it still locks up.
> 
> The NMI watchdog can only handle software lockups, since it relies on
> the CPU, and for nmi_watchdog=1 the I/O-APIC + bus, still running.
> Hardware lockups result in, well, hardware lockups :-(

So does this confirm that the lockups with nforce2 chipsets and apic
is actually a hardware problem after all? 
  
-- 
Josh McKinney		     |	Webmaster: http://joshandangie.org
--------------------------------------------------------------------------
                             | They that can give up essential liberty
Linux, the choice       -o)  | to obtain a little temporary safety deserve 
of the GNU generation    /\  | neither liberty or safety. 
                        _\_v |                          -Benjamin Franklin
