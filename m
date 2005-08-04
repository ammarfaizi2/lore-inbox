Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVHDRLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVHDRLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 13:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVHDRIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 13:08:39 -0400
Received: from [206.152.180.10] ([206.152.180.10]:55256 "EHLO
	unix.worldpath.net") by vger.kernel.org with ESMTP id S262560AbVHDRFp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 13:05:45 -0400
Subject: [GIT PATCH] ACPI patches for 2.6.13-rc5+
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <1123110985.13136.12.camel@toshiba>
References: <1122702560.26850.9.camel@toshiba>
	 <1123110985.13136.12.camel@toshiba>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 13:11:19 -0400
Message-Id: <1123175479.13136.21.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/lenb/to-linus.git

Two additional patches to remove some rough edges for 2.6.13.

thanks,
-Len

p.s.
Latest ACPI plain patch, including stuff waiting for 2.6.14 is available
here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.12/
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.12/broken-out/

 drivers/acpi/dispatcher/dswload.c |    6 ------
 drivers/acpi/osl.c                |    6 +++++-
 drivers/acpi/pci_link.c           |    7 +++++++
 3 files changed, 12 insertions(+), 7 deletions(-)

commit 11e981f1e02c2a36465cbb208b21cb8b6480f399
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Wed Aug 3 23:46:33 2005 -0400

    [ACPI] S3 resume: avoid kmalloc() might_sleep oops symptom
    
    ACPI now uses kmalloc(...,GPF_ATOMIC) during suspend/resume.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3469
    
    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d4ab025b73a2d10548e17765eb76f3b7351dc611
Author: Len Brown <len.brown@intel.com>
Date:   Wed Aug 3 23:20:58 2005 -0400

    [ACPI] delete Warning: Encountered executable code at module level,
[AE_NOT_CONFIGURED]
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4923
    
    Signed-off-by: Len Brown <len.brown@intel.com>



