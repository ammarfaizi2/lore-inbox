Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132623AbRDKQ0a>; Wed, 11 Apr 2001 12:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132626AbRDKQ0U>; Wed, 11 Apr 2001 12:26:20 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28817 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132623AbRDKQ0J>;
	Wed, 11 Apr 2001 12:26:09 -0400
Date: Wed, 11 Apr 2001 12:26:08 -0400
From: nicholas black <dank@havoc.gtf.org>
To: linux-kernel@vger.kernel.org
Subject: ati mach64vt, atyfb.c, fbcon and black screens
Message-ID: <20010411122608.A26493@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'm running 2.4.3, and attempting to use the ati mach64 framebuffer
driver (atyfb.c) in place of the slooow vesa fb.  my card is an ati
mach64 vt4 according to lspci, claimed in atyfb.c line 555 to be
supported.  on startup, however, i get kernel decompression, followed
by a black screen.  it appears the boot sequence does not complete, as i
can't even ssh into the box, although the case may be that init is
hitting a point where it needs interaction somewhere.

i've compiled my kernel with:
	vga console
	vga mode selection support
	framebuffer->ati mach64 support,

all as builtins.  as explained in Documentation/fb/modedb.txt, the atyfb
driver is supported by modedb, and i've placed

append="video=atyfb:640x480"

in my lilo.conf.  it is probably worth noting that i also still have
vga=791 in my lilo.conf from the vesafb days; i'm considering that 
this (as it, for one, specifies a different resolution) may be the
culprit, but the box is at home.

any ideas?  if i simply need to rtfm, please direct me; i've been
searching for an answer to this since 2.2.

-- 
nicholas black  -=+=-  dank@gtf.org  -=+=-  http://www.angband.org/~dank/
  head developer, trellis network security   http://www.trellisinc.com/
"one of god's own prototypes, some kind of high-powered mutant never even
considered for mass-production...too weird to live, and too rare to die."
