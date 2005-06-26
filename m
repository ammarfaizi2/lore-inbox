Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVFZXRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVFZXRe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 19:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVFZXRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 19:17:34 -0400
Received: from delphi.webserversystems.com ([209.59.154.2]:28615 "EHLO
	delphi.webserversystems.com") by vger.kernel.org with ESMTP
	id S261624AbVFZXR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 19:17:29 -0400
Message-ID: <45727.69.136.143.12.1119827849.squirrel@bkaeg.org>
Date: Sun, 26 Jun 2005 19:17:29 -0400 (EDT)
Subject: unexpected IRQ trap at vector ac (kernel oddity)
From: "AG" <agreen@bkaeg.org>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - delphi.webserversystems.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32617 32003] / [47 12]
X-AntiAbuse: Sender Address Domain - bkaeg.org
X-Source: /usr/local/cpanel/3rdparty/bin/php
X-Source-Args: /usr/local/cpanel/3rdparty/bin/php /usr/local/cpanel/base/3rdparty/squirrelmail/src/compose.php 
X-Source-Dir: :/base/3rdparty/squirrelmail/src
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone come across the 'unexpected IRQ trap at vector ac' error ? I've
been very perplexed by this issue. At present I'm running a crippled SMP
setup. It appears that I may have a corrupted MP Table.

I can boot the system if I disable MP table / APIC from the BIOS.
The problem is that I am forced to use a UP instead of SMP setup.
Not a very desireable situation.

I have a fairly robust ASUS A7m266 mboard. The symptoms occured
immediately after I added an additional 512MB SDRAM PC3100, giving me 1GB
total phys RAM.

System specs :

Dual Athlon XP 2.4Ghz CPUs
1GB RAM PC3100
GeForce2 Ti4200 graphics Card
Slack 10.1 (2.6.11.12) kernel

-------------8<---snip----8<---
Error rec'd:
Total 2 processors activited bogomips (7913.47)
checking 2 TSC synchro acros 2CPU passed
Brought up 2CPUs
Unexpected IRQ trap at vector AC
PCI BIOS revision 2.0 entry at
PCI using config type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings probably your BIOS
does not setup all CPUS

Unexpected IRQ trap at vector ab
-------------8<---snip----8<---


What I've done to BIOS as work arounds:

1) shut of CPU1/CPU2 cache
2) disabled power mgmt
3) disabled APIC
4) disabled MP table (forced box to run w/one CPU -not desireable)

modified '/etc/lilo.conf'

append="hdc=ide-cd pci=noacpi acpi=off"

None of the above actions solved the problem of the system booting with
one CPU only. When I setup BIOS defaults the system hangs as described
above.

So more recently, I update the kernel from 2.6.10 to 2.6.11.12. To no
avail the issue is unchanged.

I'm thinking that I may have to reflash the BIOS, not easy to do when you
run exclusively LINUX. I suppose I could boot the machine w/an XP CD, and
then flash the BIOS.

Any thoughts? Has anyone witnessed and solved this issue ?
Thx in advance for the help.




-- 

AG

