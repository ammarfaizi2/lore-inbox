Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbSKRRSn>; Mon, 18 Nov 2002 12:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSKRRSn>; Mon, 18 Nov 2002 12:18:43 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:11535 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S263105AbSKRRSm>;
	Mon, 18 Nov 2002 12:18:42 -0500
Date: Mon, 18 Nov 2002 18:25:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Bill Davidsen <davidsen@tmr.com>, Sam Ravnborg <sam@ravnborg.org>,
       Nicolas Pitre <nico@cam.org>, Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
Message-ID: <20021118172517.GA6825@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Bill Davidsen <davidsen@tmr.com>, Sam Ravnborg <sam@ravnborg.org>,
	Nicolas Pitre <nico@cam.org>, Andreas Steinmetz <ast@domdv.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1021117024753.18748B-100000@gatekeeper.tmr.com> <Pine.LNX.4.44.0211181034100.24137-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211181034100.24137-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 10:36:20AM -0600, Kai Germaschewski wrote:
> But when do you need the "clean + rm .config*" behavior? I don't see that 
> to be such a common case.
> 
> That's why I think two targets are enough, "clean" to remove the files
> generated during the build and "distclean" to remove all other extra stuff
> to. And just keep mrproper to be an alias for distclean, since that's what
> "mrproper" traditionally was (AFAIK, Linus used it that way).

People are used to a mrproper that does NOT delete their editor
backup files and patch rejects. Thats the only arguments against
mrproper=distclean.

The main purpose should be to have a clear and logical
distingush between the two/three.
As it is today people are confused, and there is no consistency - 
especially between architectures.

I'm fine with a change that moves MRPROPER_{DIRS,FILES} to clean - except
.config.
But I'm not fine with the current situation where I have to say goodbye
to all my .rej files + xx~ files just to force a full recompile.

I will do a new patch tomorrow.

	Sam

