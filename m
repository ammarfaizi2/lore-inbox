Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbTJDOn7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 10:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbTJDOn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 10:43:59 -0400
Received: from nan-smtp-06.noos.net ([212.198.2.75]:60730 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id S262061AbTJDOn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 10:43:58 -0400
Message-ID: <3F7EDCDD.7090500@free.fr>
Date: Sat, 04 Oct 2003 16:44:45 +0200
From: Philippe Lochon <plochon.n0spam@free.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en, fr-fr, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: P4C800E-Dlx: ICH5/S-ATA and Intel Pro onboard network incompatibility
 ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running Mandrake 9.2RC1 (kernel 2.4.22) and I can't make work S-ATA 
boot drive and Intel Pro onboard network.

The Asus P4C800E-Dlx in the only mainboard in the P4x800 family with 
ICH5R and Intel 82547EI (Gb onboard chip, it uses e1000 driver).

The chips share the same IRQ :
# grep eth0 /proc/interrupts
  17:         83   IO-APIC-level  Intel ICH5, eth0
(note that there's no error about this in syslog)

1) Boot on S-ATA drive / Mandrake 9.2RC1 with "acpi=off"
-> boot OK, but no ping, "NETDEV WATCHDOG: eth0: transmit timed out" in 
syslog.
(full log and config on http://plochon.free.fr/mdk92RC1.html )

2) Boot on S-ATA drive / Mandrake 9.2RC1 with "acpi=off" and "noapic"
-> boot hang (when displays "hde: attached ide_disk driver" where hde is 
the S-ATA boot drive)

3) Same tests but boot on CD with Knoppix 3.3 (Kernel 2.4.22)
-> same results

4) S-ATA drive physically removed, boot on CD / Knoppix 3.3 with 
"acpi=off" and "noapic"
-> boot OK, network OK : it works !

Is there a way to make S-ATA and Intel Pro work together, or is it an 
incompatibility ?

Thanks,
Philippe

My hardware configuration:
P4C800E-Dlx, P4C@2.6Ghz, 256Mb, 1 Seagate S-ATA drive plugged on 
standard S-ATA connector (-> not on S-ATA RAID connector)
IDE Bios settings :
Onboard IDE operate mode	: Enhanced mode
Enhanced mode support on	: S-ATA
Configure S-ATA as RAID		: No


