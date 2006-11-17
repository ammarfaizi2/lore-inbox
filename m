Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424810AbWKQA1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424810AbWKQA1H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 19:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424809AbWKQA1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 19:27:07 -0500
Received: from cantor2.suse.de ([195.135.220.15]:58826 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1424806AbWKQA1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 19:27:05 -0500
Message-ID: <455D0230.7040709@suse.com>
Date: Thu, 16 Nov 2006 19:28:32 -0500
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@jeffreymahoney.com>, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>
Subject: Re: [PATCH] ext3: htree entry integrity checking
References: <455C96DC.4060907@jeffreymahoney.com> <20061116222747.GT6012@schatzie.adilger.int>
In-Reply-To: <20061116222747.GT6012@schatzie.adilger.int>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andreas Dilger wrote:
> On Nov 16, 2006  11:50 -0500, Jeff Mahoney wrote:
>>  Currently, if a corrupted directory entry with rec_len=0 is encountered,
>>  we still trust that the data is valid. This can cause an infinite loop
>>  in htree_dirblock_to_tree() since the iteration loop will never make any
>>  progress.
> 
> Actually, I think Eric Sandeen was working on similar fixes already, and
> instead of doing a per-item check each time we look at the entry it does
> a full-block check the first time it is read (as ext2 does).
> 
>>  This fixes the problem described at:
>>  http://projects.info-pull.com/mokb/MOKB-10-11-2006.html
> 
> Would also be good to CC linux-ext4, where the ext3 maintainers live.

Ok, thanks. If that's already in -mm, I'll use that one.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFXQIwLPWxlyuTD7IRApH7AJ9+/SFmd9bf8E741wvxw/6vdrUrdwCeJNEG
eHZMo5RWUrLW5iDEqehjRlI=
=lGRM
-----END PGP SIGNATURE-----
