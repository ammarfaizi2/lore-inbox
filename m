Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266262AbUBDGbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 01:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266268AbUBDGbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 01:31:10 -0500
Received: from thunk.org ([140.239.227.29]:51598 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S266262AbUBDG3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 01:29:53 -0500
Date: Wed, 4 Feb 2004 01:29:37 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: the grugq <grugq@hcunix.net>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
Message-ID: <20040204062936.GA2663@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Pavel Machek <pavel@ucw.cz>, the grugq <grugq@hcunix.net>,
	linux-kernel@vger.kernel.org
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <20040204004318.GA253@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204004318.GA253@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 01:43:18AM +0100, Pavel Machek wrote:
> > All that said, the user's content is something that the user could be 
> > considered responsible for erasing themselves. The meta-data is the part 
> > of the file which they dont' have access to, so having privacy 
> > capabilities for meta-data erasure is a requirement. User data 
> > erasure... I can take it or leave it. I think it should be automatic if 
> > at all, but I'm not really that bothered about it.
> 
> Well, doing it on-demand means one less config option, and possibility
> to include it into 2.7... It should be easy to have tiny patch forcing
> that option always own for your use...

The obvious thing to do would be to make it a mount option, so that
(a) recompilation is not necessary in order to use the feature, and
(b) the feature can be turned on or off on a per-filesystem feature.
In 2.6, it's possible to specify certain mount option to be specifed
by default on a per-filesystem basis (via a new field in the
superblock).  

So if you do things that way, then secure deletion would take place
either if the secure deletion flag is set (so it can be enabled on a
per-file basis), or if the filesystem is mounted with the
secure-deletion mount option.  

					- Ted
