Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266084AbTFWRzU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 13:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbTFWRzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 13:55:20 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:12476 "EHLO
	sccrmhc13.attbi.com") by vger.kernel.org with ESMTP id S266084AbTFWRzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 13:55:17 -0400
Message-ID: <3EF74253.1040702@acm.org>
Date: Mon, 23 Jun 2003 13:09:23 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, openipmi-developer@lists.sourceforge.net
Subject: New version of the IPMI driver (version 23)
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This update makes significant changes to the IPMI driver.  No user
interfaces changes have been made (although some new features have been
added), but lots of internal changes have been done.  These are:

    * A new low-level driver has been added, the "SI" (System Interface)
      driver.  It supports both KCS and SMIC interfaces.  The old
      KCS-only interface is also there, but it is deprecated.
    * A socket interface has been added to the driver, this adds an IPMI
      socket (so that another device number doesn't have to be used to
      talk to IPMI).
    * Support has been added for setting the timeout parameters on a
      per-message or per-connection basis.
    * A bunch of proc filesystem statistics have been added for IPMI.
    * The ACPI code should work in all cases now, and auto-detects the
      interface type.
    * Tons of little bug fixes, performance fixes, etc. have been done.
    * A new version of the IMB and Radisys emulation drivers are also
      there, with minor bug fixes.

This should be pretty stable, a lot of people have been testing it. 
Thanks to all those who helped me with this.

You can get it at http://openipmi.sf.net, a 2.4.21 and 2.5.73 version
are available.

I plan to start trying to push this into 2.5 soon.

-Corey

