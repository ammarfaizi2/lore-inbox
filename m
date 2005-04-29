Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbVD2NUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbVD2NUM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 09:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbVD2NUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 09:20:12 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:50358 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262592AbVD2NTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 09:19:51 -0400
Date: Fri, 29 Apr 2005 09:19:15 -0400
To: Davy Durham <pubaddr2@davyandbeth.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 issue..
Message-ID: <20050429131915.GB2297@csclub.uwaterloo.ca>
References: <4270FA5B.5060609@davyandbeth.com> <20050428200908.GB6669@thunk.org> <42719D5D.5060106@davyandbeth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42719D5D.5060106@davyandbeth.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 09:35:09PM -0500, Davy Durham wrote:
> Well, I don't have the output of the fsck when I did the machine I did 
> it on. And I can't do it on the production machine right now.  Perhaps I 
> can tommorrow if I can talk to the guys about cleaning it off.  I'm a 
> bit afraid to do it, reason being that if it's off on this accounting 
> information, what files/data might I lose if I did an fsck on it 
> (remember, the one I already did it on was empty).
> 
> Also, I did an "e2fsck /home" on the running machine just expecting to 
> get the "warning, don't do this on a mounted file system" prompt, but 
> instead I got:
> 
> # e2fsck /home
> e2fsck 1.34 (25-Jul-2003)
> e2fsck: Is a directory while trying to open /home

/home IS a directory.  You run fsck on the device NOT the mount point.
Remember the filesystem is unmounted or at most mounted readonly when
fsck is run after all.

> The superblock could not be read or does not describe a correct ext2
> filesystem.  If the device is valid and it really contains an ext2
> filesystem (and not swap or ufs or something else), then the superblock
> is corrupt, and you might try running e2fsck with an alternate superblock:
>    e2fsck -b 8193 <device>
> 
> Perhaps it's because it is mounted? (and -b 8193 didn't change 
> anything).  Do I need to do it on the device after unmounting instead? 
> (Probably so)
> 
> I do get the expected warning with fsck itself.  Which should I be 
> using? e2fsck or fsck?

Shouldn't matter as far as I know.  If ext3, perhaps fsck.ext3 is right.
fsck should just figure it out I believe.

> This is kernel-2.6.3-15mdk BTW (mdk 10.0official)
> 
> I'll try to report back tomorrow if I'm able to do anything..

Len Sorensen
