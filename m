Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262138AbSJJSyy>; Thu, 10 Oct 2002 14:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262139AbSJJSyy>; Thu, 10 Oct 2002 14:54:54 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:26042 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262138AbSJJSyx>;
	Thu, 10 Oct 2002 14:54:53 -0400
Date: Thu, 10 Oct 2002 15:00:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
Subject: [LART] inode mismanagement in hugetlb code
Message-ID: <Pine.GSO.4.21.0210101447390.13421-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[A discussion of the meanings of the terms "MUST", "SHOULD", and "MAY" appears
in RFC-1123; the terms "MUST NOT" and "SHOULD NOT" are logical extensions of
this usage]

	a) inodes MUST have an address of valid struct super_block in their
->i_sb.  Had been discussed quite a few times already.

	b) inodes MUST NOT be allocated by code that isn't called from
alloc_inode().

	c) inodes SHOULD NOT be kept around for noticable intervals without
a dentry pointing to them.

	d) people who choose variable names like htlbpagek SHOULD be sent to
produce a street map of R'Lyeh.  On site.

