Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbTKDRof (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 12:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTKDRof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 12:44:35 -0500
Received: from pat.uio.no ([129.240.130.16]:53212 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262433AbTKDRoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 12:44:32 -0500
From: Terje Malmedal <terje.malmedal@usit.uio.no>
To: linux-kernel@vger.kernel.org
Subject: directory notification. 
MIME-Version: 1.0
Message-Id: <E1AH5ED-0005Qm-00@aqualene.uio.no>
Date: Tue, 4 Nov 2003 18:44:29 +0100
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Modifications of existing files via NFS are not picked up by the
directory notification system.

kernel is 2.4.22, I'm testing with the example program from
/usr/src/linux/Documentation/dnotify.txt

I get notifications on the following: 
nfs-server# echo hello >> existing.file   
nfs-client# echo hello > new.file

But not on this: 
nfs-client# echo hello >> existing.file 

I guess the problem of detecting changes done via NFS is similar to
the problem of multiple hard-links to the same file, which is
documented as not supported.

Is this something that can be fixed, or is it going to be too
difficult to go from NFS-handle and back to the directory it came
from?

-- 
 - Terje
malmedal@usit.uio.no
