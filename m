Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbTGCRmn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 13:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbTGCRmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 13:42:43 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:49145 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S265163AbTGCRmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 13:42:35 -0400
Date: Thu, 3 Jul 2003 10:55:07 -0700
From: Chris Wright <chris@wirex.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Chris Wright <chris@wirex.com>,
       James Morris <jmorris@intercode.com.au>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add SELinux module to 2.5.74-bk1
Message-ID: <20030703105507.F8208@figure1.int.wirex.com>
References: <1057254295.1110.1016.camel@moss-huskers.epoch.ncsc.mil> <20030703175153.GC27556@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030703175153.GC27556@gtf.org>; from jgarzik@pobox.com on Thu, Jul 03, 2003 at 01:51:53PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Garzik (jgarzik@pobox.com) wrote:
> nitpicks:
> 
> 1) "selinux" is a poor toplevel directory.  We already have the toplevel
> "security" directory, this code should go in there.

the diffstat is misleading.  actual diffstat output (relative to top level):
 security/Kconfig                                 |    2 
 security/Makefile                                |    6 
 security/selinux/Kconfig                         |   34 
 security/selinux/Makefile                        |   10 
 security/selinux/avc.c                           | 1144 +++++++
 security/selinux/hooks.c                         | 3373 +++++++++++++++++++++++
 security/selinux/include/av_inherit.h            |   37 
 security/selinux/include/av_perm_to_string.h     |  122 
 security/selinux/include/av_permissions.h        |  550 +++
 security/selinux/include/avc.h                   |  234 +
 security/selinux/include/avc_ss.h                |   81 
 security/selinux/include/class_to_string.h       |   39 
 security/selinux/include/common_perm_to_string.h |   65 
 security/selinux/include/flask.h                 |   71 
 security/selinux/include/flask_types.h           |   73 
 security/selinux/include/initial_sid_to_string.h |   32 
 security/selinux/include/objsec.h                |   87 
 security/selinux/include/security.h              |  180 +
 security/selinux/selinuxfs.c                     |  592 ++++
 security/selinux/ss/Makefile                     |   14 
 security/selinux/ss/avtab.c                      |  273 +
 security/selinux/ss/avtab.h                      |   82 
 security/selinux/ss/constraint.h                 |   62 
 security/selinux/ss/context.h                    |  131 
 security/selinux/ss/ebitmap.c                    |  344 ++
 security/selinux/ss/ebitmap.h                    |   57 
 security/selinux/ss/global.h                     |   19 
 security/selinux/ss/hashtab.c                    |  310 ++
 security/selinux/ss/hashtab.h                    |  144 
 security/selinux/ss/mls.c                        |  735 +++++
 security/selinux/ss/mls.h                        |  106 
 security/selinux/ss/mls_types.h                  |   65 
 security/selinux/ss/policydb.c                   | 1300 ++++++++
 security/selinux/ss/policydb.h                   |  274 +
 security/selinux/ss/services.c                   | 1387 +++++++++
 security/selinux/ss/services.h                   |   23 
 security/selinux/ss/sidtab.c                     |  333 ++
 security/selinux/ss/sidtab.h                     |   71 
 security/selinux/ss/symtab.c                     |   48 
 security/selinux/ss/symtab.h                     |   28 
 40 files changed, 12538 insertions

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
