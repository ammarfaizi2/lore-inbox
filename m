Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbUBYKB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 05:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUBYKB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 05:01:59 -0500
Received: from fmr04.intel.com ([143.183.121.6]:38122 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261157AbUBYKBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 05:01:47 -0500
Subject: [BKPATCH] ACPI for 2.4
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1077700687.5912.188.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Feb 2004 05:01:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.4.26

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.25/acpi-20040211-2.4.25.diff.gz

This will update the following files:

 drivers/acpi/Config.in             |    3 --
 drivers/acpi/dispatcher/dsmthdat.c |    9 ++++--
 drivers/acpi/dispatcher/dsobject.c |    5 +++
 drivers/acpi/dispatcher/dsopcode.c |    6 ++--
 drivers/acpi/dispatcher/dsutils.c  |    3 +-
 drivers/acpi/dispatcher/dswstate.c |    2 -
 drivers/acpi/executer/exconvrt.c   |   35 ++++++++++++++++---------
 drivers/acpi/executer/exfldio.c    |    4 +-
 drivers/acpi/executer/exmisc.c     |    8 +++--
 drivers/acpi/executer/exoparg2.c   |    4 ++
 drivers/acpi/executer/exprep.c     |    2 -
 drivers/acpi/executer/exresolv.c   |    6 ++--
 drivers/acpi/executer/exresop.c    |    4 +-
 drivers/acpi/executer/exstore.c    |   29 ++++++++++++++------
 drivers/acpi/executer/exstoren.c   |    8 +++++
 drivers/acpi/namespace/nsaccess.c  |    2 -
 drivers/acpi/parser/psargs.c       |    4 +-
 include/acpi/acconfig.h            |    2 -
 18 files changed, 87 insertions(+), 49 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/02/13 1.1063.46.74)
   [ACPI] ACPICA 20040211 udpate from Bob Moore
   
   Completed investigation and implementation of the
   call-by-reference mechanism for control method arguments.
   
   Fixed a problem where a store of an object into an indexed
   package could fail if the store occurs within a different
   method than the method that created the package.
   
   Fixed a problem where the ToDecimal operator could return
   incorrect results.
   
   Fixed a problem where the CopyObject operator could fail
   on some of the more obscure objects (e.g., Reference objects.)
   
   Improved the output of the Debug object to display buffer,
   package, and index objects.
   
   Fixed a problem where constructs of the form "RefOf (ArgX)"
   did not return the expected result.
   
   Added permanent ACPI_REPORT_ERROR macros for all instances of the
   ACPI_AML_INTERNAL exception.

<len.brown@intel.com> (04/02/13 1.1063.46.73)
   [ACPI] revert previous AML param patch for ACPICA update

<len.brown@intel.com> (04/02/10 1.1063.46.72)
   [ACPI] CONFIG_ACPI_NUMA depends on CONFIG_IA64




