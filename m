Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265863AbTLIOSt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 09:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265864AbTLIOSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 09:18:49 -0500
Received: from mother.ds.pg.gda.pl ([153.19.213.213]:61841 "HELO
	mother.ds.pg.gda.pl") by vger.kernel.org with SMTP id S265863AbTLIOSk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 09:18:40 -0500
Date: Tue, 9 Dec 2003 15:18:37 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: sensors vs 2.6
Message-ID: <20031209141837.GA29636@irc.pl>
Mail-Followup-To: Tomasz Torcz <zdzichu@irc.pl>,
	LKML <linux-kernel@vger.kernel.org>
References: <200312090258.01944.gene.heskett@verizon.net> <m3zne21dsw.fsf@toyland.sauerland.de> <200312090741.31290.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312090741.31290.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 07:41:31AM -0500, Gene Heskett wrote:
> So obviously something didn't get built, and it looks like its the 
> winbond stuff.  The question is why?  Is there some method that can 
> be used to interrogate the kernel and determine if the stuff is 
> actually in there?

Maybe related: via sensors stuff is very picky about order of module
loading.
It does NOT work when i2c-dev, i2c-algo-bit and rest of sensors stuff
(isa bus, via modules) are built INTO kernel.
When everything is in modules, iw works ONLY when via modules are
modprobed _before_ anything using i2c.
Loading other i2c modules (bttv, lirc or sth else) before via modules
makes sensors unusable - there is no /sys/[...]/via directory,
or this directory is empty.

 
-- 
Tomasz Torcz                "Funeral in the morning, IDE hacking 
zdzichu@irc.-nie.spam-.pl    in the afternoon and evening." - Alan Cox 
|> Playing: stream1.jungletrain.net:8000 ...
