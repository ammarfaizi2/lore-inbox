Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUGAD1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUGAD1O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 23:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUGAD1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 23:27:14 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:53198 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S263772AbUGAD1E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 23:27:04 -0400
Date: Wed, 30 Jun 2004 23:26:57 -0400 (EDT)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: Steven Newbury <steven.newbury1@ntlworld.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Trouble with the filesize limit
In-Reply-To: <1088649927.6630.21.camel@timescape.home.snewbury.org.uk>
Message-ID: <Pine.LNX.4.58.0406302322410.22284@vivaldi.madbase.net>
References: <1088647102.6630.15.camel@timescape.home.snewbury.org.uk> 
 <Pine.LNX.4.58.0406302211490.21486@vivaldi.madbase.net>
 <1088649927.6630.21.camel@timescape.home.snewbury.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Jul 2004, Steven Newbury wrote:
> > Probably none of those apps were compiled with
> > -D_FILE_OFFSET_BITS=64 ...
> >
> Okay I've recompiled wget with -D_FILE_OFFSET_BITS=64.  Now I've got:
> get: progress.c:706: create_image: Assertion `insz <= dlsz' failed.
> when I try to continue the download...

It looks like the progress bar code is not 64-bit clean...  Maybe
you'll have better luck if you turn that off with -q or -nv.

Eric
