Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbSJIRLf>; Wed, 9 Oct 2002 13:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261882AbSJIRLf>; Wed, 9 Oct 2002 13:11:35 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:62472 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261854AbSJIRLc>;
	Wed, 9 Oct 2002 13:11:32 -0400
Date: Wed, 9 Oct 2002 19:16:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
Message-ID: <20021009191600.A1708@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kbuild-devel <kbuild-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44.0210081830350.4396-100000@home.transmeta.com> <Pine.LNX.4.44.0210091243240.338-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210091243240.338-100000@serv>; from zippel@linux-m68k.org on Wed, Oct 09, 2002 at 02:01:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 02:01:50PM +0200, Roman Zippel wrote:

> On Tue, 8 Oct 2002, Linus Torvalds wrote:
> > Some things made me go eww (but on the whole details):
> >
> >  - I'd prefer the Config.in name, since this has nothing to do with
> >    building, and everything to do with configuration.

Another suggestion about naming:
Take for example drivers/net:
cat Config.* | wc => 2149 lines

A bit a structure could be needed here.
Net.conf  <= Name equals directory with upper-case first letter
	- Cover the whole directory, and either implicit
	  or explicit include other .conf files in that directory
3c5xx.conf <= All the configuration for the 3c5xxx chipset drivers
rrunner.conf <= All configuration for rrunner driver

So letting the naming convention be directory name with upper-case start
letter - as the entry to a directory.
Additional configuration in sensibly named configuration files.
I do not see the split of configuration happen before 2.6, except in 
some special cases though. But I wanted to let the naming convention
support that.

source statements could look like:
source driver/net  <= since Net.conf is implicit
But I would prefer the files spelled out. 

> On Tue, 8 Oct 2002, Linus Torvalds wrote:
> >  - I assume that the scripts are generated from the current Config.in
> >    and Config.help files, and it would make me slightly happier to see the
> >    diff as a "automatic script" + "diff to fix it up", just for doc
> >    purposes.
> 
> All this is in the archive.

Keep both versions please. It's much easier just to apply a patch,
but I see why Linus ask for the other solution.
I know what version has preference ;-)

	Sam
