Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWGRCUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWGRCUb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 22:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWGRCUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 22:20:31 -0400
Received: from fc-cn.com ([218.25.172.144]:64267 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1750916AbWGRCUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 22:20:30 -0400
Date: Tue, 18 Jul 2006 10:21:55 +0800
From: Qi Yong <qiyong@fc-cn.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       sam@ravnborg.org
Subject: Re: [patch] gitignore quilt's files
Message-ID: <20060718022154.GA2171@localhost.localdomain>
References: <20060717033850.GA18438@localhost.localdomain> <44BC1551.7040104@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BC1551.7040104@ens-lyon.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2006 at 06:55:13PM -0400, Brice Goglin wrote:
> Qi Yong wrote:
> > gitignore: ignore quilt's files.
> >  
> > Signed-off-by: Qi Yong <qiyong@fc-cn.com>
> > ---
> >
> > diff --git a/.gitignore b/.gitignore
> > index 27fd376..21e346a 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -33,3 +33,7 @@ include/linux/version.h
> >  
> >  # stgit generated dirs
> >  patches-*
> > +
> > +# quilt's files
> > +patches
> > +series
> >
> >   
> 
> 
> Isn't "series" in the "patches/" subdirectory ? With quilt 0.45, the
> only quilt files I see in my linux-tree root are patches/ and .pc/

>From the manpage:
-- 8< --
The series file is looked up in the root of the  source  tree, in  the
patches  directory,  and  in  the .pc directory.  The first series file
that is found is used. This may also be a symbolic link, or a file with
multiple  hard  links.  Usually, only one series file is used for a set
of patches, so the patches sub-directory is a convenient location.
-- >8 --

Also it's convienient to put "series" in the root of the source tree if
"patches/" is shared among several source trees.
-- 
Qi Yong
