Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278587AbRJXPfd>; Wed, 24 Oct 2001 11:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278591AbRJXPf0>; Wed, 24 Oct 2001 11:35:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52493 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S278587AbRJXPfP>; Wed, 24 Oct 2001 11:35:15 -0400
Date: Wed, 24 Oct 2001 17:35:33 +0200
From: Jan Kara <jack@suse.cz>
To: Wojciech =?iso-8859-2?Q?Purczy=F1ski?= <wp@supermedia.pl>
Cc: bugtraq@securityfocus.com, linux-kernel@vger.kernel.org
Subject: Re: Overriding qouta limits in Linux kernel
Message-ID: <20011024173533.C10075@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.33.0110220947590.29104-100000@lama.supermedia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110220947590.29104-100000@lama.supermedia.pl>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> Almost any suid binary may be used to create large files overriding quota
> limits.
  Yes.

> When setuid-root binary inherits file descriptors from user process it may
> write to it without respecting the quota restrictions. This is because
> suid process has CAP_SYS_RESOURCE effective capability enabled during
> writing to the file. Quota does not know anything about who opened file
> descriptor and checks current process privileges only. This is bug in
> kernel and not in those setuid-root binaries.
  Actually I think this is not a bug, it's a feature... If some process
has a CAP_SYS_RESOURCE capability then it can override the limits (that's
how I understand this capability). Hence it's got right to exceed user quota.
I think this is reasonable behaviour (root can do anything - suid binaries are
just making the will of root ;)).
  And BTW I know about no way how to know who opened the file...

									Honza
--
Jan Kara <jack@suse.cz>
SuSE CR Labs
