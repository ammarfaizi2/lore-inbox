Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285473AbRLSUZm>; Wed, 19 Dec 2001 15:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285458AbRLSUZc>; Wed, 19 Dec 2001 15:25:32 -0500
Received: from dsl-213-023-043-155.arcor-ip.net ([213.23.43.155]:36364 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S285459AbRLSUYB>;
	Wed, 19 Dec 2001 15:24:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Pavel Machek <pavel@suse.cz>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Quinn Harris <quinn@nmt.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: File copy system call proposal
Date: Wed, 19 Dec 2001 21:26:49 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200112100544.fBA5isV223458@saturn.cs.uml.edu> <20011213030107.L940@lynx.no> <20011213221712.A129@elf.ucw.cz>
In-Reply-To: <20011213221712.A129@elf.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16GnIg-0000V5-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 13, 2001 10:17 pm, Pavel Machek wrote:
> [Andreas Dilger <adilger@turbolabs.com> wrote:]
> > No, I think he means just the opposite - that having a "copy(2)" syscall
> > would greatly _help_ SMB in that the copy could be done entirely at the
> > server side, rather than having to pull _all_ of the data to the client
> > and then sending it back again.
> > 
> > When I was working on another network storage system (formerly called
> > Lustre, don't know what it is called now) we had a "copy" primitive in
> > the VFS interface, and there were lots of useful things you could do
> > with it.
> > 
> > Consider the _very_ common case (that nobody has mentioned yet) where you
> > are editing a large file.  When you write to the file, the editor copies
> > the file to a backup, then immediately truncates the original file and
> > writes the new data there.  What would be _far_ preferrable is to
> > just
> 
> Are you sure? I think editor just _moves_ original to backup.

Hi,

It would be so nice if all editors did that, but most don't according to the 
tests I've done, especially the newer ones like kedit, gnome-edit etc.  I 
think this is largely due to developers not knowing why it's good to do it 
this way.

--
Daniel

