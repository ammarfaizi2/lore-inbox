Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbTIOVGW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbTIOVGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:06:22 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:50442 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261622AbTIOVGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:06:18 -0400
Date: Mon, 15 Sep 2003 23:06:06 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Tom Rini <trini@kernel.crashing.org>
cc: Norman Diamond <ndiamond@wta.att.ne.jp>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.6.0-test5: serio config broken?
In-Reply-To: <20030915144939.GA29517@ip68-0-152-218.tc.ph.cox.net>
Message-ID: <Pine.LNX.4.44.0309152136110.19512-100000@serv>
References: <1aba01c379d0$4d061ab0$2dee4ca5@DIAMONDLX60>
 <20030915144939.GA29517@ip68-0-152-218.tc.ph.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 15 Sep 2003, Tom Rini wrote:

> > If neither is selected, then the problem is essentially the same as the one
> > which Mr. Rini pointed out.  And again there are other possible
> > possibilities such as n, n, n, n.
> > 
> > Solution:  Surely plain "make" could start by checking dependencies.  Or
> > maybe "make dep" could be reincarnated.  If there is any inconsistency, then
> > the Makefile could issue an error and refuse to start compiling.
> > 
> > This has the added benefit that if the human has some reason to edit the
> > .config file by hand instead of using a make [...]config command, plain
> > "make" will have a chance of catching editing errors.
> > 
> > This doesn't automate a solution as thoroughly as either of you were hoping
> > for; it honestly admits that it can't read the human's mind  :-)
> 
> Yes, even that would work quite nicely, perhaps while saying what the
> specific problem is as well.  Roman, how hard would this be to do?

The check happens already and it will ask for any missing option.
You have to define what "inconsistency" means, right now the kconfig 
design makes ambigous configurations impossible (provided that there are 
no recursive dependencies, which kconfig warns about). I have no plans to 
give up this property, as it keeps kconfig reasonably simple, it's already 
complex enough as is.

bye, Roman

