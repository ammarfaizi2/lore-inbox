Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbTEAQli (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 12:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbTEAQli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 12:41:38 -0400
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:36801
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S261158AbTEAQlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 12:41:36 -0400
Message-ID: <3EB15127.2060409@rogers.com>
Date: Thu, 01 May 2003 12:53:59 -0400
From: Jeff Muizelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] NE2000 driver updates
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Thu, 1 May 2003 12:53:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first two patches are retransmits of the original PnP api patches
updated to apply to a current tree.

The third patch is more of an RFC. It consolidates the creation/removal
of the driver between the PnP code and the plain ISA code.  In doing so
it changes the net_device allocation from static to dynamic and allows
PnP support when the driver is compiled in.  This is probably how things
will eventually have to be if there is ever driver model support for
plain ISA devices.

The forth patch gets rid of the use of dev->mem_end as a bad flag.

Caveats:
It appears that the patch will break any autoprobe ordering because it no
longer uses Space.c when compiled into the kernel.
Data size of object goes up about 100 bytes.

-Jeff

