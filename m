Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWF3POk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWF3POk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 11:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWF3POk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 11:14:40 -0400
Received: from thunk.org ([69.25.196.29]:61845 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750981AbWF3POj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 11:14:39 -0400
Date: Fri, 30 Jun 2006 11:14:32 -0400
From: Theodore Tso <tytso@mit.edu>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Proposal and plan for ext2/3 future development work
Message-ID: <20060630151432.GA21675@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <E1Fvjsh-0008Uw-85@candygram.thunk.org> <p73sllnvsej.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73sllnvsej.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 12:39:48PM +0200, Andi Kleen wrote:
> "Theodore Ts'o" <tytso@mit.edu> writes:
> > 
> > 1) The creation of a new filesystem codebase in the 2.6 kernel tree in
> > /usr/src/linux/fs/ext4 that will initially register itself as the
> > "ext3dev" 
> 
> Why not call it ext4 from the beginning too? Calling the directory
> differently from the file system can only cause confusion.
> 
> I assume if it's marked very experimental people who value their data
> will avoid it for the time being.

There were a lot of people who were concerned that simply marking it
CONFIG_EXPERIMENTAL might not be enough for to make it very clear that
the filesystem format is still changing.  In order to address this
concern, we want /etc/fstab to make it abundantly clear that the
filesystem format itself is not necessarily stable, and that new
features are being added that might not be supported on older
kernels.

In general the same old rules will apply in that unless you explicitly
enable a feature via tune2fs or at mke2fs-time, it should work on
older kernels (just as in theory all of the kernel code that we are
throwing willy-nilly into userpsace is **supposed** to be forward
compatible), but if we paint ourselves in the a corner, there may be a
reason why we have to break that compatibility promise.

							- Ted
