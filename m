Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSIAP1U>; Sun, 1 Sep 2002 11:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSIAP1U>; Sun, 1 Sep 2002 11:27:20 -0400
Received: from dsl-213-023-020-041.arcor-ip.net ([213.23.20.41]:54912 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317181AbSIAP1T>;
	Sun, 1 Sep 2002 11:27:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: trond.myklebust@fys.uio.no, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Introduce BSD-style user credential [3/3]
Date: Sun, 1 Sep 2002 17:23:57 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dave McCracken <dmccr@us.ibm.com>
References: <15728.7151.27079.551845@charged.uio.no> <Pine.LNX.4.44.0208302110280.1524-100000@home.transmeta.com> <15728.61204.381468.238609@charged.uio.no>
In-Reply-To: <15728.61204.381468.238609@charged.uio.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17lWZy-0004Zm-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 August 2002 18:30, Trond Myklebust wrote:
> >>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:
> 
>      > One thing that may be interesting (I certainly think it migth
>      > be), would be to add a "struct user_struct *" pointer to the
>      > vfs_cred as well. This is because I'd just _love_ to have that
>      > "user_struct" fed down to the VFS layer, since I think that is
>      > where we may some day want to put things like user-supplied
>      > cryptographic keys etc.
> 
>      > The advantage of "struct user_struct" (as opposed to just a
>      > uid_t) is that it can have information that lives for the whole
>      > duration of a login, and it's really the only kind of data
>      > structure in the kernel that can track that kind of
>      > information.
> 
> No problem at all with this. Indeed I agree it makes a lot of sense...
> 
> The only thing is if you'd allow me to do it as an incremental patch
> to the initial one?
> I don't see 'struct user_struct *' as replacing the existing 'uid'
> entry, so there should be no need to change the existing API. Instead,
> we can just add in the necessary call to alloc_uid() to
> vfscred_create() and/or setfsuid()...

I really do like Kai's name suggestion 'struct session'.

-- 
Daniel
