Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130105AbRBIKVf>; Fri, 9 Feb 2001 05:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129621AbRBIKVZ>; Fri, 9 Feb 2001 05:21:25 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41488 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130105AbRBIKVH>; Fri, 9 Feb 2001 05:21:07 -0500
Date: Fri, 9 Feb 2001 11:21:03 +0100
From: Jan Kara <jack@suse.cz>
To: Mike Glover <mpg4@duluoz.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: block size for quotas?
Message-ID: <20010209112103.I24444@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010119100231Z129818-469+195@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010119100231Z129818-469+195@vger.kernel.org>; from mpg4@duluoz.net on Fri, Jan 19, 2001 at 02:02:43AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

>    I maintain quotatool, a command-line quota utility.
> Right now, I'm using BLOCK_SIZE -- defined in
> <linux/fs.h> -- to convert between blocks and bytes.
> I'd like to not use the linux header files at all for
> this, but how else can I find the info?
  In current kernel there's no constant specifying quota
blocksize and BLOCK_SIZE is hardcoded into the quota code
so it's fairly reasonable to use that constant for utils...
  (In my patches for new quota format this issue is also
addressed and constant QUOTABLOCK_SIZE is defined).

  I don't know if you know that there's been created
SourceForge project for linux quota utils (project has description
'Linux DiskQuota' and has name 'linuxquota'). If you're
interested you might include your utility to standard
quota utils package (there's setquota utility which should be
command line tool in the package so we might drop setquota
if your util is better :)) BTW: What does your util better
than setquota?)

						Bye
							Honza

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
