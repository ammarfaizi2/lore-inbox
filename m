Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268290AbTAMTJe>; Mon, 13 Jan 2003 14:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268171AbTAMTJe>; Mon, 13 Jan 2003 14:09:34 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:31068 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S268287AbTAMTJd>;
	Mon, 13 Jan 2003 14:09:33 -0500
Message-ID: <3E23113D.2020902@mvista.com>
Date: Mon, 13 Jan 2003 13:19:25 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: [PATCH] Version 17 of the IPMI driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is yet another release of the IPMI driver for Linux.  This release
mostly compensates for hardware bugs.

Some broken hardware doesn't implement the KCS state machine quite right.
The 1.0 spec is a little vague and some vendors got it wrong.

It implements retries for messages sent on the IPMB bus, since they
can be lost, and some IPMB busses are not up to snuff.

It modifies the message timers to not start until after the message has
been transmitted by the SMI.  If your KCS interface is slow or very busy,
it could have caused problems because the timer was started at queue time,
not when the message was actually sent on the IPMB.  This only affect IPMB.

If fixes a minor 2.5 compile issue.

As usual, you can get the drivers from SourceForge.  The home page is
http://openipmi.sourceforge.net. http://sourceforge.net/projects/openipmi
gets you directly to the page with the info.

-Corey

PS - In case you don't know, IPMI is a standard for system management, it
provides ways to detect the managed devices in the system and sensors
attached to them.  You can get more information at
http://www.intel.com/design/servers/ipmi/spec.htm.

