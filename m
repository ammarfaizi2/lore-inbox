Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269643AbUICMRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269643AbUICMRH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269632AbUICMRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:17:07 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:20685 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S269645AbUICMM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:12:26 -0400
Message-ID: <41385FA5.806@cs.aau.dk>
Date: Fri, 03 Sep 2004 14:12:21 +0200
From: =?ISO-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040619)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: umbrella-devel@lists.sourceforge.net
Subject: Getting full path from dentry in LSM hooks
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a short question, concerning how to get the full path of a file 
from a LSM hook.

- If the "file" of the dentry is located in the root filesystem: no
   problem - simply traverse the dentrys, to generate the path.

- If the "file" is mounted from another partition, you do not get the
   full path by traversing the dentrys.

Example:
If we have a system with a normal root (/) and a seperate boot partition 
(mounted on /boot :). In the LSM hook inode_permission, you get the 
arguments (struct inode *inode, int mask, struct nameidata *nd).
Finding the path, we traverse the dentrys from (nd->dentry). But if the 
inode is a file in /boot we only get the filename (e.g. kernel-2.6.8.1 
instead of /boot/kernel-2.6.8.1)


Can some one reveal the trick to get the full path nomater if the 
filesystem is root or mounted elsewhere in the filesystem?


Best regards,
Kristian Sørensen.
The Umbrella Project -- http://umbrella.sf.net
