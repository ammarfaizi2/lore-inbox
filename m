Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317648AbSHHQpi>; Thu, 8 Aug 2002 12:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317649AbSHHQpi>; Thu, 8 Aug 2002 12:45:38 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:32142 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317648AbSHHQph>; Thu, 8 Aug 2002 12:45:37 -0400
Date: Thu, 8 Aug 2002 11:49:05 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Peter Samuelson <peter@cadcamlab.org>
cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>, <linux-kbuild@lists.sourceforge.net>
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
In-Reply-To: <20020808151432.GD380@cadcamlab.org>
Message-ID: <Pine.LNX.4.44.0208081142390.23063-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, Peter Samuelson wrote:

> [Andi Kleen]
> > I don't see why it is unmaintainable. What is so bad with these ifs?
> > 64bit cleanness is just another dependency, nothing magic and fundamentally
> > hard.
> [...]
> > (unfortunately there is no dep_tristate ... !$CONFIG_64BIT)
> > Alternatively CONFIG_NO_64BIT to work around this issue.
> 
> The real solution (imo) is to add !$CONFIG_FOO support to the config
> language.  Fortunately this is quite easy.  What do you people think?
> I didn't do xconfig or config-language.txt but I can if desired.

As you're hacking Configure anyway, what about "fixing"

	dep_tristate ' ..' CONFIG_FOO $CONFIG_BAR,

which doesn't work as expected when CONFIG_BAR is not set (as opposed to 
"n"), to consider an unset CONFIG_BAR equivalent to "n" in this case?

(The rather hacky way I'd imagine to do so is to look at all used 
$CONFIG_* in a Config.in file before sourcing it and setting them to "n")

--Kai

