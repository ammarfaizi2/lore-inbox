Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTLCDR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 22:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbTLCDR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 22:17:59 -0500
Received: from h1ab.lcom.net ([216.51.237.171]:18566 "EHLO digitasaru.net")
	by vger.kernel.org with ESMTP id S264476AbTLCDR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 22:17:57 -0500
Date: Tue, 2 Dec 2003 21:17:51 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vanilla 2.6.0-test11 and CS4236 card
Message-ID: <20031203031749.GB27034@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
	linux-kernel@vger.kernel.org
References: <20031202170637.GD5475@digitasaru.net> <s5hsmk3ceia.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hsmk3ceia.wl@alsa2.suse.de>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I applied the patch and it worked beautifully.

THE GOOD NEWS:
--------------

The patch worked great; the problem (as you had very likely surmised)
  was that it wasn't being activated by the Plug-n-Play system, and so the
  card wasn't talking.  [Sorry; I am new to ISA programming (well, systems
  programming in general.  At least I learned some cool stuff]  After I had
  run isapnp on the module sans your patch, or rebooted with your patch,
  there was a big POP! and the card was detected and ready.  It even played
  music!

THE BAD NEWS:
-------------

Both times (with your patch and with isapnp), I had the following problems:
  a) xmms wouldn't talk straight to the card even after selecting the alsa
       output plugin
  b) I started esd (the alsa version) and then told xmms to talk to esd.
       It worked out well for a couple of seconds, but then it crashed
       (both with your patch and with the manually activated (isapnp) one)
       
       It crashed HARD.

       It crashed so hard that it wiped out some files, like apt, I presume
         when it was cleaning "orphans" in /; the net result is that my
	 box is semi-hosed, since things like tr and apt-get and route
	 are now full of '\0' characters instead of their actual contents.

Sound played for about a second, then the machine hung hard (I don't think
  that the Magic SysRq keys even did anything), and the last couple of
  tenths of a second of sound just repeated over and over and over until
  I hit reset.  I don't have an oops; it was highly hosed.

When I can pull my system back together, I can try again.  Please help
  me find this new bug, so that the cs4236 driver is safe for other
  Dell P410 users!  :)

-Joseph

-- 
Joseph===============================================trelane@digitasaru.net
"Asked by CollabNet CTO Brian Behlendorf whether Microsoft will enforce its
 patents against open source projects, Mundie replied, 'Yes, absolutely.'
 An audience member pointed out that many open source projects aren't
 funded and so can't afford legal representation to rival Microsoft's. 'Oh
 well,' said Mundie. 'Get your money, and let's go to court.' 
Microsoft's patents only defensive? http://swpat.ffii.org/players/microsoft
