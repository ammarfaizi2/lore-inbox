Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVBXDOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVBXDOp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 22:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVBXDNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 22:13:23 -0500
Received: from pagoda.mtholyoke.edu ([138.110.30.68]:13190 "EHLO
	pagoda.mtholyoke.edu") by vger.kernel.org with ESMTP
	id S261761AbVBXDLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 22:11:20 -0500
From: Ron Peterson <rpeterso@mtholyoke.edu>
Date: Wed, 23 Feb 2005 22:11:07 -0500
To: linux-kernel@vger.kernel.org
Subject: ext2/3 files per directory limits
Message-ID: <20050224031107.GA8656@mtholyoke.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Mount Holyoke College
X-Operating-System: Debian GNU/Linux
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to better understand ext2/3's performance characteristics.

I'm specifically interested in how ext2/3 will handle a /var/spool/mail
directory w/ ~6000 mbox format inboxes, handling approx 1GB delivered as
75,000 messages daily.  Virtually all access is via imap, w/ approx
~1000 imapd processes running during peak load.  Local delivery is via
procmail, which by default uses both kernel-supported locking calls and
.lock files.

I understand that various tuning parameters will have an impact,
e.g. putting the journal on a separate device, setting the noatime mount
option, etc.  I also understand that there are other mailbox formats and
other strategies for locating mail spools (e.g. in user's home
directories).

I'm interested in people's thoughts on these issues, but I'm mostly
interested in whether or not the scenario I described falls within
ext2/3's designed capabilities.

Best.

-- 
Ron Peterson
Network & Systems Manager
Mount Holyoke College
http://www.mtholyoke.edu/~rpeterso
