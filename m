Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWAAI44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWAAI44 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 03:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWAAI44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 03:56:56 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:8972 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S932188AbWAAI4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 03:56:55 -0500
Date: Sun, 1 Jan 2006 16:55:59 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Question about vfsmount test in __do_follow_link
Message-ID: <Pine.LNX.4.63.0601011647520.25935@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In __do_follow_link I see

if (path->mnt == nd->mnt)
	mntget(path->mnt);

immediately before

cookie = dentry->d_inode->i_op->follow_link(dentry, nd);

I can't see the case where the vfsmount is ever different. This would have 
to mean a mount was followed but this shouldn't be possible for a 
symlink?

Can someone enlighten me?

Ian


