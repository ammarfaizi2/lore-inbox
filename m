Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264950AbSLFQ5K>; Fri, 6 Dec 2002 11:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265154AbSLFQ5K>; Fri, 6 Dec 2002 11:57:10 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:31751 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S264950AbSLFQ5J>;
	Fri, 6 Dec 2002 11:57:09 -0500
Message-ID: <3DF0D8D9.2090703@mvista.com>
Date: Fri, 06 Dec 2002 11:05:29 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: [PATCH] Version 15 of the Linux IPMI driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is yet another release of the IPMI driver for Linux.  This is
for linux 2.4.20 and 2.5.50, patches are available from the previous
release (Version 14) of the IPMI driver.

This release of the IPMI driver fixes some race conditions on SMP
systems, and fixes some minor problems in the watchdog. A special
thanks goes to Francois Isabelle at Kontron for finding the SMP
problem and helping me debug it.

The NMI handler has changed to export the nmi_watchdog variable;
since the ipmi watchdog is incompatible with the IOAPIC nmi_watchdog
setting, it detects this and refuses to use NMI in that case. As usual, you
don't need the NMI patch if you don't care about IPMI NMI watchdog
pretimeouts, but you must upgrade to the new NMI patch if you use the
IPMI NMI watchdog pretimeout.

As usual, you can get the drivers from SourceForge.  The home page is
 http://openipmi.sourceforge.net.

http://sourceforge.net/projects/openipmi gets you directly to the page
with the patches.

-Corey

PS - In case you don't know, IPMI is a standard for system management, it
provides ways to detect the managed devices in the system and sensors
attached to them.  You can get more information at
http://www.intel.com/design/servers/ipmi/spec.htm.  A nice overview of
IPMI is available at
http://www.intel.com/platforms/applied/eiacomm/papers/25133701.pdf

