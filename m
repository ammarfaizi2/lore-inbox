Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264431AbTK0EJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 23:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbTK0EJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 23:09:59 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:31001 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S264431AbTK0EJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 23:09:58 -0500
Message-Id: <5.1.0.14.2.20031127150548.037ea008@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 27 Nov 2003 15:09:51 +1100
To: Neil Brown <neilb@cse.unsw.edu.au>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: md/raid devices don't show up in /proc/partitions in 2.6
  :-(
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <16325.16910.697589.124844@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:15 AM 27/11/2003, Neil Brown wrote:
>I just noticed that md devices do not show up in /proc/partitions in
>2.6.
[..]

this also caused no end of badness trying to migrate from LVM2 (Linux 2.4) 
to DM+LVM2 (Linux 2.6) where the major/minor numbers changed.

while the real fix is to educate lvmcreate_initrd to be more intelligent (i 
had to create a new one which includes 
mknod/devmap_mknod.sh/mkdir/sed/rm/cat/lvdisplay binaries), it is certainly 
a big trap for the unwary that happen to use LVM1/LVM2 as a root volume.


cheers,

lincoln.

