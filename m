Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132165AbRCVTdh>; Thu, 22 Mar 2001 14:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132167AbRCVTd1>; Thu, 22 Mar 2001 14:33:27 -0500
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:20105 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S132165AbRCVTdT>; Thu, 22 Mar 2001 14:33:19 -0500
Date: Thu, 22 Mar 2001 14:32:35 -0500
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, Alexander Viro <viro@math.psu.edu>
Subject: Re: 2.4.2 fs/inode.c
Message-ID: <20010322143234.A25603@cs.cmu.edu>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	alan@lxorguk.ukuu.org.uk, Alexander Viro <viro@math.psu.edu>
In-Reply-To: <20010322134215.A25508@cs.cmu.edu> <20010322190452.C7756@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010322190452.C7756@redhat.com>; from sct@redhat.com on Thu, Mar 22, 2001 at 07:04:52PM +0000
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2001 at 07:04:52PM +0000, Stephen C. Tweedie wrote:
> Hi,
> 
> On Thu, Mar 22, 2001 at 01:42:15PM -0500, Jan Harkes wrote:
> > 
> > I found some code that seems wrong and didn't even match it's comment.
> > Patch is against 2.4.2, but should go cleanly against 2.4.3-pre6 as well.
>  
> Patch looks fine to me.  Have you tested it?  If this goes wrong,
> things break badly...

I've been running it for about a night and a morning now, nothing bad
has happened, my ext2 filesystem shows up clean when forcing a fsck.

If things actually break badly, it is a very serious bug in the
underlying FS. The FS should not 'happen to work' just because the VFS
inadvertedly marked unmodified inodes as being dirty.

Jan

