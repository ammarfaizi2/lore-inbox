Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264092AbUDBQDz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 11:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264094AbUDBQDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 11:03:55 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:29634 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264092AbUDBQDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 11:03:53 -0500
Message-ID: <1080922213.406d9065d9667@webmail.rongage.org>
Date: Fri,  2 Apr 2004 11:10:13 -0500
From: Ron Gage <ron@rongage.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4 - can't open a custom char device file
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 216.234.103.146
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks.

I am working on a PCMCIA module for an industrial communications interface under
Linux (Specifically, the Allen Bradley PCMK).  Let's just say that the driver I
wrote is having issues, what I believe to be kernel related issues.

As near as I can tell, the card is being initialized correctly with the PCMCIA
layer without incident.  My driver is registering the device as major 240, and
according to /proc/devices, the device is showing up as major 240.

My device file is created as a char device at major 240, minor 0.  As near as I
can tell, I do have a file-operations struct filled in and have no indications
that this struct is incorrect.  I do have a defined open routine that
essentially increments the module use count and exits.

Problem is that any attempt to open the device file causes the kernel to return
error #6 - Device or Address not found - when the device is showing up in
/proc/devices and according to kernel messages I have in the driver, is
installed and initialized.

Anyone have any ideas on what I could be doing wrong here?

Driver source is available from
ftp://ftp.rongage.org/pub/pcmk/pcmk_v0.0.0.tar.gz

I have already consulted with David Hinds (PCMCIA leader) and he is stumped.


-- 
Ronald R. Gage
MCP, LPIC1, A+, Net+
Pontiac, Michigan





----------------------------------------------------------------
This message was sent using webmail provided by www.rongage.org
