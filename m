Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267517AbUIJP4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbUIJP4P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267538AbUIJPwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:52:41 -0400
Received: from sccmmhc91.asp.att.net ([204.127.203.211]:62351 "EHLO
	sccmmhc91.asp.att.net") by vger.kernel.org with ESMTP
	id S267497AbUIJPu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:50:58 -0400
Date: Fri, 10 Sep 2004 10:50:40 -0500 (EST)
Message-Id: <20040910.105040.30177815.wscott@bitmover.com>
To: miller@techsource.com
Cc: reiser@namesys.com, Peter.Foldiak@st-andrews.ac.uk, jamie@shareable.org,
       bunk@fs.tum.de, viro@parcelfarce.linux.theplanet.co.uk,
       torvalds@osdl.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
From: Wayne Scott <wscott@bitmover.com>
In-Reply-To: <4141CCA2.9010005@techsource.com>
References: <1094797973.4838.4.camel@almond.st-and.ac.uk>
	<4141504B.8030104@namesys.com>
	<4141CCA2.9010005@techsource.com>
X-Mailer: Mew version 4.0.65 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timothy Miller <miller@techsource.com>
> Everyone likes ':', so we'd have "problem/shoe:size".  (Don't bother to 
> complain about files which have : in them, because I already know it 
> sucks, but it's an example.)

[[ I just joined this discussion, so pardon if this is already known.]]

One advantage of ':' is that portable programs already have to avoid
it because of NTFS alternate data streams:
  http://www.diamondcs.com.au/index.php?page=archive&id=ntfs-streams

For example on an XP box with NTFS:

$ mkdir j
$ cd j
$ echo hi > foo:bar
$ ls -l
total 0
-rw-r--r--    1 wscott   Administ        0 Sep 10 10:45 foo
$ cat foo
$ cat foo:bar
hi
$ rm foo
$ cat foo:bar
cat: foo:bar: No such file or directory

-Wayne
