Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTI1EXX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 00:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbTI1EXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 00:23:23 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:55736 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262324AbTI1EXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 00:23:22 -0400
Date: Sun, 28 Sep 2003 06:23:21 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Subject: i_nlink of proc root in 2.6
Message-ID: <20030928042321.GA29651@DUK2.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All!

just stumbled over a weird behaviour in 2.6.0-test5 ...

the procfs root directory inode is supposed to show
the number of 'links' according to the subdirectories,
but instead shows the value used for initialization,
although the i_nlink is updated in proc_root_lookup() 

best,
Herbert

----------  should be >= 11
              v
dr-xr-xr-x    2 root     root            0 Sep 28 04:16 .
drwxr-xr-x   14 1000     1000         1024 Jul 13 20:39 ..
dr-xr-xr-x    3 root     root            0 Sep 28 04:16 1
dr-xr-xr-x    3 root     root            0 Sep 28 04:16 10
dr-xr-xr-x    3 root     root            0 Sep 28 04:16 2
dr-xr-xr-x    3 root     root            0 Sep 28 04:16 3
dr-xr-xr-x    3 root     root            0 Sep 28 04:16 4
dr-xr-xr-x    3 root     root            0 Sep 28 04:16 5
dr-xr-xr-x    3 root     root            0 Sep 28 04:16 6
dr-xr-xr-x    3 root     root            0 Sep 28 04:16 7
dr-xr-xr-x    3 root     root            0 Sep 28 04:16 8

