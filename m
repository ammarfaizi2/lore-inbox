Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267664AbUHZGbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267664AbUHZGbz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 02:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267681AbUHZGbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 02:31:55 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:55468 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267664AbUHZGbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 02:31:52 -0400
Message-ID: <412D83D9.2050503@namesys.com>
Date: Wed, 25 Aug 2004 23:31:53 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Waychison <Michael.Waychison@Sun.COM>
CC: Tim Hockin <thockin@hockin.org>, Rik van Riel <riel@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: Using fs views to isolate untrusted processes: I need an assistant
 architect in the USA for Phase I of a DARPA funded linux kernel project
References: <410D96DC.1060405@namesys.com> <Pine.LNX.4.44.0408251624540.5145-100000@chimarrao.boston.redhat.com> <20040825205618.GA7992@hockin.org> <412D0339.3080601@sun.com>
In-Reply-To: <412D0339.3080601@sun.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison wrote:

> Tim Hockin wrote:
>
> >On Wed, Aug 25, 2004 at 04:25:24PM -0400, Rik van Riel wrote:
>
> >>>You can think of this as chroot on steroids.
> >>
> >>Sounds like what you want is pretty much the namespace stuff
> >>that has been in the kernel since the early 2.4 days.
> >>
> >>No need to replicate VFS functionality inside the filesystem.
>
>
> >When I was at Sun, we talked a lot about this.  Mike, does Sun have any
> >iterest in this?
>
>
> Not that I know of.  I believe the functionality Hans is looking for has
> already been handled by SELinux.

Everybody who takes a 3 minute read of SELinux keeps saying it has, but 
it hasn't quite, not when you look at the details.  SELinux is not 
written by filesystem folks, and there are scalability details that matter.

> What is needed (if it doesn't already
> exist) is a tool to gather these 'viewprints' automagically.

It doesn't exist, and viewprints are also not stored with executables 
either, so it is not process oriented.

People think the problem is allowing the OS to enact fine grained 
security.  It is not.  The problem is allowing the user to enact fine 
grained security, and without a lot of work to automate it, users will 
continue to be unable to bear that time cost.

>
> --
> Mike Waychison
> Sun Microsystems, Inc.
> 1 (650) 352-5299 voice
> 1 (416) 202-8336 voice
> http://www.sun.com
>
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> NOTICE:  The opinions expressed in this email are held by me,
> and may not represent the views of Sun Microsystems, Inc.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

