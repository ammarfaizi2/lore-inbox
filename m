Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262830AbVA2AZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbVA2AZO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 19:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbVA2AZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 19:25:14 -0500
Received: from animx.eu.org ([216.98.75.249]:47268 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262830AbVA2AZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 19:25:06 -0500
Date: Fri, 28 Jan 2005 19:34:48 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 ACPI on dell inspiron 8100
Message-ID: <20050129003448.GA24375@animx.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed something strange with ACPI and the battery:
/proc/acpi/battery/BAT1$ cat info 
present:                 yes
design capacity:         57420 mWh
last full capacity:      57420 mWh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 3000 mWh
design capacity low:     1000 mWh
capacity granularity 1:  200 mWh
capacity granularity 2:  200 mWh
model number:            LIP8084DLP
serial number:           20495
battery type:            LION
OEM info:                Sony Corp.
/proc/acpi/battery/BAT1$ cat state 
present:                 yes
capacity state:          ok
charging state:          charging
present rate:            unknown
remaining capacity:      59040 mWh
present voltage:         16716 mV
/proc/acpi/battery/BAT1$

Is my laptop messed up or is ACPI not seeing proper values?  How can I have
59040 remaining capacity when it the full capacity is 57420?  Also the
system didn't display the charging light so I know it's not charging.

I yanked the battery and I saw this:
/proc/acpi/battery/BAT1$ cat state
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            unknown
remaining capacity:      0 mWh
present voltage:         0 mV
/proc/acpi/battery/BAT1$

Under BAT0, info and state show one line, present: no

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
