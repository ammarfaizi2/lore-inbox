Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269999AbRHJT7L>; Fri, 10 Aug 2001 15:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270000AbRHJT7C>; Fri, 10 Aug 2001 15:59:02 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:23567 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269999AbRHJT6p>; Fri, 10 Aug 2001 15:58:45 -0400
Message-ID: <3B743E4B.DA2573F3@zip.com.au>
Date: Fri, 10 Aug 2001 13:04:27 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Alexander Viro <viro@math.psu.edu>,
        Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, lvm-devel@sistina.com,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: [PATCH] LVM snapshot support for reiserfs and others
In-Reply-To: <Pine.GSO.4.21.0108091856020.25945-100000@weyl.math.psu.edu> <992230000.997472946@tiny>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> 
> Hi guys,
> 
> Here's a new patch against 2.4.8-pre8, updated to Al's new super
> handling.  The differences between the original are small,
> but they are big enough that I want extra testing from the
> LVM guys (and ext3/XFS).

ext3 will probably lock up on unmount with 2.4.8-pre8.  The fix is
to replace fsync_dev with fsync_no_super in fs/ext3/super.c and
fs/jbd/recovery.c.  I'll be generating a new patchset this weekend.

-
