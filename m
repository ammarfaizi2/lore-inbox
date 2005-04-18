Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVDRVsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVDRVsp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 17:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVDRVsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 17:48:45 -0400
Received: from web51303.mail.yahoo.com ([206.190.38.169]:6767 "HELO
	web51303.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261162AbVDRVsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 17:48:36 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=sofFRIsqHoh81Jt9leAXFZQtM97H71LBA1Ya9cTn7brirKQmFxfjiuZwylgRssmvzcyIFjj/ny/U9NN3CuHbmXv6IqpAx1qmjzqdXiK30G3eqUy6KVDEV0PjFNRNAG9lfxfbqS8yJ9DbCUN/jiTehSkWaDyjeQdyRKrRJiOl2l4=  ;
Message-ID: <20050418214835.5311.qmail@web51303.mail.yahoo.com>
Date: Mon, 18 Apr 2005 14:48:35 -0700 (PDT)
From: Pawel Studencki <pstudencki@yahoo.com>
Subject: VFS: Cannot open root device (path_lookup failed)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

I'm trying to mount root filesystem on cramfs (2.6.11,
compiled with mtd and CRAMFS support), however I get
following well known error message:

VFS: Cannot open root device "mtdblock1" or
unknown-block(31,1)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(31,1)

I've found, that funtion "path_lookup" with "/root" 
fails with (-2) when called from
mount_block_root--do_mount_root -- sys_mount(name,
"/root", fs, flags, data);

Could this be a problem with initramfs??? Do I need
initramfs every time to mount later a real root fs?

best regards 
Pawel



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
