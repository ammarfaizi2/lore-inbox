Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264571AbSIQTyj>; Tue, 17 Sep 2002 15:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264572AbSIQTyj>; Tue, 17 Sep 2002 15:54:39 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:33983 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S264571AbSIQTyh>; Tue, 17 Sep 2002 15:54:37 -0400
Date: Tue, 17 Sep 2002 14:59:17 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Sam Ravnborg <sam@ravnborg.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.35 make race?
In-Reply-To: <20020917184218.A3625@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0209171456570.19512-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2002, Sam Ravnborg wrote:

> On Tue, Sep 17, 2002 at 05:33:45PM +1000, Rusty Russell wrote:
> > Hi Kai,
> > 
> > 	First make -j3 on a 2-way SMP box fails.  The second one
> > succeeds.  I think a dependency is missing?
> 
> Yep, "if_changed_dep" uses fixdep, so a dependency to scripts is needed.
> Added echo_target as well, so the result file is printed as well.

Yes, that's true, and your patch is correct.

Still, I'm not quite happy with having the .S -> .s rule duplicated 
between Makefile and Rules.make, if I figure out a way to use the 
Rules.make one, this fixdep problem should go away as well.

--Kai


