Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbVIMQwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbVIMQwj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVIMQwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:52:39 -0400
Received: from web30306.mail.mud.yahoo.com ([68.142.200.99]:39086 "HELO
	web30306.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964885AbVIMQwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:52:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=vXfHr0Ytss8PKTp6hhcd3q/UXhmm9xN75IPCdpiZSdwmVZ08NAb7Mj8lF1iXe74YApxRd93NMgPauu4wLLG/R/7lmS6DSCRjK99bqoSX7mNjXZ0THZTIEyw2zzsksMBVgB0pdQ5RcYM2Daa7w4mK/MeZAODFXd0fWf8KZ3Fb8+A=  ;
Message-ID: <20050913165228.57752.qmail@web30306.mail.mud.yahoo.com>
Date: Tue, 13 Sep 2005 09:52:28 -0700 (PDT)
From: Rahul Khanna <rk8k@yahoo.com>
Subject: Parameter corruption (ABI)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have patched 2.6.9 kernel for ABI support. Every
thing works fine except the call to the function
pointed by filldir from fs/ext3/dir.c

All the arguments to the function and their values are
perfect just before the pointed function is called,
but when the same values are printed in the function
they are different.

Error

kernel: ext3-dir->call_filldir: fname->name ftp
fname->inode 5062658 fname->name_len 3, d_type 4
kernel: svr4_filldir: name <NULL>, namlen 5062658,
ino_t 3655193502, d_type 5062658

Following is the code (fs/ext3/dir.c, 413-418)
  while (fname) {
    error = filldir(dirent, fname->name,
        fname->name_len, curr_pos,
        fname->inode,get_dtype(sb,fname->file_type));

How do I go about debugging it further or fixing it?

Thanks,

RK


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
