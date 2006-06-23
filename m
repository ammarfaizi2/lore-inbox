Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWFWPfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWFWPfh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWFWPfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:35:37 -0400
Received: from router.emperor-sw2.exsbs.net ([208.254.201.37]:52897 "EHLO
	sade.emperorlinux.com") by vger.kernel.org with ESMTP
	id S1751466AbWFWPfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:35:37 -0400
Message-ID: <449C0A3B.6070409@temp123.org>
Date: Fri, 23 Jun 2006 11:35:23 -0400
From: Josh Litherland <josh@temp123.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cmd64x not happy about being hotplugged, 2.6.17
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a thinkpad dock 2 which includes a Silicon Image CMD648 IDE 
controller (1095:0648 (rev 01)) for the UltraBay2000 slot.  The dock now 
works as an acpiphp PCI hotplug device, and the PCI devs get detected 
safely and removed more or less safely when undocking.  The cmd64x 
doesn't seem to handle the hotplugging as well.  When it is attached, it 
doesn't enumerate the CDRW device that is connected to it (although the 
drive works if it is inserted at boot time.).  When the laptop is 
undocked, cmd64x seems not to notice at all.  Any further access to it, 
such as "cat /proc/ide/cmd64x", will cause a segfault as seen here:

http://downloads.emperorlinux.com/support/misc/bug.txt

Let me know if there's any further information I can provide.  Thanks!

-- 
Josh Litherland (josh@temp123.org)
