Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271420AbTGQNYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 09:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271424AbTGQNYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 09:24:17 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:16847 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S271420AbTGQNYF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 09:24:05 -0400
Subject: [PATCH][URL] Updated SELinux module for 2.6.0-test1
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Chris Wright <chris@wirex.com>,
       James Morris <jmorris@intercode.com.au>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1058448994.13738.991.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Jul 2003 09:36:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch available from
http://www.nsa.gov/selinux/lk/2.6.0-test1-addselinux.patch.gz adds the
SELinux module under security/selinux and modifies the security/Makefile
and security/Kconfig files for SELinux.  For those using
2.6.0-test1-mm1, a diff against it is available at
http://www.nsa.gov/selinux/lk/2.6.0-test1-mm1-updateselinux.patch.gz.
Since the previous version of this patch, a number of code cleanups have
been made with particular focus on the areas cited by Greg, i.e. killing
typedefs, adding printk log levels, and adding kerneldoc comments to the
functions provided by avc.c and ss/services.c.  Many of the code
cleanups were contributed by James Morris.  Andrew Morton caught and
fixed numerous instances of trailing whitespace on lines.  diffstat -p1
output is below.  I'll be sending this patch directly to Linus and
Andrew in a separate message.

 security/Kconfig                                 |    2 
 security/Makefile                                |    6 
 security/selinux/Kconfig                         |   34 
 security/selinux/Makefile                        |   10 
 security/selinux/avc.c                           | 1115 +++++++
 security/selinux/hooks.c                         | 3405 +++++++++++++++++++++++
 security/selinux/include/av_inherit.h            |   35 
 security/selinux/include/av_perm_to_string.h     |  120 
 security/selinux/include/av_permissions.h        |  550 +++
 security/selinux/include/avc.h                   |  159 +
 security/selinux/include/avc_ss.h                |   27 
 security/selinux/include/class_to_string.h       |   39 
 security/selinux/include/common_perm_to_string.h |   65 
 security/selinux/include/flask.h                 |   71 
 security/selinux/include/initial_sid_to_string.h |   32 
 security/selinux/include/objsec.h                |   88 
 security/selinux/include/security.h              |   70 
 security/selinux/selinuxfs.c                     |  593 ++++
 security/selinux/ss/Makefile                     |   14 
 security/selinux/ss/avtab.c                      |  264 +
 security/selinux/ss/avtab.h                      |   68 
 security/selinux/ss/constraint.h                 |   54 
 security/selinux/ss/context.h                    |  117 
 security/selinux/ss/ebitmap.c                    |  332 ++
 security/selinux/ss/ebitmap.h                    |   49 
 security/selinux/ss/global.h                     |   17 
 security/selinux/ss/hashtab.c                    |  277 +
 security/selinux/ss/hashtab.h                    |  125 
 security/selinux/ss/mls.c                        |  741 +++++
 security/selinux/ss/mls.h                        |   99 
 security/selinux/ss/mls_types.h                  |   58 
 security/selinux/ss/policydb.c                   | 1429 +++++++++
 security/selinux/ss/policydb.h                   |  256 +
 security/selinux/ss/services.c                   | 1413 +++++++++
 security/selinux/ss/services.h                   |   21 
 security/selinux/ss/sidtab.c                     |  329 ++
 security/selinux/ss/sidtab.h                     |   59 
 security/selinux/ss/symtab.c                     |   40 
 security/selinux/ss/symtab.h                     |   23 
 39 files changed, 12206 insertions(+)

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

