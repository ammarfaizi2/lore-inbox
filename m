Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbULSG5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbULSG5n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 01:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbULSG5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 01:57:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51655 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261273AbULSG5k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 01:57:40 -0500
Date: Sun, 19 Dec 2004 06:57:39 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: Removing i_sock
Message-ID: <20041219065739.GE7113@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The i_sock member of struct inode is redundant with S_ISSOCK(i_mode).
Here's a series of 6 patches to remove it:

http://ftp.linux.org.uk/pub/linux/willy/patches/i_sock/

I'm sending them to their respective maintainers now, and I'll submit
a series after 2.6.10 is out.

Removing i_sock from struct inode actually doesn't reduce the size of
struct inode -- it fits into a gap between two other members.  But it may
help someone else put struct inode on a diet, and it reduces confusion.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
