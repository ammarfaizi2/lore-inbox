Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUHHAmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUHHAmG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 20:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUHHAmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 20:42:06 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13203 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264260AbUHHAmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 20:42:02 -0400
Date: Sat, 7 Aug 2004 17:41:33 -0700
From: Paul Jackson <pj@sgi.com>
To: David Ford <david+challenge-response@blue-labs.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: warning: comparison is always false due to limited range of
 data type
Message-Id: <20040807174133.1e368fbc.pj@sgi.com>
In-Reply-To: <411562FD.5040500@blue-labs.org>
References: <411562FD.5040500@blue-labs.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david+challenge-response@blue-labs.org wrote:
> fs/smbfs/inode.c:563: warning: comparison is always false due to limited 
> range of data type
> fs/smbfs/inode.c:564: warning: comparison is always false due to limited 
> range of data type

You're lucky you're still on the cc list David - please don't use reply
addresses that require editing.

Adding Andi Kleen <ak@muc.de> to cc list - looks from the bk log that he
might have some interest in this.

fs/smbfs/inode.c
  1.46 03/12/01 07:04:55 ak@muc.de[torvalds] +2 -2
  UID16 fixes

bk diffs -r1.45..1.46 fs/smbfs/inode.c
===== fs/smbfs/inode.c 1.45 vs 1.46 =====
554,555c554,555
<               mnt->uid = OLD_TO_NEW_UID(oldmnt->uid);
<               mnt->gid = OLD_TO_NEW_GID(oldmnt->gid);
---
>               SET_UID(mnt->uid, oldmnt->uid);
>               SET_GID(mnt->gid, oldmnt->gid);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
