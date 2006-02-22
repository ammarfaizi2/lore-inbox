Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422634AbWBVA2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWBVA2d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422635AbWBVA2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:28:33 -0500
Received: from xenotime.net ([66.160.160.81]:60047 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422634AbWBVA2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:28:32 -0500
Date: Tue, 21 Feb 2006 16:28:30 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Herbert Poetzl <herbert@13thfloor.at>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Sam Ravnborg <sam@ravnborg.org>,
       Daniel Barkalow <barkalow@iabervon.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] duplicate #include check for build system
In-Reply-To: <20060222002613.GG20204@MAIL.13thfloor.at>
Message-ID: <Pine.LNX.4.58.0602211628100.12588@shark.he.net>
References: <20060221014824.GA19998@MAIL.13thfloor.at>
 <Pine.LNX.4.64.0602210149190.6773@iabervon.org> <20060221175246.GA9070@mars.ravnborg.org>
 <20060222001153.GF20204@MAIL.13thfloor.at> <Pine.LNX.4.58.0602211616380.12588@shark.he.net>
 <20060222002613.GG20204@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006, Herbert Poetzl wrote:

> On Tue, Feb 21, 2006 at 04:18:57PM -0800, Randy.Dunlap wrote:
> > On Wed, 22 Feb 2006, Herbert Poetzl wrote:
> >
> > > On Tue, Feb 21, 2006 at 06:52:46PM +0100, Sam Ravnborg wrote:
> > > > On Tue, Feb 21, 2006 at 02:29:12AM -0500, Daniel Barkalow wrote:
> > > > > On Tue, 21 Feb 2006, Herbert Poetzl wrote:
> > > >
> > > > > I think the kernel style is to encourage duplicate includes,
> > > > > rather than removing them. Removing duplicate includes won't
> > > > > remove any dependancies (since the includes that they duplicate
> > > > > will remain).
> > >
> > > > The style as I have understood it is that each .h file in
> > > > include/linux/ are supposed to be self-contained. So it includes
> > > > what is needs, and the 'what it needs' are kept small.
> > > >
> > > > Keeping the 'what it needs' part small is a challenge resulting
> > > > in smaller .h files. But also a good way to keep related things
> > > > together.
> > >
> > > glad that I stimulated a philosophical discussion
> > > about the kernel header files and what they should
> > > include or not ...
> > >
> > > but the idea was more to give the developers an
> > > instrument to verify that they are not including
> > > stuff several times, and that's actually in .h
> > > and .c files, because it seems that often the same
> > > header file is included twice in the _same_ file
> > >
> > > anyway, was this a positive or negative reply?
> >
> > Hi Herbert,
> >
> > The goal is not to remove the most possible #includes.
>
> which I totally agree with ...
>
> but a) how is that related to _having_ a tool to
> check for duplicate includes, and b) how is it
> related to removing duplicate includes in general?
>
> let me give a simple example here:
>
>  #include <linux/pm.h>
>  #include <linux/sched.h>
>  #include <linux/proc_fs.h>
> -#include <linux/pm.h>
>
> do you think the second one is really desired?

Of course not.

> > E.g., if sched.h already sucks in kernel.h,
> > kernel.h still should be #included if the source (.c)
> > files uses any APIs or extern data from kernel.h.
> >
> > Does that help?
>
> no, sorry, doesn't help here ...
>
> nevertheless thanks,
> Herbert

-- 
~Randy
