Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262218AbSJATxs>; Tue, 1 Oct 2002 15:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262242AbSJATxs>; Tue, 1 Oct 2002 15:53:48 -0400
Received: from stingr.net ([212.193.32.15]:14855 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S262218AbSJATxr>;
	Tue, 1 Oct 2002 15:53:47 -0400
Date: Tue, 1 Oct 2002 23:59:14 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [STUPID TESTCASE] ext3 htree vs. reiserfs on 2.5.40-mm1
Message-ID: <20021001195914.GC6318@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the stupidiest testcase I've done but it worth seeing (maybe)

We create 300000 files named from 00000000 to 000493E0 in one
directory, then delete it in order.

Tests taken on ext3+htree and reiserfs. ext3 w/o htree hadn't
evaluated because it will take long long time ...

both filesystems was mounted with noatime,nodiratime and ext3 was
data=writeback to be somewhat fair ...

	       	real 	      	user  		sys
reiserfs:
Creating: 	3m13.208s	0m4.412s	2m54.404s
Deleting:	4m41.250s	0m4.206s	4m17.926s

Ext3:
Creating:	4m9.331s	0m3.927s	2m21.757s
Deleting:	9m14.838s	0m3.446s	1m39.508s

htree improved this a much but it still beaten by reiserfs. seems odd
to me - deleting taking twice time then creating ...

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
