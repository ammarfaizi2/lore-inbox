Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbTJNHMy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 03:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbTJNHMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 03:12:53 -0400
Received: from a0.complang.tuwien.ac.at ([128.130.173.25]:50703 "EHLO
	a0.complang.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262237AbTJNHMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 03:12:52 -0400
X-mailer: xrn 9.03-beta-14
From: anton@mips.complang.tuwien.ac.at (Anton Ertl)
Subject: Re: ReiserFS patch for updating ctimes of renamed files
To: linux-kernel@vger.kernel.org
X-Newsgroups: linux.kernel
In-reply-to: <Gr0H.1ol.5@gated-at.bofh.it>
Date: Tue, 14 Oct 2003 06:57:17 GMT
Message-ID: <2003Oct14.085717@a0.complang.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser:
>Andrew Morton wrote:
>>Yes, John has a point but we're not going to go and change all the other
>>filesystems (are we?).
>>
>why not?  It is correct therefor....

Many years ago we had the same problem with ext2: it did not change
ctime on rename, so GNU tar did not pick up the renamed files on
incremental backup.  Fortunately a few kernel versions later ext2
changed to the current behaviour (unfortunately I don't remember the
kernel version).

IIRC our sysadmin submitted a bug report for GNU tar at the time, and
got the answer that GNU tar would not change.

- anton
-- 
M. Anton Ertl                    Some things have to be seen to be believed
anton@mips.complang.tuwien.ac.at Most things have to be believed to be seen
http://www.complang.tuwien.ac.at/anton/home.html
