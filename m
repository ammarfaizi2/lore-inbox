Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267343AbUBSVbQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267240AbUBSVbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:31:16 -0500
Received: from mta8.srv.hcvlny.cv.net ([167.206.5.75]:17024 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S267343AbUBSVav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:30:51 -0500
Date: Thu, 19 Feb 2004 16:30:41 -0500
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: sysconf - exposing constants to userspace
In-reply-to: <20040219204820.GC9155@sun.com>
To: thockin@sun.com, Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Message-id: <200402191630.47047.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.4
References: <20040219204820.GC9155@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 19 February 2004 15:48, Tim Hockin wrote:
> What is the preferred way to expose "constants" to userland?  I
> quoty-finger "constants" because they may be defined as constants to any
> given kernel, they are not necessarily constant over time.
>
> There are things which can be changed as constants which would currently
> require a libc recompile.  For example NGROUPS_MAX :).  Since it just got
> merged, anyone who wants to use it will have to recompile their libc to get
> the new value of NGROUPS_MAX.
>
> I found an old old patch to do this via read-only sysctl() entries.  Should
> I resurrect that patch?  Or maybe just do a sys_sysconf() entry?  Or should
> I just shut up and tell users to cope with recompiling libc?

I think that making something in /sys would make the most sense, with one 
constant per file. We could dump the consts files to for example /sys/consts, 
or make a logical directory structure to make navigation easier.

Jeff.

- -- 
UNIX is user-friendly ... it's just selective about who it's friends are
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFANSsEwFP0+seVj/4RAgiaAJ9ka5sUjXEE+xNazblPO73/ovnsrACgpZPX
kGZV3gEplJpx24eL62AuQqA=
=3HMU
-----END PGP SIGNATURE-----

