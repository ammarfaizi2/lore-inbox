Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWCSTr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWCSTr1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 14:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWCSTr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 14:47:27 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:11155 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750790AbWCSTr0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 14:47:26 -0500
Date: Sun, 19 Mar 2006 19:47:23 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: mingz@ele.uri.edu, mikado4vn@gmail.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: Question regarding to store file system metadata in database
Message-ID: <20060319194723.GA27946@ftp.linux.org.uk>
References: <4ae3c140603182048k55d06d87ufc0b9f0548574090@mail.gmail.com> <441CE71E.5090503@gmail.com> <4ae3c140603190948s4fcd135er370a15003a0143a8@mail.gmail.com> <1142791121.31358.21.camel@localhost.localdomain> <4ae3c140603191011r7b68f4aale01238202656d122@mail.gmail.com> <1142792787.31358.28.camel@localhost.localdomain> <4ae3c140603191050k3bf7e960q9b35fe098e2fbe35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140603191050k3bf7e960q9b35fe098e2fbe35@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2006 at 01:50:22PM -0500, Xin Zhao wrote:
> Last, database-based file system is not so complex. As first step, I
> am just proposing to store pathanem-to-inode number in database. So it
> is basically a simple table. We don't really need any fancy features
> provided by db system. That's why I said a reduced  db system is
> enough. So the only difference betwen db-based file system and a
> regular one is that regular file system use directory file to store
> entries, but db-based file system use database to achieve the same
> goal. Looks like db will be a more efficient way. ;-)

Define "database".  And explain how any of existing filesystems manages
to _not_ qualify your definition.

As for "more efficient"...  300 lookups per second is less than an
improvement.  It's orders of magnitude worse than e.g. ext2; I don't
know in which world that would be considered more efficient, but I
certainly glad that I don't live there.
