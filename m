Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267296AbUBSOmE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267286AbUBSOlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:41:16 -0500
Received: from web12609.mail.yahoo.com ([216.136.173.179]:2895 "HELO
	web12609.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267288AbUBSOki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:40:38 -0500
Message-ID: <20040219144032.5171.qmail@web12609.mail.yahoo.com>
Date: Thu, 19 Feb 2004 06:40:32 -0800 (PST)
From: Joilnen Leite <pidhash@yahoo.com>
Subject: tmp_dentry dereference ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here i think that d_alloc can return NULL, so
tmp_dentry not use without checked.


fs/cifs/file.c:1251

} else {
      tmp_dentry = d_alloc(file->f_dentry, qstring);
      *ptmp_inode = new_inode(file->f_dentry->d_sb);
      tmp_dentry->d_op = &cifs_dentry_ops;
      cFYI(0, (" instantiate dentry 0x%p with inode
0x%p ",
                tmp_dentry, *ptmp_inode));
      d_instantiate(tmp_dentry, *ptmp_inode);
      d_rehash(tmp_dentry);
}

pub 1024D/5139533E Joilnen Batista Leite 
F565 BD0B 1A39 390D 827E 03E5 0CD4 0F20 5139 533E


__________________________________
Do you Yahoo!?
Yahoo! Mail SpamGuard - Read only the mail you want.
http://antispam.yahoo.com/tools
