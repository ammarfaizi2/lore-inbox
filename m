Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUGADZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUGADZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 23:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUGADZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 23:25:59 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:23222 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S263761AbUGADZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 23:25:57 -0400
Subject: Re: Trouble with the filesize limit
From: Steven Newbury <steven.newbury1@ntlworld.com>
To: Eric Lammerts <eric@lammerts.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1088649927.6630.21.camel@timescape.home.snewbury.org.uk>
References: <1088647102.6630.15.camel@timescape.home.snewbury.org.uk>
	 <Pine.LNX.4.58.0406302211490.21486@vivaldi.madbase.net>
	 <1088649927.6630.21.camel@timescape.home.snewbury.org.uk>
Content-Type: text/plain
Message-Id: <1088652347.6630.26.camel@timescape.home.snewbury.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 01 Jul 2004 04:25:48 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-01 at 03:45, Steven Newbury wrote:
> Thanks for the quick response.
> 
> On Thu, 2004-07-01 at 03:21, Eric Lammerts wrote:
> > On Thu, 1 Jul 2004, Steven Newbury wrote:
> > > It isn't possible for me to download more than 2GiB.
> > 
> > > I've tried programs d4x, wget etc., each of them have received a
> > > SIGXFSZ and exited at 2GiB.
> > 
> > Probably none of those apps were compiled with
> > -D_FILE_OFFSET_BITS=64 ...
> > 
> Okay I've recompiled wget with -D_FILE_OFFSET_BITS=64.  Now I've got:
> get: progress.c:706: create_image: Assertion `insz <= dlsz' failed.
> when I try to continue the download...
This, I guess, is a bug in wget.  Are the various types like size_t set
correctly for FILE_OFFSET_BITS=64, or should special care be taken
within each app to ensure types of sufficient size are used?

> 
> > > Strangely I am able to create much larger files with dd.
> > 
> > That one probably is... (the coreutils configure script enables that
> > automatically)
> > 
> > Eric
-- 
Steven Newbury <steven.newbury1@ntlworld.com>

