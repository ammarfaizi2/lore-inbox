Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbTKKRJl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 12:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTKKRJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 12:09:40 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36614 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263135AbTKKRJj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 12:09:39 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: reiserfs 3.6 problem with test9
Date: 11 Nov 2003 16:59:05 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bor4gp$cbg$1@gatekeeper.tmr.com>
References: <1068553197.1018.43.camel@Genesyme>
X-Trace: gatekeeper.tmr.com 1068569945 12656 192.168.12.62 (11 Nov 2003 16:59:05 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1068553197.1018.43.camel@Genesyme>,
Philippe  <rouquier.p@wanadoo.fr> wrote:
| Hello,
| recently I noticed some annoying problems whenever I try to access some
| files on my harddrive (reiserfs filesystem). I get "permission denied"
| even if I am the owner or if I try as root. dmesg answers the following
| for every file (so it's repeated):
| 
| is_tree_node: node level 30065 does not match to the expected one 1
| vs-5150: search_by_key: invalid format found in block 2554621. Fsck?
| vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to
| find stat data of [1000086 2592 0x0 SD]
| 
| I rebuilt my filesystem with reiserfsck (3.6.11) and it worked, I could
| read and write again these files. but soon after the rebuilt some other
| files (they were not concerned by this problem before) appeared to have
| the same problem and their number kept growing until I rebuilt again the
| filesystem ... but again new ones appeared after an hour or two ...

Just as a data point, have you tried simply unmounting and remounting
the f/s? If the fsck found anything wrong then I didn't say that, but if
there were no reported errors in the actual f/s then it is possible that
the metadata in memory is being corrupted.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
