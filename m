Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbTGCRbf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 13:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265090AbTGCRbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 13:31:35 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:60414 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S265086AbTGCRbc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 13:31:32 -0400
Subject: [PATCH] Add SELinux module to 2.5.74-bk1
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Chris Wright <chris@wirex.com>,
       James Morris <jmorris@intercode.com.au>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1057254295.1110.1016.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Jul 2003 13:44:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch against 2.5.74-bk1 available from
http://www.nsa.gov/selinux/lk/2.5.74-bk1-selinux.patch.gz adds the
SELinux module to the tree and modifies the security/Makefile and
security/KConfig files for SELinux.  The last dependency for SELinux,
the vm_enough_memory security hook, was included in -bk1.  Please
consider applying.  Thanks.  diffstat output is below.  

-----

 Kconfig                                 |    2 
 Makefile                                |    6 
 selinux/Kconfig                         |   34 
 selinux/Makefile                        |   10 
 selinux/avc.c                           | 1144 ++++++++++
 selinux/hooks.c                         | 3373 ++++++++++++++++++++++++++++++++
 selinux/include/av_inherit.h            |   37 
 selinux/include/av_perm_to_string.h     |  122 +
 selinux/include/av_permissions.h        |  550 +++++
 selinux/include/avc.h                   |  234 ++
 selinux/include/avc_ss.h                |   81 
 selinux/include/class_to_string.h       |   39 
 selinux/include/common_perm_to_string.h |   65 
 selinux/include/flask.h                 |   71 
 selinux/include/flask_types.h           |   73 
 selinux/include/initial_sid_to_string.h |   32 
 selinux/include/objsec.h                |   87 
 selinux/include/security.h              |  180 +
 selinux/selinuxfs.c                     |  592 +++++
 selinux/ss/Makefile                     |   14 
 selinux/ss/avtab.c                      |  273 ++
 selinux/ss/avtab.h                      |   82 
 selinux/ss/constraint.h                 |   62 
 selinux/ss/context.h                    |  131 +
 selinux/ss/ebitmap.c                    |  344 +++
 selinux/ss/ebitmap.h                    |   57 
 selinux/ss/global.h                     |   19 
 selinux/ss/hashtab.c                    |  310 ++
 selinux/ss/hashtab.h                    |  144 +
 selinux/ss/mls.c                        |  735 ++++++
 selinux/ss/mls.h                        |  106 +
 selinux/ss/mls_types.h                  |   65 
 selinux/ss/policydb.c                   | 1300 ++++++++++++
 selinux/ss/policydb.h                   |  274 ++
 selinux/ss/services.c                   | 1387 +++++++++++++
 selinux/ss/services.h                   |   23 
 selinux/ss/sidtab.c                     |  333 +++
 selinux/ss/sidtab.h                     |   71 
 selinux/ss/symtab.c                     |   48 
 selinux/ss/symtab.h                     |   28 
 40 files changed, 12538 insertions(+)

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

