Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUG2Ugh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUG2Ugh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 16:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265247AbUG2Ugh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 16:36:37 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:9863 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265207AbUG2Ugf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 16:36:35 -0400
Date: Thu, 29 Jul 2004 15:37:18 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] sysfs backing store (Re-splitted)
Message-ID: <20040729203718.GB4592@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

As per Viro's suggestions I have re-splitted the sysfs backing store 
patch set. This splitting is more meaningful and it should make the 
long pending review more interesting. There are no significant changes 
in the code except some cosmetic code re-arrangement and a couple of 
real changes in the error paths.

1) In fs/sysfs/dir.c:create_dir(), dput() was missing if we fail in
   sysfs_new_dirent()

2) Check for kmalloc() return value in fs/sysfs/symlink.c:sysfs_add_link().

I hope Viro will do the review soon. In the mean time I thought it will be 
nice if you could _replace_ the sysfs patches (six patches with names 
sysfs-leaves-xxx.patch) with the following patches (mailed separately). 
I will update them again based on the comments I get. 

Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896
