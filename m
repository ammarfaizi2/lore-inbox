Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRKNSe7>; Wed, 14 Nov 2001 13:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274789AbRKNSej>; Wed, 14 Nov 2001 13:34:39 -0500
Received: from 208-58-239-45.s45.tnt1.atnnj.pa.dialup.rcn.com ([208.58.239.45]:50158
	"EHLO trianna.2y.net") by vger.kernel.org with ESMTP
	id <S273261AbRKNSe3>; Wed, 14 Nov 2001 13:34:29 -0500
Date: Wed, 14 Nov 2001 13:32:36 -0500
From: Malcolm Mallardi <magamo@ranka.2y.net>
To: Wayne Whitney <whitney@math.berkeley.edu>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] pdc202xx.c, adds another quirk drive to the list
Message-ID: <20011114133236.A440@trianna.upcommand.net>
In-Reply-To: <20011113105543.A392@trianna.upcommand.net> <200111141724.fAEHO5102013@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111141724.fAEHO5102013@adsl-209-76-109-63.dsl.snfc21.pacbell.net>; from whitney@math.berkeley.edu on Wed, Nov 14, 2001 at 09:24:05AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 14, 2001 at 09:24:05AM -0800, Wayne Whitney wrote:
> In mailing-lists.linux-kernel, you wrote:
> 
> > I seem to recall when I once looked at the promise driver that there
> > was what appeared to be some form of exclusion list which included
> > several models of Quantum FireballP harddrives, but mine was not on
> > the list.
> >  
> > I suspected then (I think that was sometime around 2.4.9) that if I
> > added the drive to that list that it would work, but I never tried it,
> > due to the fact that I don't know C, and was afraid of breaking it
> > more. :)
> 
> OK, I'll help you try this, it is really dead easy:
> 
> In the kernel tree of your choice, go the directory drivers/ide.
> 
> Load pdc202xx.c in the editor of your choice.
> 
> 
> Recompile your kernel, try it out, and let us know if it works now.
> If it does, submit a patch.  See Documentation/SubmittingPatches, and
> ask me if that is not clear.
> 
> 

First off, I'd like to thank you, Wayne.  You've been a big help.
Attached is a patch that adds the Quantum FireballP KX27.3 harddrive to
the quirk_drives list in the Promise 202xx driver (pdc202xx.c) patches
is based off 2.4.15-pre1

Thanks folks, things work wonderfully now.

--
Malcolm D. Mallardi - Dark Freak At Large
"Captain, we are receiving two-hundred eighty-five THOUSAND hails."
AOL: Nuark  UIN: 11084092 Y!: Magamo Jabber: Nuark@jabber.com
http://ranka.2y.net/~magamo/index.htm

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

--- drivers/ide/pdc202xx.c.orig	Fri Nov  9 09:55:38 2001
+++ drivers/ide/pdc202xx.c	Wed Nov 14 12:52:05 2001
@@ -230,6 +230,7 @@
 	"QUANTUM FIREBALLP KA6.4",
 	"QUANTUM FIREBALLP LM20.4",
 	"QUANTUM FIREBALLP KX20.5",
+	"QUANTUM FIREBALLP KX27.3",
 	"QUANTUM FIREBALLP LM20.5",
 	NULL
 };

--wRRV7LY7NUeQGEoC--
