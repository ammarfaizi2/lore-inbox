Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbUDKSwW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 14:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbUDKSwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 14:52:22 -0400
Received: from posti6.jyu.fi ([130.234.4.43]:51879 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S262454AbUDKSwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 14:52:20 -0400
Date: Sun, 11 Apr 2004 21:52:17 +0300 (EEST)
From: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
X-X-Sender: ptsjohol@silmu.st.jyu.fi
To: linux-kernel@vger.kernel.org
Subject: Samba 3.0.2a and smbfs (2.4.21) sometimes missing files (CRITICAL
 BUG)
Message-ID: <Pine.LNX.4.58.0404112150020.19045@silmu.st.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Checked: by miltrassassin
	at posti6.jyu.fi; Sun, 11 Apr 2004 21:52:19 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using the newest Samba 3.0.2a and smbfs which comes in 2.4.21 kernel.
Sometimes or actually always when I copy, rsync or even list files from a
share which resides on NT4 server all the files don't show up (only in
directories which have lots of files >1000 files..)

First I noticed this when I was rsyncing a "mirror" of this share to an
another machine and rsync was deleting some files which still existed in
the NT4-server. After some debugging I made a little test with 'ls -l
/mnt/point/manyfiles | wc -l' and these was the results (no one was using
the share at that time):

2335
2335
2336
2332
2334
2327
2328

This is quite annoying bug. Same thing happens when using smbclient for
example: 'smbclient //192.168.0.1/d$ -U username%password -c "ls
directory/*"|wc -l'

It's quite random which files are missing when doing directory listing. I
also tried to google problem down but nothing more than some random
questions about the same problem without a solution. So could we
investigate this problem more?

(please cc me when replying)

--
Pasi Sjöholm
