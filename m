Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265944AbUFOUx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265944AbUFOUx2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265947AbUFOUx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:53:27 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:20260 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S265944AbUFOUxZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:53:25 -0400
Date: Tue, 15 Jun 2004 23:02:40 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/5] kbuild
Message-ID: <20040615210240.GL2310@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040615154136.GD11113@smtp.west.cox.net> <20040615174929.GB2310@mars.ravnborg.org> <20040615175453.GD14528@smtp.west.cox.net> <20040615190119.GC2310@mars.ravnborg.org> <20040615192740.GF14528@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615192740.GF14528@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 12:27:40PM -0700, Tom Rini wrote:
> 
> What I don't see is why:
> 'znetboot - Build a zImage and put into /tftpboot/
>  uImage - Build an image for U-Boot
>  rom.img - Build an image to live on ROM
>  srec - Build an SREC image'
> 
> etc, isn't sufficient, in the archhelp.

Two things.
1) You better remember to specify them each and every time.
   Otherwise uImage gets out of sync with the kernel.
2) I know the srec format, but that is no help to expaling me
   the actual content of the file.
   Memory layout, start address or whatever. Where to find this info.
   Same goes for other targets. I you know your stuff no swaet.
   But for $random hacker it becomes another obstacle

 
> Or, you restrict their choices to what would work, which is a horrible
> mess.  And you may need to restrict the choices, otherwise we'll get
> 'allyesconfig' doesn't build type messages again (yes, I've already had
> to re-arrange things once for allyesconfig on ppc32).
> 
> > But for a given board I would expect the defconfig to select the correct
> > kernel image.
> 
> <nit>'correct' is such an odd word here.  Especially in the case where
> all of them are valid targets.</nit>

Read 'type of'. In most case zImage I assume, but in some case with a
bootloader added. The other options may vary (a lot).

	Sam
