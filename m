Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVLAICl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVLAICl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 03:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVLAICl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 03:02:41 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:26796 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750762AbVLAICk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 03:02:40 -0500
From: Len Brown <len.brown@intel.com>
Organization: Intel Open Source Technology Center
To: torvalds@osdl.org
Subject: git pull on Linux/ACPI release tree
Date: Thu, 1 Dec 2005 03:05:43 -0500
User-Agent: KMail/1.8.2
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512010305.43469.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

This will update the files shown below.

thanks!

-Len

 arch/i386/kernel/acpi/boot.c     |    7 +
 drivers/acpi/Kconfig             |    1 
 drivers/acpi/Makefile            |    2 
 drivers/acpi/processor_core.c    |   15 ++
 drivers/acpi/processor_idle.c    |   29 +++-
 drivers/acpi/processor_thermal.c |   38 +++---
 drivers/acpi/scan.c              |    2 
 drivers/acpi/thermal.c           |  163 ++++++++++++++-------------
 drivers/acpi/video.c             |    2 
 9 files changed, 157 insertions(+), 102 deletions(-)

through these commits:

Al Viro:
      [ACPI] IA64 build: blacklist.c is used only on X86

Borislav Petkov:
      [ACPI] delete "default y" on Kconfig for ibm_acpi extras driver

David Shaohua Li:
      [ACPI] properly detect pmtimer on ASUS a8v motherboard

Thomas Renninger:
      [ACPI] fix HP nx8220 boot hang regression
      [ACPI] Allow return to active cooling mode once passive mode is entered
      [ACPI] Fix Null pointer deref in video/lcd/brightness

Venkatesh Pallipadi:
      [ACPI] Prefer _CST over FADT for C-state capabilities
      [ACPI] Add support for FADT P_LVL2_UP flag
      [ACPI] fix 2.6.13 boot hang regression on HT box w/ broken BIOS

with this log:

commit 220ec706645ecf13ee3a87046d17316303905698
Merge: 16071a073d44ef3ca3f79d0b49371a79464d9ac0 
1cbf4c563c0eaaf11c552a88b374e213181c6ddd
Author: Len Brown <len.brown@intel.com>
Date:   Thu Dec 1 01:42:17 2005 -0500

    Pull 3410 into release branch

commit 16071a073d44ef3ca3f79d0b49371a79464d9ac0
Merge: b7639dafb4e175ddd637425da5ff65f03e08028e 
cd8e2b48daee891011a4f21e2c62b210d24dcc9e
Author: Len Brown <len.brown@intel.com>
Date:   Thu Dec 1 01:39:55 2005 -0500

    Pull 5452 into release branch

commit b7639dafb4e175ddd637425da5ff65f03e08028e
Merge: c8734a9663806b7ebd3b5e33bae65a60ff6553bd 
59d399d357a7705568f424c6e861ee8657f7f655
Author: Len Brown <len.brown@intel.com>
Date:   Thu Dec 1 01:39:41 2005 -0500

    Pull 5571 into release branch

commit cd8e2b48daee891011a4f21e2c62b210d24dcc9e
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Fri Oct 21 19:22:00 2005 -0400

    [ACPI] fix 2.6.13 boot hang regression on HT box w/ broken BIOS
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5452
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 59d399d357a7705568f424c6e861ee8657f7f655
Author: Thomas Renninger <trenn@suse.de>
Date:   Tue Nov 8 05:27:00 2005 -0500

    [ACPI] Fix Null pointer deref in video/lcd/brightness
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5571
    
    Signed-off-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
    Signed-off-by: Yu Luming <luming.yu@gmail.com>
    Cc: <stable@kernel.org>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1cbf4c563c0eaaf11c552a88b374e213181c6ddd
Author: Thomas Renninger <trenn@suse.de>
Date:   Thu Sep 16 11:07:00 2004 -0400

    [ACPI] Allow return to active cooling mode once passive mode is entered
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3410
    https://bugzilla.novell.com/show_bug.cgi?id=131543
    
    Signed-off-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Konstantin Karasyov <konstantin.a.karasyov@intel.com>
    Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Yu Luming <luming.yu@gmail.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

commit c8734a9663806b7ebd3b5e33bae65a60ff6553bd
Merge: 8e9887cc3b8d9f1c88c6f3842346a9478e52718f 
e6e87b4bfe3720b4308a8e669078d9be58bc9780
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 30 22:28:15 2005 -0500

    Pull 5283 into release branch

commit e6e87b4bfe3720b4308a8e669078d9be58bc9780
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Wed Sep 21 01:35:00 2005 -0400

    [ACPI] properly detect pmtimer on ASUS a8v motherboard
    
    Handle FADT 2.0 xpmtmr address 0 case.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5283
    
    Signed-off-by: Shaohua Li<shaohua.li@intel.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8e9887cc3b8d9f1c88c6f3842346a9478e52718f
Merge: 0a47c906342e2447003e207d23917dfa5c912071 
d2149b542382bfc206cb28485108f6470c979566
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 30 22:22:52 2005 -0500

    Auto-update from upstream

commit 0a47c906342e2447003e207d23917dfa5c912071
Author: Borislav Petkov <petkov@uni-muenster.de>
Date:   Wed Nov 30 22:12:45 2005 -0500

    [ACPI] delete "default y" on Kconfig for ibm_acpi extras driver
    
    Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5d8e7aa6e5c21e14843404c5e4c04d4cf043e40e
Author: Al Viro <viro@ftp.linux.org.uk>
Date:   Thu Sep 22 01:15:57 2005 -0400

    [ACPI] IA64 build: blacklist.c is used only on X86
    
    Signed-off-by: Al Viro <viro@ftp.linux.org.uk>
    Signed-off-by: Len Brown <len.brown@intel.com>
    (cherry picked from ef4611613657dfb8af8d336f2f61f08cfcdc9d8a commit)

commit 7dac562f6d89b3f70c3f12b0e17878b07af42298
Merge: 3141b6708dd9ad09b6667c23393cfdc25b127771 
4c0335526c95d90a1d958e0059f40a5745fc7c5d
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 30 21:55:14 2005 -0500

    Pull 5165 into release branch

commit 3141b6708dd9ad09b6667c23393cfdc25b127771
Merge: d2149b542382bfc206cb28485108f6470c979566 
bd7ce5b5ff930c29b1c0405051e9c9388660b785
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 30 21:55:02 2005 -0500

    Pull 5221 into release branch

commit bd7ce5b5ff930c29b1c0405051e9c9388660b785
Author: Thomas Renninger <trenn@suse.de>
Date:   Mon Oct 3 10:39:00 2005 -0700

    [ACPI] fix HP nx8220 boot hang regression
    
    This patch reverts the acpi_bus_find_driver() return value check
    that came in via the PCI tree via 3fb02738b0fd36f47710a2bf207129efd2f5daa2
    
            [PATCH] acpi bridge hotadd: Allow ACPI .add and .start
    	operations to be done independently
    
    This particular change broke booting of some HP/Compaq laptops unless
    acpi=noirq is used.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5221
    https://bugzilla.novell.com/show_bug.cgi?id=116763
    
    Signed-off-by: Thomas Renninger <trenn@suse.de>
    Cc: Rajesh Shah <rajesh.shah@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4c0335526c95d90a1d958e0059f40a5745fc7c5d
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Thu Sep 15 12:20:00 2005 -0400

    [ACPI] Add support for FADT P_LVL2_UP flag
    which tells us if C2 is valid for UP-only, or SMP.
    
    As there is no separate bit for C3,  use P_LVL2_UP
    bit to cover both C2 and C3.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5165
    
    Signed-off-by: Venkatesh Pallipadi<venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>
    (cherry picked from 28b86b368af3944eb383078fc5797caf2dc8ce44 commit)

commit 6d93c64803a5fea84839789aae13290419c62d92
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Thu Sep 15 12:19:00 2005 -0400

    [ACPI] Prefer _CST over FADT for C-state capabilities
    
    Note: This ACPI standard compliance may cause regression
    on some system, if they have _CST present, but _CST value
    is bogus. "nocst" module parameter should workaround
    that regression.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5165
    
    Signed-off-by: Venkatesh Pallipadi<venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>
    (cherry picked from 883baf7f7e81cca26f4683ae0d25ba48f094cc08 commit)

