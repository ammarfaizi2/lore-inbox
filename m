Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWJPCSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWJPCSO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 22:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWJPCSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 22:18:14 -0400
Received: from [203.26.40.81] ([203.26.40.81]:54151 "EHLO boo.knobbits.org")
	by vger.kernel.org with ESMTP id S1751285AbWJPCSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 22:18:13 -0400
Message-ID: <4532EBE2.6090709@knobbits.org>
Date: Mon, 16 Oct 2006 12:18:10 +1000
From: "Michael (Micksa) Slade" <micksa@knobbits.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Inspiron 6000 and CPU power saving
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently discovered that my Inspiron 6000 uses about 50% more power 
idling in linux than in windows XP.  This means its battery life is 
about 2/3 of what it could/should be.

I guessed it might be the CPU, and did some tests.  The results strongly 
suggest as much.  These are the results I got for power consumption in 
various situations.

linux idle at 800MHz: 27W        
linux idle at 1600MHz: 36W        
linux raytracing at 800: 30W
linux raytracing at 1600: 42W 

windows idle (presumably 800MHz): 16W
windows raytracing (presumably 1600MHz): 36W

I've tried ubuntu dapper and ubuntu edgy, and RIP 10 (rescue disk) and 
BBC 2.1 (rescue disk), and they all appear to have the same issue.  The 
machine's BIOS has no APM so I can't try it for comparison.

I've tried noapic and "echo n > 
/sys/module/processor/parameters/max_cstate", where n is 1 thru 4.  
Neither appear to have any affect.

I need help digging deeper.  I guess /proc/acpi/processor/CPU0/power 
could give some insight but I'm not sure how to read the numbers.  That 
and "learn about ACPI" is all I can figure out so far.

So where to from here?  I am prepared to spend a significant amount of 
time researching and resolving the issue, so feel free to suggest 
reading the ACPI spec or whatever if that's what it's going to take.

Mick.

