Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263589AbSKFKLm>; Wed, 6 Nov 2002 05:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263711AbSKFKLm>; Wed, 6 Nov 2002 05:11:42 -0500
Received: from pc-80-195-35-58-ed.blueyonder.co.uk ([80.195.35.58]:57472 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S263589AbSKFKLl>; Wed, 6 Nov 2002 05:11:41 -0500
Date: Wed, 6 Nov 2002 10:18:06 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Christopher Li <chrisl@vmware.com>
Cc: "'Jens Axboe '" <axboe@suse.de>,
       "'Linux Kernel '" <linux-kernel@vger.kernel.org>,
       "'ext2-devel@lists.sourceforge.net '" 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: 2.5.46 ext3 errors
Message-ID: <20021106101806.B2663@redhat.com>
References: <3C77B405ABE6D611A93A00065B3FFBBA36A493@PA-EXCH2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C77B405ABE6D611A93A00065B3FFBBA36A493@PA-EXCH2>; from chrisl@vmware.com on Wed, Nov 06, 2002 at 01:43:45AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 06, 2002 at 01:43:45AM -0800, Christopher Li wrote:
> Can you put the e2image of that device to some URL I can
> download?

It's unlikely to be useful.  A journal abort will cause existing
transactions to be suspended midstream, so any errors afterwards may
be due to updates which were in progress at the time and which didn't
complete.  And since a fsck has been done, we've lost those errors
anyway.

Is the problem reproducible?  The basic

> EXT3-fs error (device ide1(22,1)): ext3_new_inode: Free inodes count
> corrupted in group 688 Aborting journal on device ide1(22,1).

error is just ext3's normal reaction to a fatal error detected in the
filesystem, so that in itself isn't a worry.  The cause of the problem
it spotted is the worry; is this reproducible?

Cheers,
 Stephen
