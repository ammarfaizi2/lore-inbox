Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263533AbTDGQix (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 12:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263534AbTDGQix (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 12:38:53 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:44674 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S263533AbTDGQiw (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 12:38:52 -0400
Message-ID: <20030407165009.13596.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 07 Apr 2003 11:50:08 -0500
Subject: Re: [PATCH] new syscall: flink
X-Originating-Ip: 172.147.29.243
X-Originating-Server: ws3-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once a process unlinks the last directory entry referencing a particular inode that it has an
open fd for and then passes the open fd to some other process (regardless of exactly how it does that), it seems to me that it has conceded any interest in the previous security constraints associated with that inode or with the recently
unlinked last directory entry for it. If the client process subsequently flink()s to the inode, it is merely a zerocopy file copy.

Since the client owns the new directory entry, it can chmod the inode to have any permissions it wants, create or modify an ACL where ACLs are in use, modify a capabilities mask more fine-grained than traditional unix permissions if something like that is in use, etc.

The cases with potential security implications are all in the context of flink()ing to an open fd for an inode that still corresponds to at least one directory entry.
 
Regards,

Clayton Weaver
<mailto: cgweav@email.com>


-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

