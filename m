Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266875AbUBGMNp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 07:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266889AbUBGMNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 07:13:45 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:6348 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266875AbUBGMNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 07:13:43 -0500
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: reiser@namesys.com
Content-Type: text/plain
Organization: 
Message-Id: <1076147758.27181.72.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 07 Feb 2004 04:55:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:

> There is an extensive literature on how you can recover
> deleted files from media that has been erased a dozen
> times,

I doubt this is true in any way that matters.

Unless you get REALLY lucky with bad sector
substitution and you know the secret
vendor-specific drive commands to fetch bad
sectors, you'll need the physical hardware.

   no hardware  --->  no data recovery

Given that you do have the physical hardware,
how are you going to read it? You'll need
some equipment that will cost you many millions
of dollars. So this isn't going to be anybody
but the CIA, NSA, or non-US equivelent. They
won't bother very often; even a "black" budget
is limited. Are you so sure you're worth it?

Does the "extensive literature" cover drives
made in the last year? (decade?) These days,
manufacturers are using extremely thin layers
of surface material over an inert substrate.
Magnetic domains flip in an all-or-nothing
fashion; the old recovery methods rely on
finding some buried domains that didn't flip.
With the layers getting damn thin, I doubt
any will exist. There just won't be any
residual signal from previous writes, and so
the recovery methods have nothing to work with.

> but breaking encryption is harder.  It is more
> secure to not put the data on disk unencrypted at all
> is my point.....

This leads to one method of implementing the
secure deletion flag. At boot, generate a
random key for the log file. At file creation,
generate a random key for the file body and
inode. (these are internal to the filesystem)
When you want to destroy something, wipe the key.
Remember to flush and regenerate the log file.


