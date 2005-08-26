Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbVHZOc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbVHZOc3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 10:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbVHZOc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 10:32:28 -0400
Received: from fmr18.intel.com ([134.134.136.17]:41612 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S965053AbVHZOc2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 10:32:28 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: kgdb on EM64T
Date: Fri, 26 Aug 2005 07:27:47 -0700
Message-ID: <194B303F2F7B534594F2AB2D87269D9F06E5CE22@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kgdb on EM64T
Thread-Index: AcWqSlR9IFlHBBbpQBebQ+1Uuu71Nw==
From: "Wilkerson, Bryan P" <Bryan.P.Wilkerson@intel.com>
To: "George Anzinger" <george@mvista.com>,
       "Tom Rini" <trini@kernel.crashing.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Aug 2005 14:32:12.0070 (UTC) FILETIME=[F2616C60:01C5AA4A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks you Tom and George for the tips on using kgdb with
2.6.13-rc4-mm1.  

I almost have it working but kgdb seems to have a few issues.  I can get
it running from the dev machine using the kgdb and console=kgdb boot
options on the test kernel.  The kernel waits as it should and when I
attach with "target remote /dev/ttyS0" and I can continue the boot but
eventually it gets to a point in the boot where it frees unused kernel
memory successfully and then a warning, "unable to open an initial
console",  followed by, "Kernel panic - not syncing: Attempted to kill
init!"

Removing the console=kgdb boot option and the machine boots all the way
to run level 5.   I tried to break into kgdb at this point using the 
	$echo -e "\003" > /dev/ttyS0
from the dev machine but the test kernel panics at gdb_interrupt+75 when
it receives anything on the serial port.  Hmmm...

I'm wondering if I'm maybe just the first to try this on EM64T (kernel
builds in the arch/x86_64 tree).   

Any suggestions welcome.

-bryan
