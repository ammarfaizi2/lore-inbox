Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265141AbRFZWkx>; Tue, 26 Jun 2001 18:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265142AbRFZWkn>; Tue, 26 Jun 2001 18:40:43 -0400
Received: from cs.columbia.edu ([128.59.16.20]:17043 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S265141AbRFZWkg>;
	Tue, 26 Jun 2001 18:40:36 -0400
Message-Id: <200106262240.SAA26254@razor.cs.columbia.edu>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Kenneth Johansson <ken@canit.se>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        huaz@cs.columbia.edu
Subject: Re: EXT2 Filesystem permissions (bug)? 
In-Reply-To: Message from Kenneth Johansson <ken@canit.se> 
   of "Wed, 27 Jun 2001 00:23:04 +0200." <3B390B48.D444B7C5@canit.se> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Jun 2001 18:40:34 -0400
From: Hua Zhong <huaz@cs.columbia.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Do linux even support the sticky bit (t) I can't see a reason to use it, why would I want the file to be stored in the swap ?? 

For files I think it was used in days when there was no VM, so that you could 
hint the system to put frequently used executables always in memory (like vi, 
sh, etc).  After VM was invented, there is really no reason to use it.  I 
don't think newer OSes like Linux implemented this.
 
> Also I think S (setuid but no execute bit) have something to do with file locking but I'am not shure exactly how it works. 

On some unix systems S means using mandatory locking (instead of advisory 
locking).  I am not sure about Linux though.

> "H. Peter Anvin" wrote:
> > 
> > Followup to:  <Pine.LNX.4.30.0106251729450.18996-100000@coredump.sh0n.net>
> > By author:    Shawn Starr <spstarr@sh0n.net>
> > In newsgroup: linux.dev.kernel
> > >
> > > Is this a bug or something thats undocumented somewhere?
> > >
> > > d--------T
> > > and
> > > drwSrwSrwT
> > >
> > > are these special bits? I'm not aware of +S and +T
> > >
> > 
> > It's neither a bug nor undocumented.
> > 
> > "info ls" would have told you the following:
> > 
> >      The permissions listed are similar to symbolic mode
> >      specifications
> >      (*note Symbolic Modes::.).  But `ls' combines multiple bits into
> >      the third character of each set of permissions as follows:
> >     `s'
> >           If the setuid or setgid bit and the corresponding executable
> >           bit are both set.
> > 
> >     `S'
> >           If the setuid or setgid bit is set but the corresponding
> >           executable bit is not set.
> > 
> >     `t'
> >           If the sticky bit and the other-executable bit are both set.
> > 
> >     `T'
> >           If the sticky bit is set but the other-executable bit is not
> >           set.
> > 
> >     `x'
> >           If the executable bit is set and none of the above apply.
> > 
> >     `-'
> >           Otherwise.
> > 
> >         -hpa
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


