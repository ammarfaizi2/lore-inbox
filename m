Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbTLVWwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 17:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbTLVWwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 17:52:47 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:63958 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S264538AbTLVWwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 17:52:05 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Ville Herva <vherva@niksula.hut.fi>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: lot of VM problem with 2.4.23
Date: Mon, 22 Dec 2003 17:52:01 -0500
User-Agent: KMail/1.5.1
References: <20031221150312.GJ25043@ovh.net> <20031222183554.GN6438@matchmail.com> <20031222211247.GL1455@niksula.cs.hut.fi>
In-Reply-To: <20031222211247.GL1455@niksula.cs.hut.fi>
Organization: Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312221752.01730.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.60.44] at Mon, 22 Dec 2003 16:52:04 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 December 2003 16:12, Ville Herva wrote:
>On Mon, Dec 22, 2003 at 10:35:54AM -0800, you [Mike Fedyk] wrote:
>> > I don't know if there is a kernel memory leak, since all user
>> > level processes should be killed at that point, right?
>> > Unfortunately I didn't have time to dig deeper, as the box is in
>> > (sort of) production.
>>
>> Maybe, it depends on your init scripts.  Does your distribution do
>> a kill -9 of all processes before turning off swap?
>
>(It's a 7.0 Red Hat).
>
>It does
>   runcmd "Sending all processes the KILL signal..."  /sbin/killall5
> -9 before
>   [ -n "$SWAPS" ] && runcmd "Turning off swap: " swapoff $SWAPS
>in /etc/rc6.d/S01reboot and I've seen the "Sending all processes the
> KILL signal..." message appear before the memory freeing loop
> starts rolling.

If its a pristine rh7.0 install, that version of bind has a notorious 
rootkit hole.  So I wonder if the machine has been kitted by some 
script kiddie whose good at covering his tracks but not the rest of 
the housekeeping.  Do a google search for "chkrootkit", and install 
it to get a better view of that possibility.

An OS upgrade does seem to be in order, lots has happened since 7.0.  
7.3 with an updated kernel is my firewall, uptime is about 95 days 
now.  It was shut down while I was out of state for a couple of 
months last fall.  RH8.0 on this machine, with the real KDE-3.1.1a, 
but since RH is gonna force a switch, debian may be the next thing 
installed here.  Or maybe Mepis since he's only 50 miles up the 
interstate from me. :)


>-- v --
>
>v@iki.fi
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

