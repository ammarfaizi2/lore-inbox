Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280984AbRKOWF3>; Thu, 15 Nov 2001 17:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281125AbRKOWFV>; Thu, 15 Nov 2001 17:05:21 -0500
Received: from ppp01.ts1-1.NewportNews.visi.net ([209.8.196.1]:14332 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S280971AbRKOWFJ>; Thu, 15 Nov 2001 17:05:09 -0500
Date: Thu, 15 Nov 2001 17:04:59 -0500
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in ext3
Message-ID: <20011115170459.I329@visi.net>
In-Reply-To: <20011115092452.Z329@visi.net> <3BF3F9ED.17D55B35@zip.com.au>, <3BF3F9ED.17D55B35@zip.com.au> <20011115153442.A329@visi.net> <3BF42A1A.5AE96A78@zip.com.au>, <3BF42A1A.5AE96A78@zip.com.au> <20011115160232.H329@visi.net> <3BF42F47.FA3B7657@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BF42F47.FA3B7657@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 01:10:31PM -0800, Andrew Morton wrote:
> 
> Are you running a current version of e2fsprogs?  1.25?
> 
> If you are, then this indicates that the filesystem has has_journal
> set, but it doesn't have a journal inode.  That is certainly something
> which e2fsck should detect and fix.  This may be a fsck bug.
> 
> You should be able to fix this with `tune2fs -O ^has-journal' on
> the unmounted or readonly fs.

Actually, it's 1.18. I'll upgrade e2fsprogs. At the same time, would it
not be prudent to make ext3 fail to mount if it cannot setup the
journal? If it decides to keep going in the event that there is no
journal, it should not break like it did.


Ben

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
