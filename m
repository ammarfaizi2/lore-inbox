Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVCYWcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVCYWcv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVCYWcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:32:15 -0500
Received: from mail.stdbev.com ([63.161.72.3]:6839 "EHLO
	mail.standardbeverage.com") by vger.kernel.org with ESMTP
	id S261863AbVCYWag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:30:36 -0500
Message-ID: <9b1dc58a05e00d61abe982ccb6b7317f@stdbev.com>
Date: Fri, 25 Mar 2005 16:30:42 -0600
From: "Jason Munro" <jason@stdbev.com>
Subject: Re: 2.6.12-rc1-mm3 (cannot read cd-rom, 2.6.12-rc1 is OK)
To: " Jason Munro " <jason@stdbev.com>
Cc: <linux-kernel@vger.kernel.org>, <elenstev@mesatop.com>, <akpm@osdl.org>
Reply-to: <jason@stdbev.com>
In-Reply-To: <86e8213fc8bb8803b1e27da47665b017@stdbev.com>
References: <20050325002154.335c6b0b.akpm@osdl.org>
            <42446B86.7080403@mesatop.com>
            <424471CB.3060006@mesatop.com>
            <20050325122433.12469909.akpm@osdl.org>
            <4244812C.3070402@mesatop.com>
            <761c884705af2ea412c083d849598ca7@stdbev.com>
            <20050325140654.430714e2.akpm@osdl.org>
            <86e8213fc8bb8803b1e27da47665b017@stdbev.com>
X-Mailer: Hastymail 1.4-CVS
x-priority: 3
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4:27:49 pm 03/25/05 "Jason Munro" <jason@stdbev.com> wrote:
> On 4:06:54 pm 03/25/05 Andrew Morton <akpm@osdl.org> wrote:
> >
> >  (Please dont' edit the cc line.  Just do reply-to-all)
>
> Oops, reply-to-all it is.
>
> >  "Jason Munro" <jason@stdbev.com> wrote:
> > >
> > > >   [  146.301026] rock: directory entry would overflow storage
> > > >   [  146.301044] rock: sig=0x5245, size=8, remaining=0
> > > >   [  158.388397] rock: directory entry would overflow storage
> > > >   [  158.388415] rock: sig=0x5850, size=36, remaining=34
> > > >   [root@spc1 steven]#
> > >
> > >
> > >   Same results with mm3 here, though mm2 will not boot on my
> > >   machine so I'm not sure about that. 2.6.12-rc1 works fine,
> > >   rc1-mm3 successfully mounts the cdrom device but shows no
> > >   contents. Releveant dmsesg output:
> > >   rock: directory entry would overflow storage
> > >   rock: sig=0x4543, size=28, remaining=0
> > >   rock: directory entry would overflow storage
> >
> >  Seems that I am unable to read.  It's the new rock-ridge bounds
> >  checking.
> >
> >  It worked for me.  Is someone able to get an image of a failing
> >  filesystem into my hands?
>
> I can reproduce it with the following:
>
> mkdir temp
> touch temp/file1 temp/file2 temp/file3
> mkisofs -R -l temp > test.iso
> mount -o loop /mnt/loop

Of course that should be: mount -o loop test.iso /mnt/loop :)

\__  Jason Munro
 \__ jason@stdbev.com
  \__ http://hastymail.sourceforge.net/

