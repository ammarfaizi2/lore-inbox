Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318229AbSIOTJY>; Sun, 15 Sep 2002 15:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318230AbSIOTJX>; Sun, 15 Sep 2002 15:09:23 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:15061 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S318229AbSIOTJU>;
	Sun, 15 Sep 2002 15:09:20 -0400
Date: Sun, 15 Sep 2002 21:14:13 +0200 (MEST)
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Gilad Ben-Yossef <gilad@benyossef.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] binfmt_script: interpreted interpreter doesn't work
In-Reply-To: <1032116731.2620.1.camel@gby.benyossef.com>
Message-ID: <Pine.GSO.4.30.0209152113420.22107-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Sep 2002, Gilad Ben-Yossef wrote:

> On Sun, 2002-09-15 at 20:15, Pozsar Balazs wrote:
>
> > This may well not be bug, rather an intended feature, but please enlighten
> > me why the following doesn't work:
> >
> > I have two scripts:
> > /home/pozsy/a:
> > #!/bin/sh
> > echo "Hello from a!"
> >
> > /home/pozsy/b:
> > #!/home/pozsy/a
> > echo "hello from b!"
> >
> >
> > Both of them has +x permissions.
> > But I cannot execute the /home/pozsy/b script:
> >
> > [pozsy:~]$ strace -f /home/pozsy/b
> > execve("/home/pozsy/b", ["/home/pozsy/b"], [/* 25 vars */]) = 0
> > strace: exec: Exec format error
> > [pozsy:~]$
> >
> >
> > Isn't this "indirection" allowed?
>
> hm... never chcked the code but I think /home/pozsy/a needs to be in
> /etc/shells

No, that has nothing to do with this.

> What are you trying to do, anyway?

See my other post.

-- 
pozsy

