Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbUC2UvQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 15:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUC2UvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 15:51:16 -0500
Received: from DESLAB.MIT.EDU ([18.38.0.40]:41735 "EHLO deslab.mit.edu")
	by vger.kernel.org with ESMTP id S262134AbUC2UvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 15:51:10 -0500
Date: Mon, 29 Mar 2004 15:51:09 -0500
From: "F. Baker" <baker@deslab.mit.edu>
Message-Id: <200403292051.i2TKp9dd027008@deslab.mit.edu>
To: linux-kernel@vger.kernel.org
Subject: nfs errors with xfs filesystem (2.4.x kernel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have several Linux x86 workstations here.  In "dmesg" on
these PCs I see a lot of errors that read:

NFS: Server wrote less than requested.

 AND

eth0: TX underrun, threshold adjusted.

This message appears whenever someone logged into the
Mandrake/RH/whatever box (with NFS autofs mounting in his/her home
directory) tries to write something to an nfs-mounted directory
(usually the home directory).  Even small files of 1.5 MB or so often
generate something such as "I/O error" when saving a file (really 
small files usually get saved fine).  And the home directory is always
based in an SGI (O2, Indy, Onyx) with xfs file system. 

Intra-SGI these transfer take place perfectly, but
Mandrake/RH/OtherLinux generates these problems.

Has anyone seen this error before and does anyone know how 
to get around it?  The kernel used is 2.4.22-28 for most
of the Mandrake boxes, or at least 2.4.x anyway.  We have not
gone to 2.6.x yet.

Thanks in advance.

baker@deslab.mit.edu

PS: Interestingly:

	cp file1 file2
where file1 is sufficiently large (1 MB or bigger) always fails the 
first time, but often does a partial write.  

If you then delete file2 and try the command anew, it works fine.
Very strange indeed.

