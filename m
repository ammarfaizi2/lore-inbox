Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbVG2PEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVG2PEB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 11:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbVG2PEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 11:04:01 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:16663 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262611AbVG2PCz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 11:02:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=b0VIcmasoks6rDAXpr1NvjVkeAkWueqTQSYqONWQ6eMRkn5mBh6b/43ctQaLxWLHfp4aCps/kZ+iI2Qz7rW7iMiHinstCpGzUl338Ra3njKlOk4i/46DXyzT/UcWv8ZNV7e0F5OsOFuJXJFtkSbf9PfwRcl5zNyeA/xneUNxLGw=
Message-ID: <615cd8d10507290802690dd50f@mail.gmail.com>
Date: Fri, 29 Jul 2005 23:02:53 +0800
From: =?BIG5?B?vFi50w==?= <brianhsu.hsu@gmail.com>
Reply-To: =?BIG5?B?vFi50w==?= <brianhsu.hsu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How to get dentry from inode number?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, every body.

How can I get a full pathname from an inode number ? (Our data
structure only keep track inode number instead of pathname in
order to keep thin, so don't have any information but inode
number.)

I used iget_locked() to get a struct inode * from an inode number,
and use d_find_alias() to get a dentry, finally use d_path() to get
a absoulte path to the file.

But it only works when I opened the target file before I run
my program, or the d_find_alias() will return NULL.

I also tried d_alloc_anno() and d_splice_alias(), but it crashed
in the d_splice_alias().

So, which function should I check to find the answer?
