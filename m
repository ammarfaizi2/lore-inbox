Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132048AbRC1Rwq>; Wed, 28 Mar 2001 12:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132101AbRC1Rwg>; Wed, 28 Mar 2001 12:52:36 -0500
Received: from cp912944-a.mtgmry1.md.home.com ([24.18.149.178]:35992 "EHLO zalem.puupuu.org") by vger.kernel.org with ESMTP id <S132048AbRC1RwT>; Wed, 28 Mar 2001 12:52:19 -0500
Date: Wed, 28 Mar 2001 12:51:28 -0500
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Disturbing news..
Message-ID: <20010328125128.A6467@zalem.puupuu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <01032806093901.11349@tabby> <Pine.GSO.3.96.1010328144551.7198A-100000@laertes> <F6Om1QA+9ew6EwTq@sis-domain.demon.co.uk> <20010328100440.A5941@zalem.puupuu.org> <ZEABaXAGggw6EwTH@sis-domain.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <ZEABaXAGggw6EwTH@sis-domain.demon.co.uk>; from announce@sis-domain.demon.co.uk on Wed, Mar 28, 2001 at 04:49:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2001 at 04:49:26PM +0100, Simon Williams wrote:
> What I meant was that if a file is owned by root with permissions of,
> say, 555 (r-xr-xr-x), not setuid or setgid, then another executable
> run as a non-root user cannot modify it or change the permissions to
> 7 (rwx).

It's already the case that a file owned by user A cannot have its
rights changed by user B.  Also, if the write permission is not set,
you can't modify the file.  That's the basic unix security model.  Of
course, if you're root all best are off, root is god.  For those who
con't like that, there are things like capabilities and MAC.  But they
are _really_ hard to setup correctly.

What they are talking about is to have the x bit cancel the w bit,
i.e. make the rwx files unwritable.  Fixing the symptoms, you know...


> My policy is to give necessary permissions & no more.

This is not a bad policy.  Removing read permissions can make fixing
problems a pain, though (what, no gdb/strace of system executables?).


> I would set the
> aforementioned permissions on the main system binaries which would allow
> other users to get on with what they need to do without being able to
> affect the workspaces of other users, only their own.

Well, the main system binaries are already that way (r-xr-xr-x or
rwxr-xr-x, which when root-owned are equivalent).  I don't see your
point.

  OG.
