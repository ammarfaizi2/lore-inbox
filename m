Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267171AbUGMW3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267171AbUGMW3D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267173AbUGMW3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:29:03 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:36833 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267171AbUGMW24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:28:56 -0400
Date: Tue, 13 Jul 2004 15:28:32 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Waldo Bastian <bastian@kde.org>
Cc: kde-core-devel@kde.org, Tim Connors <tconnors@astro.swin.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: kconfig's file handling (was: XFS: how to NOT null files on fsck?)
Message-ID: <20040713222832.GA7980@taniwha.stupidest.org>
References: <20040713110520.GB8930@ugly.local> <200407131431.43478.bastian@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407131431.43478.bastian@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 02:31:43PM +0200, Waldo Bastian wrote:

> There is nothing to fix, we already use a tempfile + rename, it's in
> KSaveFile since 1999. Or just look with strace if you don't believe
> me. This Tim Connors guy shouldn't talk about things he obviously
> knows nothing about.

How about fsync on the tempfile before the rename?  Without getting
into a religious discussion about whether or not this should be
necessary, it will certainly help in many cases.

> This kind of dataloss is the result of that attitude, either go
> complain with them if it bothers you, or use a filesystem that does
> it right.

I'm not sure people can just change their fs, some people have no
options and for some platforms where KDE is used there might not be
any alternatives.  I really think fsync here would help in most if not
all of those cases and it shouldn't adversely affect the performance
(to the best of my knowledge KDE doesn't update dotfiles all that
often and they are pretty small).  Other applications do this already
and it seems to be very reliable for them.



  --cw

P.S. I'm a bit confused as to why files get smashed on ENOSPC and when
     NFS servers croak though.
