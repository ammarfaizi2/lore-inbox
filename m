Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbULGWWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbULGWWL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 17:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbULGWWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 17:22:11 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:54694 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261943AbULGWWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 17:22:08 -0500
Subject: backing_dev_info == 8?!
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1102457906.5879.7.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 08 Dec 2004 09:18:26 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Running 2.6.9, I sometimes get oopses in what I think is called VFS
related code (struct inode, dentry and so on). Last night, for example,
I saw an oops in file_ra_state_init which occurred because the
backing_dev_info being dereferenced was set to 0x8. Everything else in
the struct looked normal, and related structs with backing_dev_info also
had the value set to 8. (The oops occurred in process locate, called via
sys_open). My question, then, is "Does anyone know if any bugs related
to this have been found/fixed since 2.6.9?". I'm considering running BK
for a while and seeing if it's still there.

The kernel isn't vanilla, but I don't think any of the additions
(Win4Lin, kgdb, suspend2, bootsplash) are affecting this.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

