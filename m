Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286100AbRLJARn>; Sun, 9 Dec 2001 19:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286108AbRLJARd>; Sun, 9 Dec 2001 19:17:33 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:35338 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S286100AbRLJARX>; Sun, 9 Dec 2001 19:17:23 -0500
Date: Sun, 9 Dec 2001 21:00:59 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Roman Zippel <zippel@linux-m68k.org>, Rene Rebe <rene.rebe@gmx.net>,
        linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] 
 /ALSA-0.9.0beta[9,10]
In-Reply-To: <200112100011.fBA0Bbu14224@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.21.0112092059550.24440-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Dec 2001, Richard Gooch wrote:

> Marcelo Tosatti writes:
> > 
> > 
> > On Sun, 9 Dec 2001, Roman Zippel wrote:
> > 
> > > Hi,
> > > 
> > > Richard Gooch wrote:
> > > 
> > > > There are some broken boot scripts (modelled after the long obsolete
> > > > rc.devfs script)
> > > 
> > > Which is still included in the kernel tree and at least Mandrake is
> > > currently using it.
> > > There were no signs of deprecation, so people are legally using it.
> 
> I mentioned it somewhere, but it might not have been on the list. It
> was a long time ago.
> 
> > > > This is not actually a problem for leaf nodes, since the user-space
> > > > created device nodes will still work. It just results in a warning
> > > > message.
> > > 
> > > Wrong, these are not just warning messages, the driver API has changed.
> > > 
> > > > So, in this case, the device nodes that the user wants to use will
> > > > still be there (created by the boot script) and will work fine.
> > > 
> > > Except the dynamic update of device nodes won't happen anymore, so it
> > > affects also all leaf nodes in the directories (e.g. partition entries
> > > won't be created/removed anymore). Events won't be created for these
> > > nodes as well, so configurations depending on this are broken as well.
> >
> > Richard, 
> > 
> > Are the above problems really introduced by the changes ? 
> 
> Yes, although I still think it's not a common problem. In general, if
> you are tarring and untarring inodes, you take the whole directory and
> put it all back again. Even the partitioning event is a corner case,
> since you're most likely to install a new drive (and thus have no
> inodes to "restore") and then partition. And even the obsolete
> rc.devfs only saved away inodes which had been changed, not
> everything.
> 
> However, if this concerns you, I can send a patch that effectively
> restores the old behaviour for directories. It's just a matter of
> grabbing the right lock, fiddling a flag and returning a different
> entry. But I definately want to keep a warning message. 

Please do that.

> I want there to be some pain for broken or really obsolete
> configurations.

Please do that on 2.5: Its already opened.

Thanks

