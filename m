Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263451AbTC2Sad>; Sat, 29 Mar 2003 13:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263452AbTC2Sad>; Sat, 29 Mar 2003 13:30:33 -0500
Received: from tomts26-srv.bellnexxia.net ([209.226.175.189]:10400 "EHLO
	tomts26-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S263451AbTC2Sac>; Sat, 29 Mar 2003 13:30:32 -0500
Date: Sat, 29 Mar 2003 13:36:53 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: john@grabjohn.com
cc: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
       <linux-kernel@vger.kernel.org>, <trivial@rustcorp.com.au>
Subject: Re: [TRIVIAL] Cleanup in fs/devpts/inode.c
In-Reply-To: <200303291829.h2TITPPi000418@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0303291335330.6497-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Mar 2003 john@grabjohn.com wrote:

> > this patch un-complicates a small piece of code of the dev/pts
> > filesystem and decreases the size of the object code by 8 bytes
> > for my build. Yay! :)
> 
> > -		err = PTR_ERR(devpts_mnt);
> > -		if (!IS_ERR(devpts_mnt))
> > -			err = 0;
> > +		if (IS_ERR(devpts_mnt))
> > +			err = PTR_ERR(devpts_mnt);
> 
> Why not use
> 
> err = (IS_ERR(devpts_mnt) ? err = 0 : PTR_ERR(devpts_mnt));

without my handy-dandy C reference book here, don't you have
that backwards?  

and is there some value to using "err = 0"  internally rather
than just "0"?

rday

p.s.  risking major embarrassment if i didn't remember my
C programming ...

