Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbVLWFmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbVLWFmx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 00:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVLWFmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 00:42:53 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:58510 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932305AbVLWFmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 00:42:52 -0500
From: Len Brown <len.brown@intel.com>
Organization: Intel Open Source Technology Center
To: torvalds@osdl.org
Subject: git pull on Linux/ACPI release tree
Date: Fri, 23 Dec 2005 00:42:16 -0500
User-Agent: KMail/1.8.2
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <200512010305.43469.len.brown@intel.com> <200512060317.53925.len.brown@intel.com>
In-Reply-To: <200512060317.53925.len.brown@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200512230042.17903.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

This will update the files shown below.

thanks!

-Len

 drivers/acpi/processor_thermal.c |    4 ++--
 drivers/acpi/utilities/utmisc.c  |   20 ++++++++++----------
 include/acpi/acglobal.h          |    2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

through these commits:

Alex Williamson:
      [ACPI] increase owner_id limit to 64 from 32

Len Brown:
      [ACPI] fix build warning from owner_id patch

Thomas Renninger:
      [ACPI] fix passive cooling regression

with this log:

commit 9d6be4bed65a3bd36ab2de12923bff4f4530bd86
Author: Len Brown <len.brown@intel.com>
Date:   Thu Dec 22 22:23:06 2005 -0500

    [ACPI] fix build warning from owner_id patch
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 75b245b3259133360845bc6de3aecb8a6bd6ab59
Author: Thomas Renninger <trenn@suse.de>
Date:   Wed Dec 21 01:29:00 2005 -0500

    [ACPI] fix passive cooling regression
    
    Return logic was inverted.
    Going for changing the return value to not return zero as it is makes
    more sense regarding the naming of the function (cpu_has_cpufreq()).
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3410
    
    Signed-off-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 05465fd5622202d65634b3a9a8bcc9cbb384a82a
Author: Alex Williamson <alex.williamson@hp.com>
Date:   Thu Dec 8 15:37:00 2005 -0500

    [ACPI] increase owner_id limit to 64 from 32
    
    This is an interim patch until changes in an updated
    ACPICA core increase the limit to 255.
    
    Signed-off-by: Alex Williamson <alex.williamson@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>


