Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbTIOVU2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbTIOVU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:20:28 -0400
Received: from fed1mtao07.cox.net ([68.6.19.124]:17325 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S261601AbTIOVUR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:20:17 -0400
Date: Mon, 15 Sep 2003 14:20:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Norman Diamond <ndiamond@wta.att.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.0-test5: serio config broken?
Message-ID: <20030915212015.GA9102@ip68-0-152-218.tc.ph.cox.net>
References: <1aba01c379d0$4d061ab0$2dee4ca5@DIAMONDLX60> <20030915144939.GA29517@ip68-0-152-218.tc.ph.cox.net> <Pine.LNX.4.44.0309152136110.19512-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309152136110.19512-100000@serv>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 11:06:06PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 15 Sep 2003, Tom Rini wrote:
> 
> > > If neither is selected, then the problem is essentially the same as the one
> > > which Mr. Rini pointed out.  And again there are other possible
> > > possibilities such as n, n, n, n.
> > > 
> > > Solution:  Surely plain "make" could start by checking dependencies.  Or
> > > maybe "make dep" could be reincarnated.  If there is any inconsistency, then
> > > the Makefile could issue an error and refuse to start compiling.
> > > 
> > > This has the added benefit that if the human has some reason to edit the
> > > .config file by hand instead of using a make [...]config command, plain
> > > "make" will have a chance of catching editing errors.
> > > 
> > > This doesn't automate a solution as thoroughly as either of you were hoping
> > > for; it honestly admits that it can't read the human's mind  :-)
> > 
> > Yes, even that would work quite nicely, perhaps while saying what the
> > specific problem is as well.  Roman, how hard would this be to do?
> 
> The check happens already and it will ask for any missing option.
> You have to define what "inconsistency" means, right now the kconfig 
> design makes ambigous configurations impossible (provided that there are 
> no recursive dependencies, which kconfig warns about). I have no plans to 
> give up this property, as it keeps kconfig reasonably simple, it's already 
> complex enough as is.

So long as it doesn't involve 'select', it won't let you be
inconsistent, yes.  How exactly are items that come in from a select
evaluated right now?

-- 
Tom Rini
http://gate.crashing.org/~trini/
