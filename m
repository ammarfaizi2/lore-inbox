Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275111AbRIYRBe>; Tue, 25 Sep 2001 13:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275112AbRIYRBY>; Tue, 25 Sep 2001 13:01:24 -0400
Received: from mail.delfi.lt ([213.197.128.86]:34828 "HELO
	mx-outgoing.delfi.lt") by vger.kernel.org with SMTP
	id <S275111AbRIYRBI>; Tue, 25 Sep 2001 13:01:08 -0400
Date: Tue, 25 Sep 2001 19:01:15 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re: all files are executable in vfat
To: Alexander Viro <viro@math.psu.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <Pine.GSO.4.21.0109251239250.24321-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0109251239250.24321-100000@weyl.math.psu.edu>
X-Mailer: Mahogany, 0.64 'Sparc', compiled for Linux 2.4.7 i686
Message-Id: <20010925170129.7AF958F659@mail.delfi.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001 12:47:46 -0400 (EDT) Alexander Viro <viro@math.psu.edu> wrote:

AV> > $ ls -l ls
AV> > -rwxrwxrwx    1 nerijus  nerijus     45724 Rgs 25 18:12 ls
AV> 
AV> So use the right option for that - umask=111 and there you go.

Actually I just few minutes ago thought about umask - yes, it helps,
thank you. But now I cannot enter any directory as regular user.

AV> noexec doesn't (and shouldn't) do anything about mode.  Yes, VFAT (along
AV> with explicit mechanism for doing what you want to do) used to have a
AV> bug in noexec handling.  And that's a bug - plain and simple.  Try it
AV> on any other UNIX _or_ other filesystem on Linux.

Because this bug was fixed I thought something broke instead...

AV> -o noexec means "execve() fails regardless of file permissions".  If you
AV> want "give all regular files rw-rw-rw-" - VFAT has option for that:
AV> umask.

Regards,
Nerijus

