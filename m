Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbUBYJS3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 04:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbUBYJS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 04:18:29 -0500
Received: from fmr04.intel.com ([143.183.121.6]:52959 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262571AbUBYJSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 04:18:23 -0500
Subject: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1077700686.5911.186.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Feb 2004 04:18:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.4

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.3/acpi-20040211-2.6.3.diff.gz

This will update the following files:

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
 drivers/acpi/sleep/proc.c          |    8 ++---
 drivers/acpi/utils.c               |    2 -
 include/acpi/acconfig.h            |    2 -
 19 files changed, 92 insertions(+), 51 deletions(-)

through these ChangeSets:

<akpm@osdl.org> (04/02/25 1.1617.1.3)
   [PATCH] drivers/acpi/sleep/proc.c warnings
   
   drivers/acpi/sleep/proc.c:359: warning: initialization from
incompatible pointer type
   drivers/acpi/sleep/proc.c:367: warning: initialization from
incompatible pointer type

<akpm@osdl.org> (04/02/25 1.1617.1.2)
   [PATCH] acpi/utils.c warning fix
   
   drivers/acpi/utils.c: In function `acpi_evaluate_reference':
   drivers/acpi/utils.c:353: warning: unsigned int format, different
type arg (arg 5)

<len.brown@intel.com> (04/02/13 1.1493.1.19)
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

<len.brown@intel.com> (04/02/13 1.1493.1.18)
   [ACPI] revert previous AML param patch for ACPICA update




