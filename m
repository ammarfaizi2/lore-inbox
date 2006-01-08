Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932738AbWAHS2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738AbWAHS2h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 13:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWAHS2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 13:28:37 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:31279 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S932738AbWAHS2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 13:28:36 -0500
Date: Sun, 08 Jan 2006 13:27:50 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH]: How to be a kernel driver maintainer
In-reply-to: <1136737997.2955.10.camel@laptopd505.fenrus.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Message-id: <1136744870.1043.4.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <1136736455.24378.3.camel@grayson>
 <1136737997.2955.10.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-08 at 17:33 +0100, Arjan van de Ven wrote:
> On Sun, 2006-01-08 at 11:07 -0500, Ben Collins wrote:
> > 
> > +The other side of the coin is keeping changes in the kernel synced to
> > your
> > +code. Often times, it is necessary to change a kernel API (driver
> > model,
> > +USB stack changes, networking subsystem change, etc). These sorts of
> > +changes usually affect a large number of drivers. It is not feasible
> > for
> > +these changes to be individually submitted to the driver maintainers.
> > So
> > +instead, the changes are made together in the kernel tree. If your
> > driver
> > +is affected, you are expected to pick up these changes and merge them
> > with
> > +your primary code (e.g. if you have a CVS repo for maintaining your
> > code).
> > +Usually this job is made easier if you use the same source control
> > system
> > +that the kernel maintainers use (currently, git), but this is not
> > +required.
> 
> I don't quite agree with this part. This encourages cvs use, and "cvs
> mentality". I *much* rather have something written as "the primary
> location of your driver becomes the kernel.org git tree. This may feel
> like you're giving away control, but it's not really. If you maintain
> your driver there, people will still send patches via you for
> approval/review. Of course you can keep a master copy in your own
> version control repository, however be aware that most users will see
> the kernel.org tree one as THE drivers. In addition, merging changes and
> keeping uptodate is a lot harder that way. And worse, keeping the "main"
> version outside the kernel.org tree tends to cause huge deviations and
> backlogs between your main tree and the "real" kernel.org tree, with the
> result that it becomes impossible to find regressions when you DO merge
> the changes over. 

But this isn't at al true. Almost all subsystems maintain the primary
tree outside of the kernel, with the kernel being the primary _stable_
tree. USB, Netdev, Alsa, etc. All changes go someplace else before being
pushed to the primary kernel tree. 99% of the time, patches are going
somewhere else before going into the main kernel. So the above
paragraphs is really misleading.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

