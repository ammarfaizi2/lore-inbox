Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSHaXuf>; Sat, 31 Aug 2002 19:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317341AbSHaXuf>; Sat, 31 Aug 2002 19:50:35 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:16885 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S316204AbSHaXuf>; Sat, 31 Aug 2002 19:50:35 -0400
Date: Sat, 31 Aug 2002 16:50:41 -0700
From: Chris Wright <chris@wirex.com>
To: Gabor Kerenyi <wom@tateyama.hu>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chris@wirex.com>
Subject: Re: extended file permissions based on LSM
Message-ID: <20020831165041.C11165@figure1.int.wirex.com>
Mail-Followup-To: Gabor Kerenyi <wom@tateyama.hu>,
	linux-kernel@vger.kernel.org, Chris Wright <chris@wirex.com>
References: <200208310616.04709.wom@tateyama.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200208310616.04709.wom@tateyama.hu>; from wom@tateyama.hu on Sat, Aug 31, 2002 at 06:16:04AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Gabor Kerenyi (wom@tateyama.hu) wrote:
> Hi!
> 
> I'm looking around the LSM module and I know it has got some
> functions for the filesystem part. Well, it looks good, but the
> permission thing is not enough. In fact it's enough to check
> the permission of an inode, but I'd like to check permissions
> for a dentry AND its inode at the same place and time.

We are anticipating VFS changes that include passing a dentry/vfsmount
pair to the permission check.  This gives you both the inode as well as
the point in the tree the user is accessing the inode.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
