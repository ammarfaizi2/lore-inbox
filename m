Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262576AbTCITWb>; Sun, 9 Mar 2003 14:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262578AbTCITWb>; Sun, 9 Mar 2003 14:22:31 -0500
Received: from comtv.ru ([217.10.32.4]:20178 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S262576AbTCITWa>;
	Sun, 9 Mar 2003 14:22:30 -0500
X-Comment-To: "Theodore Ts'o"
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Daniel Phillips <phillips@arcor.de>, Alex Tomas <bzzz@tmi.comex.ru>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [Bug 417] New: htree much slower than regular ext3
References: <11490000.1046367063@[10.10.2.4]> <m34r6fyya8.fsf@lexa.home.net>
	<20030307173425.5C4D3FAAAE@mx12.arcor-online.net>
	<20030307232749.GA24572@think.thunk.org>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 09 Mar 2003 22:26:01 +0300
In-Reply-To: <20030307232749.GA24572@think.thunk.org>
Message-ID: <m3d6l0l4ty.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Theodore Ts'o (TT) writes:

 TT> The fix in userspace would be for du and find (the two programs
 TT> most likely to care about this sort of thing) to pull into memory
 TT> a large chunks of the directory at a time, sort them by inode,
 TT> and then stat them in inode order.

in fact, this solution solves problem for filesystems with fixed inodes
placement. for example, this solutions won't work for reiserfs.

