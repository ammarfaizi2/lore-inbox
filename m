Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269000AbVBEOUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269000AbVBEOUS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 09:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269018AbVBEOUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 09:20:17 -0500
Received: from news.suse.de ([195.135.220.2]:2994 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269000AbVBEOUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 09:20:10 -0500
Subject: Re: ext3 extended attributes refcounting wrong?
From: Andreas Gruenbacher <agruen@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>
In-Reply-To: <200502051239.j15CdJc8020766@harpo.it.uu.se>
References: <200502051239.j15CdJc8020766@harpo.it.uu.se>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1107613200.27797.5.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 05 Feb 2005 15:20:00 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-05 at 13:39, Mikael Pettersson wrote:
> [...] It does not explain why 2.6 allocated
> the xattr blocks in the first place; as I wrote initially, I
> have disabled the xattrs stuff:
> 
> CONFIG_EXT3_FS=y
> # CONFIG_EXT3_FS_XATTR is not set

The filesystem in question must have been used with a kernel that was
xattr aware once. You could also have been using ext2. Maybe you ran
selinux at some point, or similar. Can you boot into a kernel with
CONFIG_EXT3_FS_XATTR enabled, and ``getfattr -m- -d -R .'' on the
filesystem in question? This gives you a full xattr dump.

Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

