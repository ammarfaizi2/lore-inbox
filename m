Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbUJ3Vdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbUJ3Vdw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 17:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbUJ3Vdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 17:33:52 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:53517 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261335AbUJ3Vds
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 17:33:48 -0400
Date: Sun, 31 Oct 2004 01:34:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: kbuild (was Re: Versioning of tree)
Message-ID: <20041030233437.GF9592@mars.ravnborg.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <1098254970.3223.6.camel@gaston> <1098256951.26595.4296.camel@d845pe> <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org> <4177E8A0.2090508@pobox.com> <Pine.LNX.4.58.0410211005320.2171@ppc970.osdl.org> <41784034.9050107@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41784034.9050107@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 07:03:16PM -0400, Jeff Garzik wrote:
> Linus Torvalds wrote:
> >We already have the concept of "localversion*" files that get appended to 
> >the build.[...]
> 
> 
> Just to tangent a bit...  I've been meaning to throw out a public kudos 
> to Sam, Kai, Roman and the other kbuild/kconfig hackers.  The 2.6 kbuild 
> and kconfig system is a _huge_ improvement over 2.4.x.

Thanks :-)
Kai and Roman have taken the big steps here!

> 
> These days I use
> 	echo "-sataN" > localversion
> heavily, and it's been quite helpful.  The separation of src/obj 
> directories, the default verbosity level, 'make allyesconfig', and the 
> elimination of recursive Makefile invocations are just some of the 
> things that stick out as positive improvements that impact me on a daily 
> basis.

The recursive Makefile invocations are still present. But just
working better than before.
I would like to write a small parser to generate one Makefile
for the kernel stuff but dunno when I will find time for it.
Main driver would be to increase speed when building a single
file. But it will also simplify building modules avoiding
the synchronization point we have before entering modpost stage.

	Sam
