Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272060AbRHVReo>; Wed, 22 Aug 2001 13:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272056AbRHVRei>; Wed, 22 Aug 2001 13:34:38 -0400
Received: from wks121.navicsys.com ([207.180.73.121]:46284 "EHLO noop.")
	by vger.kernel.org with ESMTP id <S272055AbRHVReb>;
	Wed, 22 Aug 2001 13:34:31 -0400
To: linux-kernel@vger.kernel.org
Cc: acpi@phobos.fachschaften.tu-muenchen.de
Subject: AGP support locks X  kernel v2.4.9
In-Reply-To: <XFMail.20010818013001.bmihulka@hulkster.net>
From: Nick Papadonis <nick@coelacanth.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Content-Type: text/plain; charset=US-ASCII
Date: 22 Aug 2001 13:31:05 -0400
In-Reply-To: <XFMail.20010818013001.bmihulka@hulkster.net> (bmihulka@hulkster.net's message of "Sat, 18 Aug 2001 01:30:01 -0500 (CDT)")
Message-ID: <m3pu9oovc6.fsf@coelacanth.com>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New information:

I tried compiling agp support and the i810 DRI as modules for kernel v2.4.9.
X exits out with:

(II) I810(0): Buffer map : bfb000
(II) I810(0): [drm] added 256 4096 byte DMA buffers
I810 Dma Initialization Failed


When recompiling the v2.4.8 kernel with the same configuration, X
starts fine.

I wonder what the delta between the two is?

- Nick

bmihulka@hulkster.net writes:

> I did experience this.  But when you choose AGP as a module it disables
> the drm of the i810.  I then added it back as a module and the X server would
> not work.  Without the i810 drm module it will work.  I did not test AGP in the
> kernel without the drm module, which may work.
> 
> On a side note the 2.4.5 kernels acpi implimentation will show the correct
> battery and ac adaptor status.  The stock kernels after that will not without
> the new acpi patches.  I have also had the problem of a shutdown will lock the
> system and I have to pull the plug and battery to turn off.
> 
> Brian
> 
> On 18-Aug-2001 Nick Papadonis wrote:
> > This solved the problem.  Apparently AGP has to be built as a module
> > in kernels v2.4.8 or X will lock up?  Anyone else experience this?
> > 
> >> I'm not sure that this is the problem you are having,
> >> but I had a problem with X when I was playing with the
> >> ACPI stuff and recompiling the kernel on my vaio. Try 
> >> setting CONFIG_AGP=m (i.e. make AGP support a module,
> >> as opposed to being compiled in-kernel.) if it isn't. 
> >> Once I did that, X started up just fine. Good luck.
> >> 
> >> Dave
> > 
> > 
> > Dave Morgan <daves_spam_account@yahoo.com> writes:
> >> >> I tried this and it doesn't disable the console. 
> >> The /proc/acpi
> >> >> represents the correct power status.  When I tried
> >> to
> >> >> start up X the following error occurs:
> >> >> 
> >> >> I810 Dma Initialization Failed
> >> >> XIO:  fatal IO error 104 (Connection reset by peer)
> >> >on X server 
> >> >":0.0"
> >> >>       after 0 requests (0 known processed) with 0
> >> >events remaining.
> >> >> 
> >> >> So the work around must break something else?
> >> 
> >> >Follup:  
> >> 
> >> >This isn't because of the ACPI code.  It's something
> >> >that happens in
> >> >my 2.4.8 kernel wo ACPI compiled in.  This behavior
> >> is >not shown with
> >> >the 2.2.16 kernel.

-- 
Nick
