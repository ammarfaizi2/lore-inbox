Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271777AbRIYSy6>; Tue, 25 Sep 2001 14:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271769AbRIYSys>; Tue, 25 Sep 2001 14:54:48 -0400
Received: from [195.223.140.107] ([195.223.140.107]:48110 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S271714AbRIYSyc>;
	Tue, 25 Sep 2001 14:54:32 -0400
Date: Tue, 25 Sep 2001 20:55:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bob McElrath <mcelrath@draal.physics.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT as a mount option?
Message-ID: <20010925205512.D8350@athlon.random>
In-Reply-To: <20010925125144.D14612@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010925125144.D14612@draal.physics.wisc.edu>; from mcelrath@draal.physics.wisc.edu on Tue, Sep 25, 2001 at 12:51:44PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 12:51:44PM -0500, Bob McElrath wrote:
> With O_DIRECT (buffer cache bypass open() flag) now in the mainstream
> kernel, I wonder if people would be opposed to making a "direct" mount
> option, which would open all files on the filesystem with the O_DIRECT
> flag, just as there exists a "sync" mount option to perform filesystem
> transactions synchronously.
> 
> This would allow you to 
>     mount -o direct,sync /dev/hdb1 /mnt/video
> And would be useful for things like streaming video applications,
> allowing the advantages of O_DIRECT without rewriting every application
> you want to use.

you've to audit the app anyways since O_DIRECT enforces alignments on
buffer alignment and file offset.

Andrea
