Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVIBLpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVIBLpA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 07:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVIBLpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 07:45:00 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:65199 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S1751153AbVIBLo7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 07:44:59 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-mm1: swsusp problem (was: PCMCIA problem)
Date: Fri, 2 Sep 2005 13:45:13 +0200
User-Agent: KMail/1.8.2
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
References: <20050901035542.1c621af6.akpm@osdl.org> <20050902104319.GB9647@elf.ucw.cz> <20050902040926.6e02c4e8.akpm@osdl.org>
In-Reply-To: <20050902040926.6e02c4e8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509021345.14168.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 2 of September 2005 13:09, Andrew Morton wrote:
> Pavel Machek <pavel@suse.cz> wrote:
> >
> > > One more piece of information.  This is the one that loops:
> >  > 
> >  > echo 30 > /sys/class/firmware/timeout
> > 
> >  Try echo -n ...
> 
> Or revert gregkh-driver-sysfs-strip_leading_trailing_whitespace.patch. 
> Obviously if you write 30\n and the write returns 2 then the shell will
> then try to write the \n.  That returns zero and the shell tries again, ad
> infinitum.
> 
> Rant.  It took me two full days to weed out and fix all the crap people
> sent me to get -mm1 into a state where it vaguely compiled and booted.  And
> it's untested nonsense like this which wrecks the whole effort for many
> testers.
> 
> I suppose this is as good as anything....

Thanks for the fix. :-)

Now, (using the fact that Pavel already is in the CC list ;-)) there's another
issue I have with swsusp, which is broken in a funny way.  Namely, after
resuming from disk the box immediately goes into standby from which it
can be woken up by pressing the power button, but then it oopses,
goes into standby (or something similar) again, and hangs solid (unfortunately
I can't get the traces right now).

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
