Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVDLOQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVDLOQQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVDLONC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 10:13:02 -0400
Received: from thunk.org ([69.25.196.29]:22719 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262117AbVDLOIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 10:08:52 -0400
Date: Tue, 12 Apr 2005 10:07:57 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dan Berger <danberger@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error When Booting: Resize Inode Not Valid
Message-ID: <20050412140757.GB9684@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Dan Berger <danberger@gmail.com>, linux-kernel@vger.kernel.org
References: <e3da09a705041205176403fe27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3da09a705041205176403fe27@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 08:17:46AM -0400, Dan Berger wrote:
> Hello. I have recently switched to Linux to prevent any big errors...
> but I guess I just have bad luck :)
> 
> Distro: Fedora Core 3
> Kernel: 2.6.10-1.FC3_770
> File system: ext3
> Mobo: Gigabyte GA7VAXP+
> 
> This morning I went to reboot my machine normally after an 8 day
> uptime. At boot, when it checked the root partition's integrity, I got
> the error "Resize inode not valid" and I was dropped to the repair fs
> console.
> 
> I ran fsck.ext3 numerous times, always answering yes to recreating the
> resize inode... but to no avail. I even tried doing this from FC3's
> rescue CD.

It looks like there is a bug in FC3's e2fsck program which is failing
to fix the filesystem corruption.  (FC3's e2fsck had resize2fs support
more-or-less hacked in, and it didn't support big endian systems, and
it had a whole host of other problems.)

I would recommend upgrading to the latest version of e2fsck (1.37)
which should be able to fix it.  If not, please see the REPORTING BUGS
section of the e2fsck man page to see the sort of information I would
need to see in order to fix it.

Unfortunately, FC3 doesn't have a prebuilt version of the latest
e2fspros, so you would have to build it yourself.  

						- Ted
