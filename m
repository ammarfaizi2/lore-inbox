Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269770AbUJALv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269770AbUJALv5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 07:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269767AbUJALv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 07:51:57 -0400
Received: from open.hands.com ([195.224.53.39]:23233 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S269764AbUJALvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 07:51:14 -0400
Date: Fri, 1 Oct 2004 13:02:22 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: making an in-memory hashing table ["name" -> ino_t] with thousands of entries
Message-ID: <20041001120222.GA8507@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dear kernel hackers,

i seek advice on how to do an in-kernel lookup table capable of storing
thousands, potentially hundreds of thousands, of entries.

the reason for this is to move the fuse userspace inode lookup
tables into the kernel.

fuse userspace servers have their own in-memory database of
unique inode numbers which represent the file names, and there is a
communication mechanism between userspace and kernelspace that transfers
those inode numbers, amongst other things.

is there any _sane_ way to do this or should i leave the inode lookup
table where it presently is - in userspace?

bearing in mind that for every file accessed via a fuse
filesystem, a cache entry is created, and therefore the number
of entries could potentially run into hundreds of thousands
of entries.

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

