Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUC2NAm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUC2M7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:59:46 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:44687 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262850AbUC2MaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:30:15 -0500
Date: Mon, 29 Mar 2004 11:28:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       =?iso-8859-2?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040329092835.GD1453@openzaurus.ucw.cz>
References: <Pine.LNX.4.44.0403210944310.12359-100000@bigblue.dev.mdolabs.com> <20040321181430.GB29440@wohnheim.fh-wedel.de> <m1y8ptu42m.fsf@ebiederm.dsl.xmission.com> <20040325174942.GC11236@mail.shareable.org> <m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com> <20040325194303.GE11236@mail.shareable.org> <m1ptb0zjki.fsf@ebiederm.dsl.xmission.com> <20040327102828.GA21884@mail.shareable.org> <m1vfkq80oy.fsf@ebiederm.dsl.xmission.com> <20040327214238.GA23893@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040327214238.GA23893@mail.shareable.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > There are two possible implementations strategies for implementing
> > cow files.  You can either start as Jrn did with hardlinks, or you
> > can start with symlinks.
... 
> There's a third implementation strategy.  Since we're talking in all
> cases about adding a new feature to the underlying filesystem, why not
> implement separate inodes pointing to an underlying shared inode which
> holds the data.  (I think it was mentioned earlier in this thread).

Actually, there's 4th strategy, too. You could implement sharing at block level.
Block free bitmap would become bigger, but you could do some tricks to keep it
at ~8 bits per block...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

