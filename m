Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286756AbSAXNE0>; Thu, 24 Jan 2002 08:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287626AbSAXNER>; Thu, 24 Jan 2002 08:04:17 -0500
Received: from [195.66.192.167] ([195.66.192.167]:41234 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S286756AbSAXND7>; Thu, 24 Jan 2002 08:03:59 -0500
Message-Id: <200201241300.g0OD0AE10822@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Pavel Machek <pavel@suse.cz>, Alexander Viro <viro@math.psu.edu>
Subject: Re: force umount [was Re: [STATUS 2.5]  January 18, 2002]
Date: Thu, 24 Jan 2002 15:00:12 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Pavel Machek <pavel@suse.cz>, Jakob ?stergaard <jakob@unthought.net>,
        Ville Herva <vherva@twilight.cs.hut.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <20020123113122.GC965@elf.ucw.cz> <Pine.GSO.4.21.0201231751470.19120-100000@weyl.math.psu.edu> <20020124122919.GA2135@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020124122919.GA2135@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Can I kill the processes accessing busy
> > > filesystems? [That was big point of force umount, I believe.]
> >
> > Huh?  If process is killable - it's killable.  What does it have to
> > --force?
>
> Following situation used to be common and "not a bug":
>
> process a tries to read /nfs/foo, but nfs server dies.
>
> kill -9 a does not kill a.
>
> It used to be "not a bug" before. Can we declare it a bug after umount
> /nfs --force?

After more than a year on lkml I still don't understand why it's not a bug.
Anyway, I always mount NFS with hard,intr and my processes are killable...
--
vda
