Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTLIAXZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 19:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbTLIAXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 19:23:25 -0500
Received: from mail.designassembly.de ([217.115.138.177]:38368 "EHLO
	mail.designassembly.de") by vger.kernel.org with ESMTP
	id S262109AbTLIAXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 19:23:23 -0500
Message-ID: <3FD515F9.2020808@designassembly.de>
Date: Tue, 09 Dec 2003 01:23:21 +0100
From: Michael Heyse <m.heyse@designassembly.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: LBA48 and ALI15X3 rev 0xC1
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I understand from skimming through last year's kernel archive,

"ALi IDE controllers up to revision C4h don't support LBA48 in DMA mode,
later revisions can do both PIO and DMA with LBA48 addressing."

Now I'm running 2.6.0-test10-mm1 (and have also tried 2.6.0-test11) on 
an Asus P5A-B board (ALI15X3 revision 0xC1), so I can't use LBA48 and 
DMA, the driver truncates the size of any bigger disk to 137 GB. So far, 
so good. But shouldn't I be able to access the entire disk in PIO mode? 
Even if I compile the kernel without CONFIG_IDEDMA_PCI_AUTO, dmesg tells me

hdc: SAMSUNG SP1604N, ATA DISK drive
hdc: max request size: 128KiB
hdc: cannot use LBA48 - full capacity 312581808 sectors (160041 MB)
hdc: 268435456 sectors (137438 MB) w/2048KiB Cache, CHS=16709/255/63

Am I missing something or is LBA48 completely disabled for revisions <= 
0xC4?

(PS: when booting with a gentoo boot-cd (kernel 2.4.21-gss), I was able 
to access the whole disk, although I couldn't try if access was totally 
error-free.)

Thanks,

Michael
