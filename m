Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263550AbTJQQwL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 12:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263531AbTJQQwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 12:52:11 -0400
Received: from 62-101-126-192.fastres.net ([62.101.126.192]:28347 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263564AbTJQQwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 12:52:07 -0400
Message-ID: <3F901E32.2000203@bmind.it>
Date: Fri, 17 Oct 2003 18:52:02 +0200
From: Paolo Dovera <pdovera@bmind.it>
Organization: bmind SpA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: it, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: problem to access  /proc/acpi/battery/BAT1/* files
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I'm using the kernel 2.6.0-test6/7 and I've noticed this warning into 
/var/log/messages

Oct 17 18:15:16 localhost kernel:  dswload-0269: *** Error: Looking up 
[PBST] in namespace, AE_ALREADY_EXISTS
Oct 17 18:15:16 localhost kernel:  psparse-0589 [293932] 
ps_parse_loop         : During name lookup/catalog, AE_ALREADY_EXISTS
Oct 17 18:15:16 localhost kernel:  psparse-1121: *** Error: Method 
execution failed [\_SB_.PCI0.LPC0.BAT1._BST](Nodec12ab328), 
AE_ALREADY_EXISTS
Oct 17 18:15:25 localhost kernel:  dswload-0269: *** Error: Looking up 
[PBST] in namespace, AE_ALREADY_EXISTS
Oct 17 18:15:25 localhost kernel:  psparse-0589 [294043] 
ps_parse_loop         : During name lookup/catalog, AE_ALREADY_EXISTS
Oct 17 18:15:25 localhost kernel:  psparse-1121: *** Error: Method 
execution failed [\_SB_.PCI0.LPC0.BAT1._BST] (Node c12ab328), 
AE_ALREADY_EXISTS

when some programs concurrently access to /proc/acpi/battery/BAT1/* files.

For example I use cpufrequency (a daemon to switch CPU frequency on my 
P4 laptop) http://sourceforge.net/projects/cpufrequency/
(this program checks every some seconds the status of battery)
and I use
        watch -n 8 "cat /proc/acpi/battery/BAT1/*"
to see the battery state in a xterm.

Is there some lock to access to status of battery?

thanks for your time,
Paolo Dovera



