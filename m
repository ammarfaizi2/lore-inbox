Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318173AbSIBAKo>; Sun, 1 Sep 2002 20:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318175AbSIBAKo>; Sun, 1 Sep 2002 20:10:44 -0400
Received: from ns0.tateyama.or.jp ([210.128.170.1]:16144 "HELO
	ns0.tateyama.or.jp") by vger.kernel.org with SMTP
	id <S318173AbSIBAKo> convert rfc822-to-8bit; Sun, 1 Sep 2002 20:10:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gabor Kerenyi <wom@tateyama.hu>
To: Chris Wright <chris@wirex.com>, Daniel Phillips <phillips@arcor.de>
Subject: Re: extended file permissions based on LSM
Date: Mon, 2 Sep 2002 09:20:50 +0900
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <200208310616.04709.wom@tateyama.hu> <E17lX4d-0004a1-00@starship> <20020901160805.F11165@figure1.int.wirex.com>
In-Reply-To: <20020901160805.F11165@figure1.int.wirex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209020920.50418.wom@tateyama.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 September 2002 08:08, Chris Wright wrote:
> * Daniel Phillips (phillips@arcor.de) wrote:
> > On Sunday 01 September 2002 02:26, Chris Wright wrote:
> > > * Ingo Oeser (ingo.oeser@informatik.tu-chemnitz.de) wrote:
> > > > So this is a correctly pointed out design weakness: The way the
> > > > user took to reach the inode cannot be taken into account.
> > >
> > > Yes, this is known, and there are anticipated VFS changes to remedy
> > > this.
> >
> > Could you describe them, please?
>
> For example, passing vfsmount/dentry pair to i_op->permission().
> getattr() is already done, and last I heard I Al intends to do
> setattr() as well.

Changing the i_op->permission() is the last step and the easiest, I think.
There will be more VFS changes. vfs_*, may_*, namei.c:permissoin,
path name lookup, LSM etc.
Moreover the i_op->permission() change will break the interface to 
FileSystems but it could be easily fixed.

Gabor

