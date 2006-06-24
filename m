Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWFXX20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWFXX20 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 19:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWFXX20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 19:28:26 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:24951 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751177AbWFXX2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 19:28:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=e6LgpxmDB+6PTBhh3Sw6XsW1LBd202vB3XwsYPfh9iQki9UHqgU/hyCdvmc/+DnP5H27Q3tOtCHOo8dllxVg2CkbW5GQGKY4aelV/DM6SUg7ZSPqQIP9uAppX5lg78ynBfiPIn4bjTkd6CzisdkUZ9jIyQEt4pFXzd9Ab9l42IQ=
Message-ID: <a44ae5cd0606241628u18fc9530g9dfbbfca441309fc@mail.gmail.com>
Date: Sat, 24 Jun 2006 16:28:24 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.17-mm2 -- Slab corruption, plus invalid opcode: 0000 [#1] -- 4K_STACKS PREEMPT -- last sysfs file: /block/md0/dev
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slab corruption: start=f7bba640, len=1424
030: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a8 8b 9b 50
Prev obj: start=f7bba0b0, len=1424
000: 01 00 00 00 00 b0 51 f7 02 00 00 00 40 01 40 00
010: 00 00 00 00 ff ff ff ff 33 02 00 00 7b 00 00 00
Next obj: start=f7bbabd0, len=1424
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

acpi_processor-0758 [86] processor_preregister_: Error while parsing
_PSD domain information. Assuming no coordination
invalid opcode: 0000 [#1]
4K_STACKS PREEMPT
last sysfs file: /block/md0/dev
Modules linked in: speedstep_centrino cpufreq_stats freq_table
cpufreq_powersave cpufreq_performance cpufreq_conservative video
thermal sony_acpi processor fan container button battery asus_acpi ac
vfat fat nls_utf8 ntfs dm_mod sr_mod sbp2 scsi_mod parport_pc lp
parport snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd soundcore rtc ipw2200
snd_page_alloc sdhci mmc_core pcspkr ohci1394 ieee80211
ieee80211_crypt 8139too mii ieee1394 ehci_hcd uhci_hcd joydev
CPU:    0
EIP:    0060:[<c13afab1>]    Not tainted VLI
EFLAGS: 00010287   (2.6.17-mm2 #2)
EIP is at cpufreq_register_driver+0x36/0x129
eax: 28f290f8   ebx: c1f8f9e0   ecx: f7b83000   edx: 00000000
esi: f8bbf38b   edi: f8bbf384   ebp: c3c3c39e   esp: f7b83ed0
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2629, ti=f7b83000 task=c1d68c10 task.ti=f7b83000)
Stack: f8b80053 f7b83fb4 c1030e07 00000016 00000370 c121f564 c121f564 00000530
       00000000 00000003 f8bbf380 f8bba308 f8bba1f0 f8bba2e0 f7a4a9dc f8bbae48
       00000017 00000015 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace:
 <b894ff5c> 0xb894ff5c
Code: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5 71 f0 2c 5a c0 fe 06
c1 a5 c2 0f 17 00 00 00 00 08 00 00 00 01 00 00 00 ad 4e ad de ff <ff>
ff ff ff ff ff ff e8 84 14 f7 00 00 00 00 c8 5d c7 c1 d0 eb
EIP: [<c13afab1>] cpufreq_register_driver+0x36/0x129 SS:ESP 0068:f7b83ed0
 acpi_processor-0758 [86] processor_preregister_: Error while parsing
_PSD domain information. Assuming no coordination
invalid opcode: 0000 [#2]
4K_STACKS PREEMPT
last sysfs file: /block/md0/dev
Modules linked in: acpi_cpufreq speedstep_centrino cpufreq_stats
freq_table cpufreq_powersave cpufreq_performance cpufreq_conservative
video thermal sony_acpi processor fan container button battery
asus_acpi ac vfat fat nls_utf8 ntfs dm_mod sr_mod sbp2 scsi_mod
parport_pc lp parport snd_intel8x0 snd_ac97_codec snd_ac97_bus
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore rtc ipw2200
snd_page_alloc sdhci mmc_core pcspkr ohci1394 ieee80211
ieee80211_crypt 8139too mii ieee1394 ehci_hcd uhci_hcd joydev
CPU:    0
EIP:    0060:[<c13afab1>]    Not tainted VLI
EFLAGS: 00010282   (2.6.17-mm2 #2)
EIP is at cpufreq_register_driver+0x36/0x129
eax: 28f290f8   ebx: c1f76564   ecx: c1da7000   edx: 00000000
esi: f8bc2e0b   edi: f8bc2e04   ebp: c3c3c39e   esp: c1da7ed0
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2631, ti=c1da7000 task=f7a959b0 task.ti=c1da7000)
Stack: f8b8406f c1da7fb4 c1030e07 00000017 00000398 c121f564 c121f564 00000500
       00000001 00000002 f8bc2e00 f8bb9e34 f8bb9d1c f8bb9e0c f78cd278 f8bba7a4
       00000018 00000016 00000008 00000000 00000000 00000000 00000000 00000000
Call Trace:
 <b894ff5c> 0xb894ff5c
Code: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5 71 f0 2c 5a c0 fe 06
c1 a5 c2 0f 17 00 00 00 00 08 00 00 00 01 00 00 00 ad 4e ad de ff <ff>
ff ff ff ff ff ff e8 84 14 f7 00 00 00 00 c8 5d c7 c1 d0 eb
EIP: [<c13afab1>] cpufreq_register_driver+0x36/0x129 SS:ESP 0068:c1da7ed0
