Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWFNOcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWFNOcB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWFNOcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:32:00 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:3475 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964907AbWFNOb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:31:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Lk07PM9W0f/W5S/LFjvWpfx0Zd6yeVcj0+FtLJ8FikvvWLb1qIWLY8Tflr6Fpn3/XiVLf8a7+2NwWXpZp8SD5laKNiOXdOVscFgaNSmXHNnV+ivys1JJy3qndsWLlt6Q986tz4E0aDtA/GLXC0V6fgSx+jburJpL9rw3ufiNKe0=
Message-ID: <986ed62e0606140731u4c42a2adv42c072bf270e4874@mail.gmail.com>
Date: Wed, 14 Jun 2006 07:31:58 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Cc: "Jeff Garzik" <jeff@garzik.org>,
       "Matthew Frost" <artusemrys@sbcglobal.net>,
       "Alex Tomas" <alex@clusterfs.com>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060612220605.GD4950@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44898EE3.6080903@garzik.org>
	 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	 <448997FA.50109@garzik.org> <m3irnacohp.fsf@bzzz.home.net>
	 <44899A1C.7000207@garzik.org> <m3ac8mcnye.fsf@bzzz.home.net>
	 <4489B83E.9090104@sbcglobal.net>
	 <20060609181426.GC5964@schatzie.adilger.int>
	 <4489C34B.1080806@garzik.org> <20060612220605.GD4950@ucw.cz>
X-Google-Sender-Auth: d367599afdd60fb8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/06, Pavel Machek <pavel@ucw.cz> wrote:
> Please don't. AFAIK, ext2/3 is only filesystem with working fsck
> (because that fsck was actually needed in the old days). Starting from
> xfs/jfs/reiser/??? means we no longer have working fsck...

Er, what do you mean by "working fsck"?

Unless I'm misunderstanding something, JFS also has a working fsck
(which has actually performed successful repair of real-world
filesystem corruption for me, although I haven't used it as much as
e2fsck or xfs_repair).

XFS's fsck is a no-op, but I think it could be implemented as a
wrapper around xfs_repair (and maybe xfs_check). xfs_repair has
successfully fixed corrupted filesystems for me, just as JFS's fsck
has.

(As for ReiserFS... well, in the past it's probably been too easy to
shoot yourself in the foot with reiserfsck and make the filesystem
worse-to-nonexistent instead of better. I haven't needed to use
reiserfsck on a corrupt FS lately so I don't know how it compares
these days.)
-- 
-Barry K. Nathan <barryn@pobox.com>
