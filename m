Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbUAEXEW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbUAEXEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:04:07 -0500
Received: from sole.infis.univ.trieste.it ([140.105.134.1]:18561 "EHLO
	sole.infis.univ.trieste.it") by vger.kernel.org with ESMTP
	id S265993AbUAEXDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:03:06 -0500
Date: Mon, 5 Jan 2004 23:59:54 +0100
From: Andrea Barisani <lcars@infis.univ.trieste.it>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.0, wrong Kconfig directives
Message-ID: <20040105225954.GA9382@sole.infis.univ.trieste.it>
References: <20031222235622.GA17030@sole.infis.univ.trieste.it> <20040105221732.GG10569@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105221732.GG10569@fs.tum.de>
X-GPG-Key: 0x864C9B9E
X-GPG-Fingerprint: 0A76 074A 02CD E989 CE7F  AC3F DA47 578E 864C 9B9E
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 11:17:32PM +0100, Adrian Bunk wrote:
> On Tue, Dec 23, 2003 at 12:56:23AM +0100, Andrea Barisani wrote:
> > 
> > Hi folks,
> 
> Hi Andrea,

Hi!

> 
> > Installing 2.6.0 I've found that some kernel options directives are wrong,
> > in fact the option turns out to be always enabled. I don't think this is 
> > a desired behaviour.
> > 
> > Sorry for the format, yes I know it's ugly :) but I'll leave to you the proper 
> > solution :) so I can't make a proper patch.
> > 
> > 
> > - IPV6_SCTP___ option is always turned on
> > 
> > ./net/sctp/Kconfig:
> > 
> > 8:  config IPV6_SCTP__
> > 9: 	    tristate
> > 10:         default y if IPV6=n
> > 11:	    default IPV6 if IPV6
> > 12:
> > 13: config IP_SCTP
> > 14:	    tristate "The SCTP Protocol (EXPERIMENTAL)"
> > 15:	    depends on IPV6_SCTP__
> > 
> > 
> > I think something is wrong here, why the 'default y if IPV6=n' ???
> 
> 
> It's ___ugly___ but designed this way...
> 
> The whole purpose of IPV6_SCTP__ is to disallow static IP_SCTP with
> modular IPV6.

Ok, so it's actually a "dummy" config with not linked with real code. A
simple grep suggest that. If so I won't complain again, now it's clear ;)

However it's really ___ugly___ ;)

> 
> These EMBEDDED are there to help people not to accidentially disable 
> these options although they might require them.

Ok that's fine, however I personally think this should be documented in
EMBEDDED related options to let people know how they can disable them.

And I really think that MOUSEDEV should not be considered a 'not-standard'
option. It's quite common disabling MOUSE support on servers, terminals and
so on. :)

> cu
> Adrian

Bye and thanks

--
------------------------------------------------------------
INFIS Network Administrator & Security Officer         .*. 
Department of Physics       - University of Trieste     V 
lcars@infis.univ.trieste.it - GPG Key 0x864C9B9E      (   )
----------------------------------------------------  (   )
"How would you know I'm mad?" said Alice.             ^^-^^
"You must be,'said the Cat,'or you wouldn't have come here."
------------------------------------------------------------
