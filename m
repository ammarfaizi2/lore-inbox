Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWGaWRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWGaWRW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 18:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWGaWRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 18:17:21 -0400
Received: from mail.gmx.de ([213.165.64.21]:30159 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751409AbWGaWRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 18:17:21 -0400
X-Authenticated: #428038
Date: Tue, 1 Aug 2006 00:17:16 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060731221716.GA16440@merlin.emma.line.org>
Mail-Followup-To: Rudy Zijlstra <rudy@edsons.demon.nl>,
	Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
	ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
	jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
References: <1153760245.5735.47.camel@ipso.snappymail.ca> <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl> <20060731125846.aafa9c7c.reiser4@blinkenlights.ch> <20060731144736.GA1389@merlin.emma.line.org> <20060731175958.1626513b.reiser4@blinkenlights.ch> <20060731162224.GJ31121@lug-owl.de> <Pine.LNX.4.64.0607311842120.13492@nedra.edsons.demon.nl> <20060731173239.GO31121@lug-owl.de> <20060731181120.GA9667@merlin.emma.line.org> <20060731184314.GQ31121@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731184314.GQ31121@lug-owl.de>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw schrieb am 2006-07-31:

> > Massive hardware problems don't count. ext2/ext3 doesn't look much better in
> > such cases. I had a machine with RAM gone bad (no ECC - I wonder what
> 
> They do! Very much, actually. These happen In Real Life, so I have to
> pay attention to them. Once you're in setups with > 10000 machines,
> everything counts. At some certain point, you can even use HDD's
> temperature sensors in old machines to diagnose dead fans.
> 
> Everything that eases recovery for whatever reason is something you
> have to pay attention to. The simplicity of ext{2,3} is something I
> really fail to find proper words for. As well as the really good fsck.
> Once seen a SIGSEGV'ing fsck, you really don't want to go there.

The point is: If you've written data with broken hardware (RAM, bus,
controllers - loads of them, CPU), what is on your disks is
untrustworthy anyways, and fsck isn't going to repair your gzip file
where every 64th bit has become a 1 or when the battery-backed write
cache threw 60 MB down the drain...

Of course, an fsck that crashes is unbearable, but that doesn't apply to
"broken hardware" failures. You need backups with a few generations to
avoid massively losing data.

-- 
Matthias Andree
