Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUFUWjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUFUWjV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 18:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266502AbUFUWiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 18:38:08 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:35668 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266516AbUFUWg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 18:36:29 -0400
Date: Tue, 22 Jun 2004 00:48:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
Subject: Re: [PATCH 0/2] kbuild updates
Message-ID: <20040621224813.GF2903@mars.ravnborg.org>
Mail-Followup-To: Martin Schlemmer <azarah@nosferatu.za.org>,
	Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kai Germaschewski <kai@germaschewski.name>
References: <20040620211905.GA10189@mars.ravnborg.org> <1087767034.14794.42.camel@nosferatu.lan> <20040620220319.GA10407@mars.ravnborg.org> <20040620221824.GA10586@mars.ravnborg.org> <1087770318.14794.76.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087770318.14794.76.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 12:25:18AM +0200, Martin Schlemmer wrote:
> On Mon, 2004-06-21 at 00:18, Sam Ravnborg wrote:
> > On Mon, Jun 21, 2004 at 12:03:19AM +0200, Sam Ravnborg wrote:
> > > If I get just one good example I will go for the object directory, but
> > > what I have seen so far is whining - no examples.
> > 
> > Now I recall why I did not like the object directory.
> > I will break all modules using the kbuild infrastructure!
> > 
> 
> Below do not really explain this - care to be more detailed?
> 
> > Why, because there is no way the to find the output directory except
> > specifying both directories.
> > One could do:
> > make -C /lib/modules/`uname -r`/source O=/lib/modules/`uname -r`/build M=`pwd`
> > 
> 
> Huh?  Explain to me how else you would do builds that have separate
> output directory?  And what is the difference from above to:
> 
> make -C /lib/modules/`uname -r`/build O=/lib/modules/`uname -r`/object M=`pwd`

Modules do not have O= specified.
And you did not address the issue with modules makefile grepping in src.

	Sam
