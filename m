Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbUC1MWx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 07:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUC1MWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 07:22:53 -0500
Received: from mail.shareable.org ([81.29.64.88]:50578 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261635AbUC1MWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 07:22:51 -0500
Date: Sun, 28 Mar 2004 13:22:42 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040328122242.GB32296@mail.shareable.org>
References: <m1y8ptu42m.fsf@ebiederm.dsl.xmission.com> <20040325174942.GC11236@mail.shareable.org> <m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com> <20040325194303.GE11236@mail.shareable.org> <m1ptb0zjki.fsf@ebiederm.dsl.xmission.com> <20040327102828.GA21884@mail.shareable.org> <m1vfkq80oy.fsf@ebiederm.dsl.xmission.com> <20040327214238.GA23893@mail.shareable.org> <m1ptax97m6.fsf@ebiederm.dsl.xmission.com> <m1brmhvm1s.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1brmhvm1s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> > The addictive thing about the prototype implementation was that you
> > could do ``ln --cow / /some/other/directory'' and you would have an
> > atomic snapshot of your filesystem.  Definitely not a feature for the
> > first implementation but certainly something to dream about.
> 
> Addictive but broken by design.  If any of the files inside your
> directory tree have hard links outside of the tree there is no way
> short of recursing through all of the subdirectories directories to
> tell if a given inode has is in use.  Except in the special case
> where you are taking a cow copy of the entire filesystem.  At which
> point a magic mount option is likely a better interface.

I don't understand this explanation.  Can you explain again?  What is
the problem with inodes being in use?

-- Jamie
