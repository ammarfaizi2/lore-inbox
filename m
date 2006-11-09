Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966042AbWKIQhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966042AbWKIQhJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 11:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966044AbWKIQhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 11:37:08 -0500
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:24733 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S966042AbWKIQhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 11:37:07 -0500
Message-ID: <4553593E.3070202@slaphack.com>
Date: Thu, 09 Nov 2006 10:37:18 -0600
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Suzuki <suzuki@linux.vnet.ibm.com>, reiserfs-list@namesys.com,
       lkml <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: Problem with multiple mounts
References: <45522E67.7050907@linux.vnet.ibm.com> <20061108203323.GA8238@csclub.uwaterloo.ca> <45525C82.5080303@linux.vnet.ibm.com> <20061108230623.GZ6012@schatzie.adilger.int> <20061109151546.GA8236@csclub.uwaterloo.ca>
In-Reply-To: <20061109151546.GA8236@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> On Wed, Nov 08, 2006 at 04:06:23PM -0700, Andreas Dilger wrote:
>> I would suggest that even while this is not supported, it would be prudent
>> to fix such a bug.  It might be possible to hit a similar problem if there
>> is corruption of the on-disk data in the journal and oopsing the kernel
>> isn't a graceful way to deal with bad data on disk.
> 
> On the other hand corrupt data at least doesn't change under you while
> you are trying to figure out the filesystem.

It might.

I'd suspect that there can, in fact, be something done about this, 
assuming good RAM. After all, a corrupt image won't crash a decent web 
browser.

It might sacrifice a ton of performance, though. I suggest it shouldn't 
be a priority to try to figure this out, and if it's ever implemented, 
make it a mount option -- -o paranoid or something. Obviously we don't 
care if a rescue disc takes forever, but we don't want to be waiting for 
hours on our FS boot, which is why I have an initrd mount my Reiser4 FS 
with "-o dont_load_bitmap"

(Yes, I realize the right way to do this is initramfs now. I'm too lazy 
to figure out how to make that work.)
