Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbUCDS33 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbUCDS33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:29:29 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:61371 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S262068AbUCDS3S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:29:18 -0500
Message-ID: <4047756D.2050402@blue-labs.org>
Date: Thu, 04 Mar 2004 13:29:01 -0500
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040220
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ACPI battery info failure after some period of time, 2.6.3-x and
 up
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

powerix root # cat /proc/acpi/battery/BAT0/state
present:                 yes
ERROR: Unable to read battery status

powerix root # dmesg -c
    ACPI-0279: *** Error: Looking up [BST0] in namespace, AE_ALREADY_EXISTS
    ACPI-1120: *** Error: Method execution failed [\_SB_.BAT0._BST] 
(Node e7bd7680), AE_ALREADY_EXISTS

powerix root # uname -r
2.6.4-rc1

This has been going on since about 2.6.3-rc something.  Some while after 
reading the /proc files, the ability to read the battery information 
gets munged.
