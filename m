Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbUEFNVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUEFNVM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUEFNUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:20:12 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:30899 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262109AbUEFNTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:19:05 -0400
Date: Thu, 6 May 2004 15:17:31 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Cc: Jamie Lokier <jamie@shareable.org>, Pavel Machek <pavel@ucw.cz>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040506131731.GA7930@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Couldn't sleep last night and finished a first complete version of
cowlinks, code-named MAD COW.  It is still based on the stupid old
design with a flag to distinguish between regular hard links and
cowlinks.  Please don't comment on that design, it's just a proof of
concept.

Patches are against 2.6.5 but most things should apply to other 2.6
kernel without too much trouble.

1 generic_sendpage	- allow sendfile with ext[23] files as target
2 sendfile		- introduce vfs_sendfile for in-kernel use
3 copyfile		- new copyfile() system call
4 lock_flags		- old cruft, just ignore it
5 madcow		- the MAD COW itself

Patches 1-3 will stay, 4 will be remove and 5 replaced by a better
design over time.  I've also set up a webpage for it:
http://wohnheim.fh-wedel.de/~joern/cowlink/

Maybe that should be converted into a wiki so someone with better
taste than myself can improve it.

Jörn

-- 
This above all: to thine own self be true.
-- Shakespeare
