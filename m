Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbUACS5Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 13:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUACS5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 13:57:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17101 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263771AbUACS5N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 13:57:13 -0500
Date: Sat, 3 Jan 2004 18:57:12 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Should struct inode be made available to userspace?
Message-ID: <20040103185712.GV4176@parcelfarce.linux.theplanet.co.uk>
References: <200312292040.00409.mmazur@kernel.pl> <20031229195742.GL4176@parcelfarce.linux.theplanet.co.uk> <bt71ip$cer$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bt71ip$cer$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 01:39:41PM -0500, Bill Davidsen wrote:
> viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> >struct inode and structures containing it should not be used outside of 
> >kernel.
> >Moreover, foo_fs.h should be seriously trimmed down and everything _not_
> >useful outside of kernel should be taken into fs/foo/*; other kernel code
> >also doesn't give a fsck for that stuff, so it should be private to 
> >filesystem
> >instead of polluting include/linux/*.
> 
> Moving the definitions is fine, but some user programs, like backup 
> programs, do benefit from direct interpretation of the inode. Clearly 
> that's not a normal user program, but this information is not only 
> useful inside the kernel.

No, they do not.  They care about on-disk structures, not the in-core
ones fs driver happens to build.
