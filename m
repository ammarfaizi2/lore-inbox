Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbULNSUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbULNSUx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 13:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbULNSUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 13:20:53 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:41369 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261614AbULNSQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 13:16:33 -0500
Date: Tue, 14 Dec 2004 19:16:27 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
cc: Hans Reiser <reiser@namesys.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
In-Reply-To: <1103047919.28291.13.camel@pear.st-and.ac.uk>
Message-ID: <Pine.LNX.4.61.0412141914450.26545@yvahk01.tjqt.qr>
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl> 
 <41ACA7C9.1070001@namesys.com>  <1103043518.21728.159.camel@pear.st-and.ac.uk>
  <Pine.LNX.4.61.0412141812250.5600@yvahk01.tjqt.qr>
 <1103047919.28291.13.camel@pear.st-and.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I don't imagine anyone would miss that behaviour, we can probably have
>something more useful than a
>cat: /etc: Is a directory
>message.

But if /etc can also be a file, cat would not complain!

>ok, I don't really care about the trailing slash. The reading method
>(read() vs. readdir()) may be enough to distinguish the uses. The
>trailing / is still a useful (and logical) visual notation though for
>the different meanings, so something like ls could give both versions.

Yes, indeed the idea itself is good. `ls` uses it to follow symlinks that 
point to directories:

ls -l /U
lrwxrwxrwx  1 root root 35 Dec  6 22:03 /U -> 
/media/usb-0000000000004287:0:0:0p

ls -l /U/
drwxr-xr-x   2 root root  48 Dec  6 14:27 .
drwxr-xr-x  31 root root 824 Dec 14 17:51 ..
-rw-r--r--  1 root root 1614 Dec 12 23:57 tstpasswd

>> What will ls do? 
>list both /etc/passwd and /etc/passwd/ perhaps?

Well, and before ls is tweaked to do so?



Jan Engelhardt
-- 
ENOSPC
