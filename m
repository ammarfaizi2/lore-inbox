Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267916AbUH2OjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267916AbUH2OjF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 10:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267992AbUH2Oie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 10:38:34 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:63147 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S267923AbUH2OaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 10:30:13 -0400
Message-Id: <200408290004.i7T04DEO003646@localhost.localdomain>
To: Rik van Riel <riel@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from Rik van Riel <riel@redhat.com> 
   of "Thu, 26 Aug 2004 16:10:48 -0400." <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Sat, 28 Aug 2004 20:04:13 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> said:
> On Thu, 26 Aug 2004, Linus Torvalds wrote:
> > So "/tmp/bash" is _not_ two different things. It is _one_ entity, that
> > contains both a standard data stream (the "file" part) _and_ pointers to
> > other named streams (the "directory" part).

> Thinking about it some more, how would file managers and
> file chosers handle this situation ?
> 
> Currently the user browses the directory tree and when
> the user clicks on something, one of the following 
> happens:
> 
> 1) if it is a directory, the file manager/choser changes
>    into that directory
> 
> 2) if it is a file, the file is opened

And now you have a mess. Is it "really" a file, or a directory? Why not
just keep both well apart, and stay happy? I just fail to see what could be
gained by having directories that really aren't, and files that aren't
either. Use a directory if you want one, use a file elsewhere.

> Now how do we present things to users ?
> 
> How will users know when an object can only be chdired
> into, or only be opened ?

Easy: It is a directory, or it isn't.

> For objects that do both, how does the user choose ?

Don't give silly choices.

> Do we really want to have a file paradigm that's different
> from the other OSes out there ?

I vote "no". There are/have been OSes with weird "files", none of them
survived to get anywhere as popular as Unix and "file == stream of
bytes". Even with much simpler variants like files as sequences of
records. For a good reason: The Unix way is simple, and extremely flexible,
as my proggie can define at its own whim how to handle what's inside. If a
single stream isn't enough, we have directories. No need to innovate there.

> What happens when users want to transfer data from Linux
> to another system ?

Or between Linux systems with different kernels that happen to implement
different views/metadata on files.

Please do remember devfs: It sounded like a cool idea, got into the kernel
just to be thrown out later because nobody used it. Much heat was
generated, nothing of permanent value. This looks the same: A very vocal
tiny minority is clamoring for something completely non-Unix for totally
bogus reasons. What happened to "code talks, bullshit walks"? There is _no_
code (== real-world, user programs that can't be done efficiently enough
without this), so this nonsense should just be thrown out, and everybody go
back to real hacking.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
