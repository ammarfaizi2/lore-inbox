Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbUANPsv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 10:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbUANPsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 10:48:50 -0500
Received: from smtp.uniroma2.it ([160.80.6.16]:37124 "EHLO mail-gw.uniroma2.it")
	by vger.kernel.org with ESMTP id S261872AbUANPss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 10:48:48 -0500
Message-ID: <400564AD.6050407@tiscali.it>
Date: Wed, 14 Jan 2004 16:47:57 +0100
From: Mauro Andreolini <m.andreolini@tiscali.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniele Venzano <webvenza@libero.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: problems with suspend-to-disk (ACPI), 2.6.1-rc2
References: <3FE5F1110001ED59@mail-4.tiscali.it> <20040113131806.GA343@elf.ucw.cz> <20040113212811.GA12144@gateway.milesteg.arr>
In-Reply-To: <20040113212811.GA12144@gateway.milesteg.arr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: scanned for viruses!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniele Venzano wrote:

 >
 >I added support for sis900 and the bash was being killed even before the
 >driver had any support for suspend/resume.
 >I reported that same problem (shell being killed) some time ago, there 
was
 >some follow up, but if I remember right no solution was found at the
 >time.
 >
 >>>bad: scheduling while atomic!
 >>>Call Trace:
 >>> [<c0119d16>] schedule+0x586/0x590
 >>> [<c0124f5c>] __mod_timer+0xfc/0x170
 >>> [<c0125ab3>] schedule_timeout+0x63/0xc0
 >>> [<c0125a40>] process_timeout+0x0/0x10
 >>> [<c01da44b>] pci_set_power_state+0xeb/0x190
 >>> [<ec947823>] sis900_resume+0x63/0x130 [sis900]
 >>> [<c01dc9a6>] pci_device_resume+0x26/0x30
 >
 >
 >I'll check this, the card keeps working after resume or not ?
 >
 >Thanks, bye.
 >
Hi Daniele,

the card does _not_ work after resume, both on 2.6.1-rc2 vanilla and 
with Pavel's patch.
I have to manually

rmmod sis900
modprobe sis900
ifconfig <ip> eth0 up

After that, it starts working again.

Bye
Mauro Andreolini


