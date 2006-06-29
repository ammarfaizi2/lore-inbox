Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWF2GL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWF2GL5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 02:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWF2GL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 02:11:57 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:3046 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932534AbWF2GL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 02:11:56 -0400
From: Junio C Hamano <junkio@cox.net>
To: "Joshua Hudson" <joshudson@gmail.com>
Subject: Re: Kernelsources writeable for everyone?!
References: <200606242000.51024.damage@rooties.de>
	<20060624181702.GG27946@ftp.linux.org.uk>
	<1151198452.6508.10.camel@mjollnir> <449E216E.8010508@sbcglobal.net>
	<bda6d13a0606251309x3e07e9feoad777d9a062f923f@mail.gmail.com>
cc: linux-kernel@vger.kernel.org
Date: Wed, 28 Jun 2006 23:11:55 -0700
In-Reply-To: <bda6d13a0606251309x3e07e9feoad777d9a062f923f@mail.gmail.com>
	(Joshua Hudson's message of "Sun, 25 Jun 2006 13:09:09 -0700")
Message-ID: <7v4py4wkwk.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Joshua Hudson" <joshudson@gmail.com> writes:

> I feel like asking how they initially get set to world-writable. To me
> it means that the tree that is being tarred up for distribution is
> world-writible. I sure hope that it is a single-user box.

It is _not_ coming from a working tree at all.

git-tar-tree generates the tar image from a git tree object, and
when it does so, it deliberately sets the mode bits to 0666/0777
so that umask of the people who extract the tarball is honored.
In very early days once we made a mistake of generating the tar
archive with more restrictive permission bits (I think it was
0644 or 0755) which was very impolite way to annoy people with
002 umask.

