Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266704AbUHQUlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266704AbUHQUlg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268420AbUHQUlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:41:36 -0400
Received: from mail2.aster.pl ([212.76.33.39]:55429 "EHLO mail2.astercity.net")
	by vger.kernel.org with ESMTP id S266704AbUHQUk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:40:57 -0400
From: authn <opacki@acn.waw.pl>
Reply-To: opacki@acn.waw.pl
To: linux-kernel@vger.kernel.org
Subject: Getting the "file struct" problem.
Date: Tue, 17 Aug 2004 22:41:35 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Organization: DsTool Lab
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408172241.35933.opacki@acn.waw.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I need to have a uid of an owner of a some file. And i do like:

struct file *filep;
filep=filp_open(filename, 0, 0);
        if (IS_ERR(filep))
                return -EIO;
And then i just follow by filep->f_dentry->d_inode->i_uid. But this solution 
doesnt work in all cases. The case where it doesnt work is a file with 
permissions like /bin/su
-rws--x--x  1 root bin 35780 Jun 21 21:20 /bin/su*
Where read permission has only root. Then i got I/O error. How to solve it ? 
Maybe there is some other way to get the dentry struct of a file?
-- 
Regards
apacz
