Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129321AbQKGWVX>; Tue, 7 Nov 2000 17:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbQKGWVN>; Tue, 7 Nov 2000 17:21:13 -0500
Received: from dial-12-74-apx-01.btvt.together.net ([209.91.55.74]:40576 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S129321AbQKGWVH>; Tue, 7 Nov 2000 17:21:07 -0500
Date: Tue, 7 Nov 2000 17:20:42 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
To: Michael Kummer <frost@f00bar.net>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>,
        William Stearns <wstearns@pobox.com>
Subject: Re: need urgent help with 2.2.17 + ipchains
In-Reply-To: <Pine.LNX.4.30.0011072239150.31349-100000@warp4.lan-rockerz.net>
Message-ID: <Pine.LNX.4.21.0011071707500.1129-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon, Michael,
	(The linux-kernel mailing list is not really the best place for
userspace issues.  You should probably use the ipmasq list for future
questions.  See http://netfilter.kernelnotes.org/ipchains/ for the
ipchains homepage and http://ipmasq.cjb.net for info on that list.)

On Tue, 7 Nov 2000, Michael Kummer wrote:

> i have the following very nasty problem.
> everytime i execute ipchains -F [rule] my box freezes for 25 minutes!
> i run slackware on 2.2.17.
> 
> a friend of mine told me that he had a simliar problem and fixed it with
> downgrading shlibs.

	One other possibility is to make sure that all of your dns rules
are at the top of your firewall, and that those dns rules only use ip
addresses and networks ("-d 12.13.14.15" as opposed to "-d
dns1.myisp.net").
	To check which rule(s) is/are giving you heartache, go to the top
of your firewall script and add "set -x" as the second line, just under
"#!/bin/bash".  Bash will show each line before it is executed.  The lines
that sit there for two minutes are probably the ones that are having
trouble with dns lookups.

> -- CUT --
> Linux version 2.2.17 (root@gatekeeper) (gcc version egcs-2.91.66
> 19990314/Linux (egcs-1.1.2 release)) #2 Sun Sep 17 00:56:47 /e$Detected
> 166591 kHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 332.60 BogoMIPS
> Memory: 128092k/131072k available (1012k kernel code, 408k reserved, 1516k
> data, 44k init)

	Oh, that's way too much memory for a firewall.  Mail me half of
it. ;-)
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Bastard Operators from Hell" anagrams to "Shatterproof Armored Balls"
(Courtesy of Jens Benecke <jens@pinguin.conetix.de>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts, 
and ipfwadm2ipchains are at:                http://www.pobox.com/~wstearns
LinuxMonth; articles for Linux Enthusiasts! http://www.linuxmonth.com
--------------------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
