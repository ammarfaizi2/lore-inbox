Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753034AbWKISnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbWKISnZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 13:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbWKISnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 13:43:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:51412 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1753034AbWKISnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 13:43:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=dwxbThIWuIFEwfIlGHmt5mgkI8J0SoqZohZogvzkTax8cD9/oeUlnvygEpTmCPzGcgzDtt6ReM1FT5kG3fpIccXK1xfX88bT/BgN5iMO6EaLzT8dRwe5oyP5lcK6GtWrBo9UC23DEVd6V+x/R30z+9FHxoBWHBokKr3c4VVP1ck=
Message-ID: <40f323d00611091043g407231e2nfcd7ed3fc06e711a@mail.gmail.com>
Date: Thu, 9 Nov 2006 19:43:17 +0100
From: "Benoit Boissinot" <bboissin@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.19-rc5-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061108015452.a2bb40d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_44445_22523598.1163097797556"
References: <20061108015452.a2bb40d2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_44445_22523598.1163097797556
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 11/8/06, Andrew Morton <akpm@osdl.org> wrote:
>
> Temporarily at
>
> http://userweb.kernel.org/~akpm/2.6.19-rc5-mm1/
>
> will turn up at
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm1/
>
> when kernel.org mirroring catches up.
>

I got the following oops when undocking my laptop:

[27525.704000] ACPI: undocking
[27526.076000] usb 3-1: USB disconnect, address 2
[27526.228000] usb 4-3: USB disconnect, address 2
[27526.232000] BUG: unable to handle kernel paging request at virtual
address 00200200
[27526.232000]  printing eip:
[27526.232000] e8074e26
[27526.232000] *pde = 00000000
[27526.232000] Oops: 0002 [#1]
[27526.232000] last sysfs file: /class/net/eth0/carrier
[27526.232000] Modules linked in: af_packet binfmt_misc rfcomm l2cap
bluetooth ipv6 capability commoncap i915 drm acpi_cpufreq
cpufreq_userspace cpufreq_stats cpufreq_powersave cpufreq_ondemand
freq_table cpufreq_conservative video output sr_mod cdrom sbs
sony_acpi i2c_ec i2c_core button dock battery container ac backlight
dm_mod md_mod sbp2 lp shpchp pci_hotplug sg usb_storage joydev tsdev
libusual pcmcia usbhid irda evdev crc_ccitt psmouse serio_raw
snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss
ata_generic snd_pcm snd_timer ipw2200 parport_pc parport snd soundcore
snd_page_alloc intel_agp agpgart pcspkr ieee80211 ieee80211_crypt
yenta_socket rsrc_nonstatic pcmcia_core tg3 iTCO_wdt rtc ext3 jbd
mbcache ohci1394 ieee1394 ehci_hcd uhci_hcd usbcore sd_mod ata_piix
libata scsi_mod thermal processor fan
[27526.232000] CPU:    0
[27526.232000] EIP:    0060:[<e8074e26>]    Not tainted VLI
[27526.232000] EFLAGS: 00010002   (2.6.19-rc5-mm1 #18)
[27526.232000] EIP is at
scsi_device_dev_release_usercontext+0x36/0x100 [scsi_mod]
[27526.232000] eax: e3d88890   ebx: e3d88808   ecx: 00100100   edx: 00200200
[27526.232000] esi: 00000286   edi: e3d88800   ebp: e45bd014   esp: dfdb1e3c
[27526.232000] ds: 007b   es: 007b   ss: 0068
[27526.232000] Process khubd (pid: 1739, ti=dfdb0000 task=dfe4f030
task.ti=dfdb0000)
[27526.232000] Stack: e3d88a64 e8074df0 c0374580 e45bd07c c01280e2
e3d888f8 c03745dc c0233182
[27526.232000]        c03745dc e3d888f8 c03745dc c0374580 c01d53e9
e3d88910 c01d5430 e425ec28
[27526.232000]        ffffffed c01d6065 e3d88890 e425ec28 ffffffed
e8074667 e425ec00 00000202
[27526.232000] Call Trace:
[27526.232000]  [<e8074df0>]
scsi_device_dev_release_usercontext+0x0/0x100 [scsi_mod]
[27526.232000]  [execute_in_process_context+34/112]
execute_in_process_context+0x22/0x70
[27526.232000]  [device_release+18/112] device_release+0x12/0x70
[27526.232000]  [kobject_cleanup+73/144] kobject_cleanup+0x49/0x90
[27526.232000]  [kobject_release+0/16] kobject_release+0x0/0x10
[27526.232000]  [kref_put+53/160] kref_put+0x35/0xa0
[27526.232000]  [<e8074667>] __scsi_remove_device+0x67/0x80 [scsi_mod]
[27526.232000]  [<e8073a33>] scsi_forget_host+0x43/0x50 [scsi_mod]
[27526.232000]  [<e806c6f2>] scsi_remove_host+0x32/0xb0 [scsi_mod]
[27526.232000]  [<e83c9c5e>] storage_disconnect+0xe/0x20 [usb_storage]
[27526.232000]  [<e80e095f>] usb_unbind_interface+0x4f/0xa0 [usbcore]
[27526.232000]  [__device_release_driver+100/144]
__device_release_driver+0x64/0x90
[27526.232000]  [device_release_driver+34/64] device_release_driver+0x22/0x40
[27526.232000]  [bus_remove_device+92/144] bus_remove_device+0x5c/0x90
[27526.232000]  [device_del+327/416] device_del+0x147/0x1a0
[27526.232000]  [<e80ddf78>] usb_disable_device+0x78/0xe0 [usbcore]
[27526.232000]  [<e80da614>] usb_disconnect+0x94/0xe0 [usbcore]
[27526.232000]  [<e80db260>] hub_thread+0x200/0xc40 [usbcore]
[27526.232000]  [autoremove_wake_function+0/80]
autoremove_wake_function+0x0/0x50
[27526.232000]  [<e80db060>] hub_thread+0x0/0xc40 [usbcore]
[27526.232000]  [kthread+169/224] kthread+0xa9/0xe0
[27526.232000]  [kthread+0/224] kthread+0x0/0xe0
[27526.232000]  [kernel_thread_helper+7/28] kernel_thread_helper+0x7/0x1c
[27526.232000]  =======================
[27526.232000] Code: ff ff 89 1c 24 89 74 24 04 89 6c 24 0c 8b 68 64
8d 55 ec 9c 5e fa ff 82 58 01 00 00 8d 98 78 ff ff ff 8b 53 04 8b 88
78 ff ff ff <89> 0a 89 51 04 b9 00 01 10 00 c7 43 04 00 02 20 00 8d 58
80 8b
[27526.232000] EIP: [<e8074e26>]
scsi_device_dev_release_usercontext+0x36/0x100 [scsi_mod] SS:ESP
0068:dfdb1e3c

full dmesg attached, I can test patches and provide any useful
information if needed (just not now because the dock is at work).

thanks,

Benoit

------=_Part_44445_22523598.1163097797556
Content-Type: application/x-gzip; name=kern.log.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eubicuwf
Content-Disposition: attachment; filename="kern.log.gz"

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
PHZPxyOyjNzKoPofDLjPIYGPAAA=
------=_Part_44445_22523598.1163097797556--
