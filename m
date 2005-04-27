Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVD0VqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVD0VqZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 17:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVD0VpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 17:45:08 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55569 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262043AbVD0VoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 17:44:14 -0400
Date: Wed, 27 Apr 2005 23:44:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/: remove unneeded EXPORT_SYMBOL's
Message-ID: <20050427214408.GV4099@stusta.de>
References: <20050417195706.GD3625@stusta.de> <20050419191328.GJ1111@conscoop.ottawa.on.ca> <1113939827.6277.86.camel@laptopd505.fenrus.org> <42657F7C.8060305@s5r6.in-berlin.de> <1113981989.6238.30.camel@laptopd505.fenrus.org> <426683E9.4080708@s5r6.in-berlin.de> <1114029144.5085.20.camel@kino.dennedy.org> <4270001F.8020504@s5r6.in-berlin.de> <Pine.LNX.4.62.0504272337130.2481@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504272337130.2481@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 11:38:11PM +0200, Jesper Juhl wrote:
> On Wed, 27 Apr 2005, Stefan Richter wrote:
> 
> > Dan Dennedy wrote on 2005-04-20:
> > > There are technical
> > > merits for removal of the external symbols that I accept. I also accept
> > > that we have no way of maintaining any sort of stable subsystem for
> > > external projects we are not aware of or who are not communicating with
> > > us about their requirements (it goes beyond just a stable interface).
> > ...
> > > I vote to remove external symbols not used by the Linux1394.org modules
> > > or the module at http://sourceforge.net/projects/video-2-1394/
> > 
> > Nobody else posted specific requirements so far. So let's clean up the API.
> > How about this:
> <snip>
> >  - Add warning comments next to obsolete EXPORT_SYMBOLs. Add warning
> >    printks to obsolete functions? (If there are any.)
> 
> how about just adding __deprecated to them?

Some of these functions might have valid users (e.g. from the same 
file).

__deprecated_for_modules (already in -mm) is the right solution.

> Jesper Juhl

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

