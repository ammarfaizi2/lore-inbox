Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbUCARwL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 12:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbUCARwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 12:52:11 -0500
Received: from NS1.idleaire.net ([65.220.16.2]:45987 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S261385AbUCARwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 12:52:10 -0500
Subject: Re: Is the 2.6 dependency information complete? Doesn't look so...
From: Dave Dillow <dave@thedillows.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040301060859.GA2129@mars.ravnborg.org>
References: <20040229235150.GA6327@merlin.emma.line.org>
	 <20040301060859.GA2129@mars.ravnborg.org>
Content-Type: text/plain
Message-Id: <1078163528.22900.17.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 01 Mar 2004 12:52:08 -0500
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Mar 2004 17:52:08.0721 (UTC) FILETIME=[EAA2D810:01C3FFB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-01 at 01:08, Sam Ravnborg wrote:
> On Mon, Mar 01, 2004 at 12:51:50AM +0100, Matthias Andree wrote:
> > Will the kernel rebuild dependent files when includes change when this
> > information is missing? If so, how?
> 
> kbuild scans for dependencies and build the output file in one go.
> Therefore from a make perspective it will not see the new dependency of
> nfsd_idmap.h when starting to compile nfsctl.c.
> 
> Dependencies are first OK after first kernel compile.
> So if you tried twice the 'bk get' functionality should be OK.

Also, the changesets at bk://typhoon.bkbits.net/autoget-2.5 add
functionality to kbuild to checkout needed files automatically, as the
build progresses -- no more 'bk get' needed...

I haven't kept it up to date, but I doubt it'd need many changes to work
with a recent kernel. It's currently BK/SCCS specific, but I do not
think it would be hard to make it work with other version control
systems, as long as make supports them.

Since you do so much in kbuild, I'd love some comments on it, if you
have time.
-- 
Dave Dillow <dave@thedillows.org>

