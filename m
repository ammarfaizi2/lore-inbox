Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290682AbSARMcE>; Fri, 18 Jan 2002 07:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290689AbSARMby>; Fri, 18 Jan 2002 07:31:54 -0500
Received: from tomts6.bellnexxia.net ([209.226.175.26]:2780 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S290682AbSARMbm>; Fri, 18 Jan 2002 07:31:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: o(1) to the rescue
Date: Fri, 18 Jan 2002 07:31:41 -0500
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020118030630.AA34757D57@oscar.casa.dyndns.org> <3C47F716.A192DB3F@aitel.hist.no>
In-Reply-To: <3C47F716.A192DB3F@aitel.hist.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020118123142.4FDD4133BD@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 18, 2002 05:21 am, Helge Hafting wrote:
> Ed Tomlinson wrote:
> > Try this with and without the o(1) scheduler (J0).
> >
> > Create a dir full of 1 meg or so jpegs.  Fire up kde.  Try using the
> > Tools/Create image gallery.
> > With the standard scheduler linux is unusable - it stalls for most of the
> > processing time for
> > each image.   With o(1) its just a little jerky - still usable though (a
> > gallery is building as I
> > type this).
>
> I guess this thing starts a thread per image?  That would
> give a lot of _running_ processes, which is exactly what
> the O(1) scheduler improves.

No.  Just one thread running.  I think its the fact that o(1) detects when
a task is no longer interactive.   KDE is normally very interactive, when
building a gallery parts of it are not.  o(1) detect this and adjusts itself.

This is on a UP K6-III 400 with 512M memory.

Ed Tomlinson
