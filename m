Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUD1VNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUD1VNH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUD1VKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 17:10:54 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:59035 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262134AbUD1U70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 16:59:26 -0400
Date: Wed, 28 Apr 2004 14:59:23 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Vineet Joglekar <vintya@excite.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How can I allocate few bytes to a file to store info about that file?
Message-ID: <20040428205923.GI1521@schnapps.adilger.int>
Mail-Followup-To: Vineet Joglekar <vintya@excite.com>,
	linux-kernel@vger.kernel.org
References: <20040428201405.5CC7EC01E@xprdmailfe13.nwk.excite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040428201405.5CC7EC01E@xprdmailfe13.nwk.excite.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 28, 2004  16:14 -0400, Vineet Joglekar wrote:
> I was going through the functions like generic_file_write,
> generic_file_direct_IO, generic_direct_IO and filemap_fdatasync. I was
> thinking about calling these functions or calling functions written on
> similar lines to add new few bytes to the file when the inode is created
> by "ext2_create()". Can any1 please tell me how to do this? What I mean
> is, I want to add few bytes to the file as soon as it is created. I want
> to store some information regarding the file in that area.

See sys_setxattr().  You need support for extended attributes in your kernel
and filesystem.  This includes ext2/ext3 for 2.6, but only if you apply a
patch for 2.4 I believe.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

