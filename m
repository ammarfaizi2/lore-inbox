Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274698AbRITXYi>; Thu, 20 Sep 2001 19:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274696AbRITXY2>; Thu, 20 Sep 2001 19:24:28 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:38916 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S274710AbRITXYL>; Thu, 20 Sep 2001 19:24:11 -0400
Date: Fri, 21 Sep 2001 01:24:06 +0200 (CEST)
From: eduard.epi@t-online.de (Peter Bornemann)
To: Andreas Dilger <adilger@turbolabs.com>, Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: noexec-flag does not work in Linux 2.4.10-pre10
In-Reply-To: <20010920151708.F14526@turbolinux.com>
Message-ID: <Pine.LNX.4.33.0109210114430.3966-100000@eduard.t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001, Andreas Dilger wrote:


> Are you sure this is actually a problem?  Can you really exec these
> files, or is it just a matter of the flag?  Some changes were made
> to mount flags by Al Viro.  If you really want the flags gone, you
> should use a different umask (e.g. umask=111).  The noexec flag
> means (for filesystems that actually have permissions) that _even if_
> the "x" bit is set, it cannot be executed.

OK copying /bin/ls to /dosc and executing it gives:

peter@eduard:~ > /dosc/ls
bash: /dosc/ls: Keine Berechtigung (no permission)

This is no problem for me but an inconvenience. If You see all
the x-flags You believe in the executability (is that right?), moreover,
as on my system executables are displayed in red colour, I feel my eyes
are deceived to some extent.
But, as umask=111 works, I will switch to that.

Thanks a lot!

Peter B

