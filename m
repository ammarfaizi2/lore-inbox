Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbTHaU27 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 16:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbTHaU26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 16:28:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13115 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262661AbTHaU25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 16:28:57 -0400
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Ed Sweetman <ed.sweetman@wmich.edu>, Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC] extents support for EXT3
References: <m3vfsgpj8b.fsf@bzzz.home.net> <3F4F76A5.6020000@wmich.edu>
	<m3r834phqi.fsf@bzzz.home.net> <3F4F7D56.9040107@wmich.edu>
	<m3isogpgna.fsf@bzzz.home.net> <3F4F923F.9070207@wmich.edu>
	<m3ad9snxo6.fsf@bzzz.home.net> <3F4FAFA2.4080202@wmich.edu>
	<20030829213940.GC3846@matchmail.com> <3F4FD2BE.1020505@wmich.edu>
	<20030829231726.GE3846@matchmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <20030829231726.GE3846@matchmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Date: 31 Aug 2003 14:25:49 -0600
Message-ID: <m18yp9r2uq.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> writes:

> On Fri, Aug 29, 2003 at 06:25:02PM -0400, Ed Sweetman wrote:
> > you get no real slowdown as far as rough benchmarks are concerned, 
> > perhaps with a microbenchmark you would see one and also, doesn't it 
> > take up more space to save the extent info and such? Either way, all of 
> > it's real benefits occur on large files.
> 
> IIRC, if your blocks are contiguous, you can save as soon as soon as the
> file size goes above one block (witout extents, the first 12 blocks are
> pointed to by what?  I forget... :-/ )

They are pointed to directly from the inode.

In light of other concerns how reasonable is a switch to e2fsck that
will remove extents so people can downgrade filesystems?

Also given the incompatibility on the file format any chance of this
being developed as ext4?

Eric
