Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264047AbTFCT5p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 15:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTFCT5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 15:57:44 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:61845 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id S264047AbTFCT5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 15:57:42 -0400
Date: Tue, 3 Jun 2003 21:06:29 +0100
From: Stig Brautaset <stig@brautaset.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange dependancy generation bug?
Message-ID: <20030603200629.GA30842@brautaset.org>
References: <fa.er84418.1ikmjqq@ifi.uio.no> <fa.hfbafvn.n7qkih@ifi.uio.no> <20030603191154.GA30323@brautaset.org> <20030603195651.GA17845@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030603195651.GA17845@mars.ravnborg.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 03 2003, Sam wrote:
> On Tue, Jun 03, 2003 at 08:11:54PM +0100, Stig Brautaset wrote:
> > > What happens is that within Makefile.build there is used multi line
> > > definition, where each new-line causes make to launch a new sub-shell.
> > > The command for the second sub-shell is echoed, even though make is told
> > > not to do so. 
> > 
> > I beg to differ. Since make launches a new subshell, the commands in the
> > second subshell is _not_ told to shut up, and thus is echoed. No?
> 
> In make a so-called "canned command sequence" is generated.
> Quote from 'info make':
> 
> 	On the other hand, prefix characters on the command line that refers
> 	to a canned sequence apply to every line in the sequence.  So the rule:
> 
> 	     frob.out: frob.in
>         	     @$(frobnicate)
> 
> 	does not echo _any_ commands.
> 
> 
> In kbuild this is exactly what happens.
> So according to make info the command for the second sub-shell should not
> be echoed.

Indeed. It seem I haven't read the docs carefully enough. I was just
looking at cause and effect -- not how it's _supposed_ to work. ;) 

Here, with two subshells, the latter part is echoed, with one it is not. 
However, in the light of this (to me) new information I'm at a loss as
to what causes this to happen.

Stig
-- 
brautaset.org
