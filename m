Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265516AbUBAXYu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 18:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265514AbUBAXYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 18:24:49 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:30731 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S265531AbUBAXYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 18:24:46 -0500
Date: Mon, 2 Feb 2004 00:24:42 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Andreas Gruenbacher <agruen@suse.de>, morgan@transmeta.com,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: permission() bug?
Message-ID: <20040202002442.A28165@pclin040.win.tue.nl>
References: <1075638996.2424.13.camel@nb.suse.de> <20040201131457.2cf44e4c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040201131457.2cf44e4c.akpm@osdl.org>; from akpm@osdl.org on Sun, Feb 01, 2004 at 01:14:57PM -0800
X-Spam-DCC: COLLEGEOFNEWCALEDONIA: mailhost.tue.nl 1189; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 01:14:57PM -0800, Andrew Morton wrote:

> >  the fix for permission() that makes it compliant with POSIX.1-2001
> 
> Question is: should we fix it?  I'm not aware of any bug reports against
> this behaviour, and there is the possibility that changing it now will
> break some applications.

Quite apart from this particular case, the general answer to such questions
should be Yes.

It must not be the case that Linux is roughly speaking POSIX-conforming
but deviates in a thousand obscure ways.

When a deviation is noticed, changing to be POSIX-conforming should
be the default action. Of course, some POSIX requirements are rather
unfortunate, and in individual cases there can be a good reason
not to change. Such individual cases should be discussed and well documented.

In a case like this, where it is clear that Linux is buggy, the bug
should just be fixed.  Of course it is your call to choose between
fixing a bug and keeping a stable interface.  If you choose the latter
this must be fixed in 2.7.

(By the way - 2.0.34 and 2.2.19 do not have this bug, 2.4.18 has.)


Andries
