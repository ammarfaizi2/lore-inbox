Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbULQQLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbULQQLn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 11:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbULQQLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 11:11:43 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:10410 "EHLO
	apothis.allegientsystems.com") by vger.kernel.org with ESMTP
	id S261526AbULQQLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 11:11:20 -0500
Message-ID: <41C3051D.6080709@optonline.net>
Date: Fri, 17 Dec 2004 11:11:09 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Newbury <s_j_newbury@yahoo.co.uk>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec driver suspend bug ahc_dv_0
References: <20041217160345.95366.qmail@web25007.mail.ukl.yahoo.com>
In-Reply-To: <20041217160345.95366.qmail@web25007.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The driver has never supported suspend, unfortunately, but I have a 
messy-but-mostly-correct patch for this that I can send you later.

Steven Newbury wrote:

>(Using current bk linus kernel 20041216)
>When attempting to use ACPI sleep states on this system, one of the Adaptec
>driver kernel threads fails to stop:
>
>Dec 17 00:32:47 comet kernel:  stopping tasks failed (1 tasks remaining)
>Dec 17 00:32:47 comet kernel: Restarting tasks...<6> Strange, ahc_dv_0 not stop
>
>The ahc_dv_0 thread then spins using 100% CPU in System until the computer is
>rebooted.
>
>lspci output:
>
>00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
>(rev 44)
>00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x
>AGP]
>00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 12)
>00:07.1 IDE interface: VIA Technologies, Inc.
>VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
>00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
>Controller (rev 08)
>00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management (rev 20)
>00:08.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
>00:09.0 Ethernet controller: Accton Technology Corporation EN-1216 Ethernet
>Adapter (rev 11)
>00:0b.0 Multimedia audio controller: ESS Technology ES1969 Solo-1 Audiodrive
>(rev 01)
>01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)
>
>
>=====
>Steve
>
>
>	
>	
>		
>___________________________________________________________ 
>ALL-NEW Yahoo! Messenger - all new features - even more fun! http://uk.messenger.yahoo.com
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

