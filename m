Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263455AbTEGUJG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 16:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbTEGUJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 16:09:06 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:922 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263455AbTEGUJF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 16:09:05 -0400
Subject: [RFC] SELinux security module 2.5.69
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@digeo.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Chris Wright <chris@wirex.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1051817849.1377.372.camel@moss-huskers.epoch.ncsc.mil>
References: <1051817849.1377.372.camel@moss-huskers.epoch.ncsc.mil>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1052338851.1044.151.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 May 2003 16:20:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am again requesting comments on the SELinux module prior to submitting
it.  An updated version of the SELinux module for 2.5.69 is now
available from http://www.nsa.gov/selinux/lk/A07selinux.patch.gz.  This
patch only modifies the security/ directory, updating its Makefile and
Kconfig and adding the selinux subdirectory and files under it.  As with
the prior RFC posting, this patch depends on the A0[1-6]*.patch.gz
patches in the same directory that have been separately submitted, and
the full patch against 2.5.69 is
http://www.nsa.gov/selinux/lk/2.5.69-selinux1.patch.gz.   Some
corresponding userland components are contained in
http://www.nsa.gov/selinux/lk/selinux-2.5.tgz.

Changes since the prior RFC posting include:
- Flattened the include hierarchy under security/selinux
- Dropped the special handling of proc inode labeling, to be
  revisited later as a separate patch, possibly via xattr handlers
  in the virtual filesystems to support security labeling. 
- Dropped avc_d_path. 
- Various code cleanups.

As before, documentation of SELinux can be found at
http://www.nsa.gov/selinux/docs.html.  That documentation does not
reflect the changes to the SELinux API and implementation that we have
been making in preparing for submission to mainline 2.5, but is useful
in understanding the architecture and design.  Background information
for the SELinux project is available at
http://www.nsa.gov/selinux/background.html.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

