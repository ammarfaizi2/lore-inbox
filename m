Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTKCHM6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 02:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbTKCHM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 02:12:58 -0500
Received: from scanmail1.cableone.net ([24.116.0.121]:29715 "EHLO
	scanmail1.cableone.net") by vger.kernel.org with ESMTP
	id S261936AbTKCHM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 02:12:57 -0500
Message-ID: <3FA5FFF7.2020006@cableone.net>
Date: Mon, 03 Nov 2003 00:12:55 -0700
From: Gary Wolfe <gpwolfe@cableone.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [crash/panic] Linux-2.6.0-test9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SMTP-HELO: cableone.net
X-SMTP-MAIL-FROM: gpwolfe@cableone.net
X-SMTP-PEER-INFO: 24-116-194-85.cpe.cableone.net [24.116.194.85]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have:

Asus P4C800 Deluxe w/2.4GHz P4 (no HT and not 800Mhz bus)

Tried test8 and, now, test9 and both exhibit same problem.

The issue seems to be related to the PnPBIOS support under the Plug and 
Play Kconfig category.  When enabled I get a crash of the form:

Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f5350
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x5f3a, dseg 0xf0000
general protection fault: 0000 [#1]
CPU: 0
EIP: 0098:[<00002b60>] Not tainted
EFLAGS: 00010083
EIP is at 0x2b60
eax: 000023d6  ebx: 0000007a  ecx: 00010000  edx: 00000001
esi: dfed244e  edi: 0000006d  ebp: dfed0000  esp: dfed9eda
ds: 00b0  es: 00b0  ss: 0068
Process Swapper (pid:1 threadinfo=dfed8000 task=c151b900)
Stack: 000003d6 23d629d2 00000000 815d006d 0000d3ff 00010001 9f2c80fc 
006dd408
9f2c0000 d3ff9f08 00060001 61f990c0c 010c010c 007b6054 0000007b 00a08000
601000b0 00a85fd6 00000082 000b0000 00010090 00a80000 00b00000 00a00001
Call Trace:

Code: Bad EIP value.
<0>Kernel panic: Attempted to kill init!

....blinking  cursor and nothing else.

If I remove the PNPBIOS option I get past this point.  I would be happy 
to email my full .config should anyone wish to look at it.  I'd also be 
happy to test any patches anyone may have for this issue.

Thanks,
Gary



