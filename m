Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269828AbRHDHqL>; Sat, 4 Aug 2001 03:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269829AbRHDHqC>; Sat, 4 Aug 2001 03:46:02 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:55564 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S269828AbRHDHpo>; Sat, 4 Aug 2001 03:45:44 -0400
Message-ID: <3B6BA82B.E02553D4@namesys.com>
Date: Sat, 04 Aug 2001 11:45:47 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semanticchange 
 patch)
In-Reply-To: <Pine.GSO.4.21.0108031947080.5264-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Sat, 4 Aug 2001, Chris Wedgwood wrote:
> 
> > On Fri, Aug 03, 2001 at 07:41:40PM -0400, Alexander Viro wrote:
> >
> >     file->f_cred. Different people opening the same file can have
> >     different credentials (e.g. credentials can be revoked)
> >
> > Sure, but if I
> >
> >         f = open("/home/viro/file", ... );
> >         fsync(f);
> >
> > I only have creds for 'file' --- I have no such thing for 'viro' or
> > 'home', so I can't do anything sensible here.
> 
> Credentials are about "I'm foo", not "I'm allowed to do this with that".
> Server decides what you can do.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Can you define f_cred for us?

Hans
