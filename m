Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264888AbSK0WpE>; Wed, 27 Nov 2002 17:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264889AbSK0WpE>; Wed, 27 Nov 2002 17:45:04 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:62212 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264888AbSK0WpD>;
	Wed, 27 Nov 2002 17:45:03 -0500
Date: Wed, 27 Nov 2002 14:44:20 -0800
From: Greg KH <greg@kroah.com>
To: Kevin Brosius <cobra@compuserve.com>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: hugetlbpage.c build failure?
Message-ID: <20021127224420.GA7187@kroah.com>
References: <3DE54702.44D98750@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DE54702.44D98750@compuserve.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 05:28:18PM -0500, Kevin Brosius wrote:
> I see the following build failure in bk current:

If you get those problems fixed, you're going to need this patch too :)

greg k-h

--- 1.4/fs/hugetlbfs/inode.c	Wed Nov 20 03:19:02 2002
+++ edited/fs/hugetlbfs/inode.c	Wed Nov 27 14:27:02 2002
@@ -209,7 +209,7 @@
 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
 
-	security_ops->inode_delete(inode);
+	security_inode_delete(inode);
 
 	clear_inode(inode);
 	destroy_inode(inode);
@@ -333,7 +333,7 @@
 	if (error)
 		goto out;
 
-	error = security_ops->inode_setattr(dentry, attr);
+	error = security_inode_setattr(dentry, attr);
 	if (error)
 		goto out;
 

