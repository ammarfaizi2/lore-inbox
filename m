Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSIAPSk>; Sun, 1 Sep 2002 11:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317117AbSIAPSj>; Sun, 1 Sep 2002 11:18:39 -0400
Received: from dsl-213-023-020-041.arcor-ip.net ([213.23.20.41]:48512 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317112AbSIAPSi>;
	Sun, 1 Sep 2002 11:18:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Luca Barbieri <ldb@ldb.ods.org>, trond.myklebust@fys.uio.no
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
Date: Sun, 1 Sep 2002 17:15:30 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com> <15729.17279.474307.914587@charged.uio.no> <1030835635.1422.39.camel@ldb>
In-Reply-To: <1030835635.1422.39.camel@ldb>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17lWRm-0004Zg-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 September 2002 01:13, Luca Barbieri wrote:
> On Sun, 2002-09-01 at 00:30, Trond Myklebust wrote:
> > >>>>> " " == Luca Barbieri <ldb@ldb.ods.org> writes:
> > 
> >      > Then the rest of the code doesn't need to know at all that
> >      > credentials are shared and is simpler and faster.  We have
> >      > however a larger penalty on credential change but, as you say,
> >      > that's extremely rare (well, perhaps not necessarily extremely,
> >      > but still rare).
> > 
> > What if I, in a fit of madness/perversion, decide to use CLONE_CRED
> > between 2 kernel threads (i.e. no 'kernel entry')?
> You don't or you manually patch the task_struct of the other threads.
> This isn't a serious concern.

It is a serious concern.  Inventing new, subtle behavior differences 
between user and kernel threads is, in a word, gross.  It's certain
to bite people in the future.

-- 
Daniel
