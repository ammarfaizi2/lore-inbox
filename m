Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVCUK2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVCUK2S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 05:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVCUK2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 05:28:18 -0500
Received: from viking.sophos.com ([194.203.134.132]:19972 "EHLO
	viking.sophos.com") by vger.kernel.org with ESMTP id S261543AbVCUK2Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 05:28:16 -0500
MIME-Version: 1.0
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 21/03/2005 10:28:09,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 21/03/2005 10:28:09,
	Serialize complete at 21/03/2005 10:28:09,
	S/MIME Sign failed at 21/03/2005 10:28:09: The cryptographic key was not
 found,
	S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 21/03/2005 10:28:13,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 21/03/2005 10:28:13,
	Serialize complete at 21/03/2005 10:28:13,
	S/MIME Sign failed at 21/03/2005 10:28:13: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.2|June 01, 2004) at
 21/03/2005 10:28:15,
	Serialize complete at 21/03/2005 10:28:15
To: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: do_umount strangeness?
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFF0330A99.549BE659-ON80256FCB.0039601E-80256FCB.0039842A@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Mon, 21 Mar 2005 10:28:13 +0000
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Reposted due to wrong LKML address, sorry Al]

Hi,

Looking at linux-2.6.11/fs/namespace.c line 418:

if (mnt == current->fs->rootmnt && !(flags & MNT_DETACH)) {
     /*
        * Special case for "unmounting" root ...

I wonder is this really a test for root? Couldn't the current->fs->rootmnt 
"point" somewhere else if per-process namespaces are used? Is it intended 
that processes can't umount their own root, or better to say, to only be 
able to remount it read-only?


