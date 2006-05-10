Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbWEJVjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWEJVjo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWEJVjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:39:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55980 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965020AbWEJVjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:39:44 -0400
Date: Wed, 10 May 2006 22:39:29 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Adrian Bunk <bunk@stusta.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Message-ID: <20060510213929.GF27946@ftp.linux.org.uk>
References: <1147273787.17886.46.camel@localhost.localdomain> <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net> <Pine.LNX.4.58.0605101116590.5532@gandalf.stny.rr.com> <20060510162404.GR3570@stusta.de> <Pine.LNX.4.58.0605101506540.22959@gandalf.stny.rr.com> <1147290577.21536.151.camel@c-67-180-134-207.hsd1.ca.comcast.net> <Pine.LNX.4.58.0605101636580.22959@gandalf.stny.rr.com> <1147295515.21536.168.camel@c-67-180-134-207.hsd1.ca.comcast.net> <20060510212058.GE27946@ftp.linux.org.uk> <1147296822.21536.175.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147296822.21536.175.camel@c-67-180-134-207.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 02:33:42PM -0700, Daniel Walker wrote:
> > Consider the following scenario:
> > 
> > 1) gcc gives false positive
> > 2) tosser on a rampage "fixes" it
> > 3) code is chaged a month later
> > 4) a real bug is introduced - one that would be _really_ visible to gcc,
> > with "is used" in a warning
> > 5) thanks to aforementioned tosser, that bug remains hidden.
> 
> I don't really see anything new here .. The same sort of stuff can
> happen in any code considered for inclusion .. That's what the review
> process is for .
> 
> Real errors can be covered up any number of way ..

One last time: your kind of patches actually increases the odds of new bug
staying unnoticed.

If you really fill the urge to pull a Bunk, do it somewhere else, please -
the real thing is already more than sufficiently annoying.
