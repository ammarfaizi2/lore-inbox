Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281441AbRKPOw6>; Fri, 16 Nov 2001 09:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281442AbRKPOws>; Fri, 16 Nov 2001 09:52:48 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:23289 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S281441AbRKPOwm>; Fri, 16 Nov 2001 09:52:42 -0500
Date: Fri, 16 Nov 2001 14:52:31 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: Bug in ext3
Message-ID: <20011116145231.A6528@redhat.com>
In-Reply-To: <20011115092452.Z329@visi.net> <3BF3F9ED.17D55B35@zip.com.au>, <3BF3F9ED.17D55B35@zip.com.au> <20011115153442.A329@visi.net> <3BF42A1A.5AE96A78@zip.com.au> <20011115160232.H329@visi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011115160232.H329@visi.net>; from bcollins@debian.org on Thu, Nov 15, 2001 at 04:02:32PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 15, 2001 at 04:02:32PM -0500, Ben Collins wrote:
> 
> Seems it does have the field set. I guess the bug is then that if there
> is no journal, then it shoudl fail to mount it, so ext2 will take over.

It _did_ fail to mount it, and ext2 _did_ take over: that's why, when
ext2 found something else wrong with the filesystem, the errors
looked like

  EXT2-fs error (device sd(8,20)): ext2_free_blocks: Freeing blocks not
  in datazone - block = 4294965248, count = 6872

which were marked as ext2 warnings, not ext3 warnings.

Cheers,
 Stephen
