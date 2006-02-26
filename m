Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWBZTnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWBZTnI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 14:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWBZTnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 14:43:08 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:48683 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751349AbWBZTnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 14:43:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aD/df2JBN77hyr8fIR+3saRD9uH2V+PM9UtvZsGK8KWrdH4fdJJNMJydITEVon9ZX07YbS+JORtXBPB698M8IUO77JxuWC5WIN3aNqsw0xfJHqURC9HKPuGm5T9QiK7C1t8Hea+d4PbZDm5cAzXJ1ZORuo9difmq+6oBYvZyeTA=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Dave Jones <davej@redhat.com>
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Date: Sun, 26 Feb 2006 20:43:22 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200602261721.17373.jesper.juhl@gmail.com> <9a8748490602260835l2430e841p2bf02c1f99e55b91@mail.gmail.com> <20060226193121.GG7851@redhat.com>
In-Reply-To: <20060226193121.GG7851@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602262043.22463.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 February 2006 20:31, Dave Jones wrote:
> On Sun, Feb 26, 2006 at 05:35:49PM +0100, Jesper Juhl wrote:
> 
>  > And for those who want to see a list of the unique errors, here they are :
>  > 
>  > make: *** [.tmp_vmlinux1] Error 1
>  > make: *** [arch/i386/kernel] Error 2
>  > make: *** [drivers] Error 2
>  > make: *** [sound] Error 2
>  > make: *** [vmlinux] Error 1
>  > make[1]: *** [arch/i386/kernel/irq.o] Error 1
>  > make[1]: *** [drivers/acpi] Error 2
>  > make[1]: *** [drivers/atm] Error 2
>  > make[1]: *** [drivers/isdn] Error 2
>  > make[1]: *** [drivers/media] Error 2
>  > make[1]: *** [drivers/mtd] Error 2
>  > make[1]: *** [drivers/scsi] Error 2
>  > make[1]: *** [drivers/usb] Error 2
>  > make[1]: *** [sound/isa] Error 2
>  > make[1]: *** [sound/oss] Error 2
>  > make[2]: *** [drivers/acpi/numa.o] Error 1
>  > make[2]: *** [drivers/acpi/numa.o] Error 1  LD [M]  fs/ext3/ext3.o
>  > make[2]: *** [drivers/acpi/osl.o] Error 1
>  > make[2]: *** [drivers/atm/fore200e_pca_fw.c] Error 254
>  > make[2]: *** [drivers/isdn/hysdn] Error 2
>  > make[2]: *** [drivers/media/dvb] Error 2
>  > make[2]: *** [drivers/mtd/maps] Error 2
>  > make[2]: *** [drivers/scsi/aic7xxx] Error 2
>  > make[2]: *** [drivers/usb/net] Error 2
>  > make[2]: *** [sound/isa/opti9xx] Error 2
>  > make[3]: *** [drivers/isdn/hysdn/hysdn_net.o] Error 1
>  > make[3]: *** [drivers/media/dvb/ttpci] Error 2
>  > make[3]: *** [drivers/mtd/maps/nettel.o] Error 1
>  > make[3]: *** [drivers/scsi/aic7xxx/aicasm/aicasm] Error 2
>  > make[3]: *** [drivers/usb/net/cdc_subset.o] Error 1
>  > make[3]: *** [sound/isa/opti9xx/opti92x-ad1848.o] Error 1
>  > make[3]: *** [sound/isa/opti9xx/opti93x.o] Error 1
>  > make[4]: *** [aicasm] Error 1
>  > make[4]: *** [drivers/media/dvb/ttpci/av7110_firm.h] Error 255
> 
> You snipped out the interesting parts, which is 1-2 lines before this
> (Grepping for Error: should do it)
> 

$ grep -B 3 Error *.log

rand1.log-: undefined reference to `framebuffer_release'
rand1.log-drivers/built-in.o(.init.text+0x192b): In function `gxfb_init':
rand1.log-: undefined reference to `fb_get_options'
rand1.log:make: *** [.tmp_vmlinux1] Error 1
--
rand10.log-drivers/isdn/hysdn/hysdn_net.c:27: error: `param_get_unsigned' undeclared here (not in a function)
rand10.log-drivers/isdn/hysdn/hysdn_net.c:27: error: initializer element is not constant
rand10.log-drivers/isdn/hysdn/hysdn_net.c:27: error: (near initialization for `__param_hynet_enable.get')
rand10.log:make[3]: *** [drivers/isdn/hysdn/hysdn_net.o] Error 1
rand10.log:make[2]: *** [drivers/isdn/hysdn] Error 2
rand10.log:make[1]: *** [drivers/isdn] Error 2
rand10.log:make: *** [drivers] Error 2
--
rand12.log-: undefined reference to `voyager_status'
rand12.log-fs/built-in.o(.init.text+0x1851): In function `configfs_init':
rand12.log-: undefined reference to `kernel_subsys'
rand12.log:make: *** [vmlinux] Error 1
--
rand13.log-drivers/acpi/osl.c:249: error: `AmlCode' undeclared (first use in this function)
rand13.log-drivers/acpi/osl.c:249: error: (Each undeclared identifier is reported only once
rand13.log-drivers/acpi/osl.c:249: error: for each function it appears in.)
rand13.log:make[2]: *** [drivers/acpi/osl.o] Error 1
rand13.log:make[1]: *** [drivers/acpi] Error 2
rand13.log:make: *** [drivers] Error 2
--
rand15.log-: undefined reference to `fg_console'
rand15.log-drivers/built-in.o(.text+0x5173f): In function `device_suspend':
rand15.log-: undefined reference to `vc_cons'
rand15.log:make: *** [.tmp_vmlinux1] Error 1
--
rand16.log-drivers/mtd/maps/nettel.c:418: error: (Each undeclared identifier is reported only once
rand16.log-drivers/mtd/maps/nettel.c:418: error: for each function it appears in.)
rand16.log-drivers/mtd/maps/nettel.c:418: warning: implicit declaration of function `MKDEV'
rand16.log:make[3]: *** [drivers/mtd/maps/nettel.o] Error 1
rand16.log:make[2]: *** [drivers/mtd/maps] Error 2
rand16.log:make[1]: *** [drivers/mtd] Error 2
rand16.log:make: *** [drivers] Error 2
--
rand17.log-include/linux/usb.h:643: undefined reference to `usb_register_driver'
rand17.log-drivers/built-in.o(.text+0x60d45): In function `cpia2_usb_cleanup':
rand17.log-drivers/media/video/cpia2/cpia2_usb.c:907: undefined reference to `usb_deregister'
rand17.log:make: *** [.tmp_vmlinux1] Error 1
--
rand18.log-lib/lib.a(kobject_uevent.o)(.text+0x3da):lib/kobject_uevent.c:185: undefined reference to `uevent_helper'
rand18.log-lib/lib.a(kobject_uevent.o)(.text+0x3ef): In function `kobject_uevent':
rand18.log-include/linux/kmod.h:46: undefined reference to `uevent_helper'
rand18.log:make: *** [.tmp_vmlinux1] Error 1
--
rand19.log-: undefined reference to `alloc_ltalkdev'
rand19.log-drivers/built-in.o(.init.text+0x9899): In function `ltpc_probe':
rand19.log-: undefined reference to `alloc_ltalkdev'
rand19.log:make: *** [.tmp_vmlinux1] Error 1
--
rand2.log-  LD      init/built-in.o
rand2.log-  LD      vmlinux
rand2.log-kernel/built-in.o(.data+0x8b8): undefined reference to `uevent_helper'
rand2.log:make: *** [vmlinux] Error 1
--
rand20.log-drivers/acpi/numa.c:233: error: `NR_NODE_MEMBLKS' undeclared (first use in this function)
rand20.log-drivers/acpi/numa.c:233: error: (Each undeclared identifier is reported only once
rand20.log-drivers/acpi/numa.c:233: error: for each function it appears in.)
rand20.log:make[2]: *** [drivers/acpi/numa.o] Error 1
rand20.log:make[1]: *** [drivers/acpi] Error 2
rand20.log:make: *** [drivers] Error 2
--
rand21.log-lib/lib.a(kobject_uevent.o)(.text+0x3b0):lib/kobject_uevent.c:185: undefined reference to `uevent_helper'
rand21.log-lib/lib.a(kobject_uevent.o)(.text+0x3cb): In function `kobject_uevent':
rand21.log-include/linux/kmod.h:46: undefined reference to `uevent_helper'
rand21.log:make: *** [.tmp_vmlinux1] Error 1
--
rand22.log-: undefined reference to `usb_register_driver'
rand22.log-drivers/built-in.o(.text+0x3b6e0): In function `cpia2_usb_cleanup':
rand22.log-: undefined reference to `usb_deregister'
rand22.log:make: *** [.tmp_vmlinux1] Error 1
--
rand23.log-: undefined reference to `uevent_helper'
rand23.log-lib/lib.a(kobject_uevent.o)(.text+0x3a3): In function `kobject_uevent':
rand23.log-: undefined reference to `uevent_helper'
rand23.log:make: *** [vmlinux] Error 1
--
rand25.log-sound/isa/opti9xx/opti92x-ad1848.c:2091: error: for each function it appears in.)
rand25.log-sound/isa/opti9xx/opti92x-ad1848.c: In function `alsa_card_opti9xx_exit':
rand25.log-sound/isa/opti9xx/opti92x-ad1848.c:2118: error: `opti9xx_pnpc_driver' undeclared (first use in this function)
rand25.log:make[3]: *** [sound/isa/opti9xx/opti92x-ad1848.o] Error 1
rand25.log:make[2]: *** [sound/isa/opti9xx] Error 2
rand25.log:make[1]: *** [sound/isa] Error 2
rand25.log:make: *** [sound] Error 2
--
rand26.log-: undefined reference to `uevent_helper'
rand26.log-lib/lib.a(kobject_uevent.o)(.text+0x322): In function `kobject_uevent':
rand26.log-: undefined reference to `uevent_helper'
rand26.log:make: *** [.tmp_vmlinux1] Error 1
--
rand27.log-arch/i386/mach-voyager/built-in.o(.text+0x494): In function `thread':
rand27.log-arch/i386/mach-voyager/voyager_thread.c:141: undefined reference to `voyager_status'
rand27.log-arch/i386/mach-voyager/built-in.o(.text+0x4dc):arch/i386/mach-voyager/voyager_thread.c:146: undefined reference to `voyager_status'
rand27.log:make: *** [.tmp_vmlinux1] Error 1
--
rand28.log-drivers/net/irda/tekram-sir.c:73: undefined reference to `irda_unregister_dongle'
rand28.log-drivers/built-in.o(.exit.text+0x4f6): In function `litelink_sir_cleanup':
rand28.log-drivers/net/irda/litelink-sir.c:74: undefined reference to `irda_unregister_dongle'
rand28.log:make: *** [.tmp_vmlinux1] Error 1
--
rand29.log-: undefined reference to `pci_acpi_scan_root'
rand29.log-drivers/built-in.o(.text+0x7d33c): In function `memory_block_action':
rand29.log-: undefined reference to `remove_memory'
rand29.log:make: *** [vmlinux] Error 1
--
rand3.log-: undefined reference to `fg_console'
rand3.log-drivers/built-in.o(.text+0xaeb2e): In function `device_suspend':
rand3.log-: undefined reference to `vc_cons'
rand3.log:make: *** [.tmp_vmlinux1] Error 1
--
rand30.log-: undefined reference to `fg_console'
rand30.log-drivers/built-in.o(.text+0xbf8fa): In function `device_suspend':
rand30.log-: undefined reference to `vc_cons'
rand30.log:make: *** [.tmp_vmlinux1] Error 1
--
rand31.log-drivers/mtd/maps/nettel.c:418: error: (Each undeclared identifier is reported only once
rand31.log-drivers/mtd/maps/nettel.c:418: error: for each function it appears in.)
rand31.log-drivers/mtd/maps/nettel.c:418: warning: implicit declaration of function `MKDEV'
rand31.log:make[3]: *** [drivers/mtd/maps/nettel.o] Error 1
rand31.log:make[2]: *** [drivers/mtd/maps] Error 2
rand31.log:make[1]: *** [drivers/mtd] Error 2
--
rand31.log-  LD [M]  drivers/media/video/zr36067.o
rand31.log-  LD      drivers/media/video/built-in.o
rand31.log-  LD      drivers/media/built-in.o
rand31.log:make: *** [drivers] Error 2
--
rand32.log-include/linux/usb.h:643: undefined reference to `usb_register_driver'
rand32.log-drivers/built-in.o(.text+0x1000e3): In function `cpia2_usb_cleanup':
rand32.log-drivers/media/video/cpia2/cpia2_usb.c:907: undefined reference to `usb_deregister'
rand32.log:make: *** [.tmp_vmlinux1] Error 1
--
rand33.log-: undefined reference to `write_tiger'
rand33.log-drivers/built-in.o(.init.text+0x124cc): In function `setup_enternow_pci':
rand33.log-: undefined reference to `netjet_fill_dma'
rand33.log:make: *** [.tmp_vmlinux1] Error 1
--
rand34.log-drivers/acpi/osl.c:249: error: `AmlCode' undeclared (first use in this function)
rand34.log-drivers/acpi/osl.c:249: error: (Each undeclared identifier is reported only once
rand34.log-drivers/acpi/osl.c:249: error: for each function it appears in.)
rand34.log:make[2]: *** [drivers/acpi/osl.o] Error 1
rand34.log:make[1]: *** [drivers/acpi] Error 2
rand34.log:make: *** [drivers] Error 2
--
rand37.log-  CC      drivers/usb/core/hcd-pci.o
rand37.log-aicasm_macro_gram.tab.c:1352: error: previous implicit declaration of 'mmerror' was here
rand37.log-  CC      drivers/scsi/aacraid/commctrl.o
rand37.log:make[4]: *** [aicasm] Error 1
rand37.log:make[3]: *** [drivers/scsi/aic7xxx/aicasm/aicasm] Error 2
rand37.log:make[2]: *** [drivers/scsi/aic7xxx] Error 2
--
rand37.log-  CC      drivers/usb/misc/usbled.o
rand37.log-  LD      drivers/scsi/aacraid/aacraid.o
rand37.log-  LD      drivers/scsi/aacraid/built-in.o
rand37.log:make[1]: *** [drivers/scsi] Error 2
--
rand37.log-  LD      drivers/usb/storage/usb-storage.o
rand37.log-  LD      drivers/usb/storage/built-in.o
rand37.log-  LD      drivers/usb/built-in.o
rand37.log:make: *** [drivers] Error 2
--
rand38.log-drivers/mtd/maps/nettel.c:418: error: for each function it appears in.)
rand38.log-drivers/mtd/maps/nettel.c:418: warning: implicit declaration of function `MKDEV'
rand38.log-  CC      drivers/mtd/chips/cfi_cmdset_0001.o
rand38.log:make[3]: *** [drivers/mtd/maps/nettel.o] Error 1
rand38.log:make[2]: *** [drivers/mtd/maps] Error 2
--
rand38.log-  CC      drivers/mtd/chips/map_absent.o
rand38.log-  CC      drivers/rtc/utils.o
rand38.log-  LD      drivers/mtd/chips/built-in.o
rand38.log:make[1]: *** [drivers/mtd] Error 2
rand38.log-make[1]: *** Waiting for unfinished jobs....
rand38.log-  CC      fs/udf/namei.o
rand38.log-  LD      drivers/rtc/built-in.o
rand38.log:make: *** [drivers] Error 2
--
rand4.log-  CC      sound/oss/msnd.o
rand4.log-make[2]: *** No rule to make target `/etc/sound/msndperm.bin', needed by `sound/oss/msndperm.c'.  Stop.
rand4.log-make[2]: *** Waiting for unfinished jobs....
rand4.log:make[1]: *** [sound/oss] Error 2
rand4.log:make: *** [sound] Error 2
--
rand40.log-  CC [M]  drivers/net/smc-mca.o
rand40.log-aicasm_macro_gram.y:162: error: conflicting types for 'mmerror'
rand40.log-aicasm_macro_gram.tab.c:1352: error: previous implicit declaration of 'mmerror' was here
rand40.log:make[4]: *** [aicasm] Error 1
rand40.log:make[3]: *** [drivers/scsi/aic7xxx/aicasm/aicasm] Error 2
rand40.log:make[2]: *** [drivers/scsi/aic7xxx] Error 2
rand40.log:make[1]: *** [drivers/scsi] Error 2
--
rand40.log-drivers/net/r8169.c:2138: warning: 'txd' might be used uninitialized in this function
rand40.log-  LD      drivers/net/built-in.o
rand40.log-  LD      drivers/telephony/built-in.o
rand40.log:make: *** [drivers] Error 2
--
rand41.log-: undefined reference to `fg_console'
rand41.log-drivers/built-in.o(.text+0xcef8c): In function `device_suspend':
rand41.log-: undefined reference to `vc_cons'
rand41.log:make: *** [vmlinux] Error 1
--
rand42.log-: undefined reference to `usb_register_driver'
rand42.log-drivers/built-in.o(.text+0x11cb50): In function `cpia2_usb_cleanup':
rand42.log-: undefined reference to `usb_deregister'
rand42.log:make: *** [.tmp_vmlinux1] Error 1
--
rand43.log-drivers/net/kgdb_eth.c:107: undefined reference to `netpoll_parse_options'
rand43.log-drivers/built-in.o(.text+0x82d26): In function `init_kgdboe':
rand43.log-drivers/net/kgdb_eth.c:123: undefined reference to `netpoll_setup'
rand43.log:make: *** [.tmp_vmlinux1] Error 1
--
rand44.log-drivers/built-in.o(.text+0x8c35b): In function `cx24110_readreg':
rand44.log-: undefined reference to `i2c_transfer'
rand44.log-drivers/built-in.o(.text+0x8d48f): more undefined references to `i2c_transfer' follow
rand44.log:make: *** [.tmp_vmlinux1] Error 1
--
rand45.log-  LD      drivers/usb/usbfs2/built-in.o
rand45.log-  CC      drivers/usb/net/usbnet.o
rand45.log-drivers/usb/net/cdc_subset.c:213:2: #error You need to configure some hardware for this driver
rand45.log:make[3]: *** [drivers/usb/net/cdc_subset.o] Error 1
rand45.log-make[3]: *** Waiting for unfinished jobs....
rand45.log:make[2]: *** [drivers/usb/net] Error 2
rand45.log:make[1]: *** [drivers/usb] Error 2
rand45.log:make: *** [drivers] Error 2
--
rand46.log-include/asm-i386/mach-default/mach_apic.h: In function `apic_id_registered':
rand46.log-include/asm-i386/mach-default/mach_apic.h:114: error: `APIC_ID' undeclared (first use in this function)
rand46.log-include/asm-i386/mach-default/mach_apic.h:114: error: `phys_cpu_present_map' undeclared (first use in this function)
rand46.log:make[1]: *** [arch/i386/kernel/irq.o] Error 1
rand46.log:make: *** [arch/i386/kernel] Error 2
--
rand47.log-: undefined reference to `mtd_concat_create'
rand47.log-drivers/built-in.o(.exit.text+0xb07): In function `cleanup_sc520cdp':
rand47.log-: undefined reference to `mtd_concat_destroy'
rand47.log:make: *** [.tmp_vmlinux1] Error 1
--
rand48.log-drivers/atm/fore200e_mkfirm -k -b _fore200e_pca_fw \
rand48.log-  -i "" -o drivers/atm/fore200e_pca_fw.c
rand48.log-drivers/atm/fore200e_mkfirm: can't open  for reading
rand48.log:make[2]: *** [drivers/atm/fore200e_pca_fw.c] Error 254
rand48.log:make[1]: *** [drivers/atm] Error 2
rand48.log:make: *** [drivers] Error 2
--
rand5.log-include/linux/usb.h:643: undefined reference to `usb_register_driver'
rand5.log-drivers/built-in.o(.text+0xece25): In function `cpia2_usb_cleanup':
rand5.log-drivers/media/video/cpia2/cpia2_usb.c:907: undefined reference to `usb_deregister'
rand5.log:make: *** [vmlinux] Error 1
--
rand51.log-: undefined reference to `mtd_concat_create'
rand51.log-drivers/built-in.o(.exit.text+0xd36): In function `cleanup_sc520cdp':
rand51.log-: undefined reference to `mtd_concat_destroy'
rand51.log:make: *** [vmlinux] Error 1
--
rand52.log-sound/isa/opti9xx/opti92x-ad1848.c:2091: error: for each function it appears in.)
rand52.log-sound/isa/opti9xx/opti92x-ad1848.c: In function `alsa_card_opti9xx_exit':
rand52.log-sound/isa/opti9xx/opti92x-ad1848.c:2118: error: `opti9xx_pnpc_driver' undeclared (first use in this function)
rand52.log:make[3]: *** [sound/isa/opti9xx/opti92x-ad1848.o] Error 1
rand52.log:make[2]: *** [sound/isa/opti9xx] Error 2
rand52.log:make[1]: *** [sound/isa] Error 2
rand52.log:make: *** [sound] Error 2
--
rand52.log-drivers/acpi/numa.c:233: error: `NR_NODE_MEMBLKS' undeclared (first use in this function)
rand52.log-drivers/acpi/numa.c:233: error: (Each undeclared identifier is reported only once
rand52.log-drivers/acpi/numa.c:233: error: for each function it appears in.)
rand52.log:make[2]: *** [drivers/acpi/numa.o] Error 1
rand52.log:make[1]: *** [drivers/acpi] Error 2
rand52.log:make: *** [drivers] Error 2
--
rand53.log-  LD      init/built-in.o
rand53.log-  LD      .tmp_vmlinux1
rand53.log-kernel/built-in.o(.data+0x8b8): undefined reference to `uevent_helper'
rand53.log:make: *** [.tmp_vmlinux1] Error 1
--
rand55.log-drivers/net/via-velocity.c:279: undefined reference to `register_inetaddr_notifier'
rand55.log-drivers/built-in.o(.text+0xf5e48): In function `velocity_unregister_notifier':
rand55.log-drivers/net/via-velocity.c:284: undefined reference to `unregister_inetaddr_notifier'
rand55.log:make: *** [.tmp_vmlinux1] Error 1
--
rand57.log-drivers/net/kgdb_eth.c:107: undefined reference to `netpoll_parse_options'
rand57.log-drivers/built-in.o(.text+0x33e58): In function `init_kgdboe':
rand57.log-drivers/net/kgdb_eth.c:123: undefined reference to `netpoll_setup'
rand57.log:make: *** [.tmp_vmlinux1] Error 1
--
rand58.log-sound/isa/opti9xx/opti92x-ad1848.c:2091: error: for each function it appears in.)
rand58.log-sound/isa/opti9xx/opti92x-ad1848.c: In function `alsa_card_opti9xx_exit':
rand58.log-sound/isa/opti9xx/opti92x-ad1848.c:2118: error: `opti9xx_pnpc_driver' undeclared (first use in this function)
rand58.log:make[3]: *** [sound/isa/opti9xx/opti92x-ad1848.o] Error 1
rand58.log:make[2]: *** [sound/isa/opti9xx] Error 2
rand58.log:make[1]: *** [sound/isa] Error 2
rand58.log:make: *** [sound] Error 2
--
rand59.log-  LD      .tmp_vmlinux1
rand59.log-drivers/built-in.o(.text+0xbd65c): In function `uart_configure_port':
rand59.log-drivers/serial/serial_core.c:2026: undefined reference to `kgdb_irq'
rand59.log:make: *** [.tmp_vmlinux1] Error 1
--
rand6.log-include/linux/usb.h:643: undefined reference to `usb_register_driver'
rand6.log-drivers/built-in.o(.text+0x12e8d2): In function `cpia2_usb_cleanup':
rand6.log-drivers/media/video/cpia2/cpia2_usb.c:907: undefined reference to `usb_deregister'
rand6.log:make: *** [.tmp_vmlinux1] Error 1
--
rand60.log-: undefined reference to `voyager_status'
rand60.log-arch/i386/mach-voyager/built-in.o(.text+0x397): In function `thread':
rand60.log-: undefined reference to `voyager_status'
rand60.log:make: *** [vmlinux] Error 1
--
rand61.log-  CC      fs/hfs/trans.o
rand61.log-  LD      fs/hfs/hfs.o
rand61.log-  LD      fs/hfs/built-in.o
rand61.log:make[1]: *** [sound/oss] Error 2
rand61.log:make: *** [sound] Error 2
--
rand61.log-  LD      fs/ocfs2/built-in.o
rand61.log-drivers/media/dvb/ttpci/fdump "/usr/lib/hotplug/firmware/dvb-ttpci-01.fw" dvb_ttpci_fw drivers/media/dvb/ttpci/av7110_firm.h
rand61.log-firmware file '/usr/lib/hotplug/firmware/dvb-ttpci-01.fw' not found
rand61.log:make[4]: *** [drivers/media/dvb/ttpci/av7110_firm.h] Error 255
rand61.log:make[3]: *** [drivers/media/dvb/ttpci] Error 2
rand61.log:make[2]: *** [drivers/media/dvb] Error 2
--
rand61.log-  LD      drivers/media/video/bttv.o
rand61.log-  LD      drivers/media/video/msp3400.o
rand61.log-  LD      drivers/media/video/built-in.o
rand61.log:make[1]: *** [drivers/media] Error 2
rand61.log:make: *** [drivers] Error 2
--
rand62.log-drivers/acpi/numa.c:233: error: `NR_NODE_MEMBLKS' undeclared (first use in this function)
rand62.log-drivers/acpi/numa.c:233: error: (Each undeclared identifier is reported only once
rand62.log-drivers/acpi/numa.c:233: error: for each function it appears in.)
rand62.log:make[2]: *** [drivers/acpi/numa.o] Error 1  LD [M]  fs/ext3/ext3.o
rand62.log-
rand62.log:make[1]: *** [drivers/acpi] Error 2
rand62.log:make: *** [drivers] Error 2
--
rand63.log-drivers/built-in.o(.text+0x20ac6): In function `device_suspend':
rand63.log-drivers/base/power/suspend.c:94: undefined reference to `fg_console'
rand63.log-drivers/built-in.o(.text+0x20ace):drivers/base/power/suspend.c:94: undefined reference to `vc_cons'
rand63.log:make: *** [.tmp_vmlinux1] Error 1
--
rand64.log-: undefined reference to `module_alloc'
rand64.log-kernel/built-in.o(.kprobes.text+0x1ce): In function `free_insn_slot':
rand64.log-: undefined reference to `module_free'
rand64.log:make: *** [.tmp_vmlinux1] Error 1
--
rand65.log-drivers/usb/gadget/dummy_hcd.c:2016: undefined reference to `usb_disabled'
rand65.log-drivers/built-in.o(.exit.text+0xd36): In function `cleanup_sc520cdp':
rand65.log-drivers/mtd/maps/sc520cdp.c:284: undefined reference to `mtd_concat_destroy'
rand65.log:make: *** [.tmp_vmlinux1] Error 1
--
rand66.log-aicasm_macro_gram.y:162: error: conflicting types for 'mmerror'
rand66.log-aicasm_macro_gram.tab.c:1352: error: previous implicit declaration of 'mmerror' was here
rand66.log-  CC [M]  drivers/usb/host/ehci-hcd.o
rand66.log:make[4]: *** [aicasm] Error 1
rand66.log:make[3]: *** [drivers/scsi/aic7xxx/aicasm/aicasm] Error 2
rand66.log:make[2]: *** [drivers/scsi/aic7xxx] Error 2
rand66.log:make[1]: *** [drivers/scsi] Error 2
--
rand66.log-  CC [M]  drivers/usb/serial/whiteheat.o
rand66.log-  LD [M]  drivers/usb/serial/usbserial.o
rand66.log-  LD      drivers/usb/built-in.o
rand66.log:make: *** [drivers] Error 2
--
rand67.log-: undefined reference to `usb_register_driver'
rand67.log-drivers/built-in.o(.text+0x57400): In function `cpia2_usb_cleanup':
rand67.log-: undefined reference to `usb_deregister'
rand67.log:make: *** [vmlinux] Error 1
--
rand69.log-drivers/built-in.o(.text+0x3593c): In function `tda8083_writereg':
rand69.log-drivers/media/dvb/frontends/tda8083.c:69: undefined reference to `i2c_transfer'
rand69.log-drivers/built-in.o(.text+0x359e6):drivers/media/dvb/frontends/tda8083.c:84: more undefined references to `i2c_transfer' follow
rand69.log:make: *** [vmlinux] Error 1
--
rand7.log-  LD      init/built-in.o
rand7.log-  LD      .tmp_vmlinux1
rand7.log-kernel/built-in.o(.data+0x8a4): undefined reference to `uevent_helper'
rand7.log:make: *** [.tmp_vmlinux1] Error 1
--
rand70.log-  CC      drivers/usb/host/pci-quirks.o
rand70.log-aicasm_macro_gram.y:162: error: conflicting types for 'mmerror'
rand70.log-aicasm_macro_gram.tab.c:1352: error: previous implicit declaration of 'mmerror' was here
rand70.log:make[4]: *** [aicasm] Error 1
rand70.log:make[3]: *** [drivers/scsi/aic7xxx/aicasm/aicasm] Error 2
rand70.log:make[2]: *** [drivers/scsi/aic7xxx] Error 2
rand70.log:make[1]: *** [drivers/scsi] Error 2
--
rand70.log-  LD      drivers/usb/media/pwc/built-in.o
rand70.log-  LD      drivers/usb/media/built-in.o
rand70.log-  LD      drivers/usb/built-in.o
rand70.log:make: *** [drivers] Error 2
--
rand71.log-: undefined reference to `fg_console'
rand71.log-drivers/built-in.o(.text+0x76b5c): In function `device_suspend':
rand71.log-: undefined reference to `vc_cons'
rand71.log:make: *** [.tmp_vmlinux1] Error 1
--
rand72.log-make[2]: *** No rule to make target `/etc/sound/pndsperm.bin', needed by `sound/oss/pndsperm.c'.  Stop.
rand72.log-make[2]: *** Waiting for unfinished jobs....
rand72.log-  CC [M]  drivers/net/skfp/ess.o
rand72.log:make[1]: *** [sound/oss] Error 2
rand72.log:make: *** [sound] Error 2
--
rand73.log-include/linux/usb.h:643: undefined reference to `usb_register_driver'
rand73.log-drivers/built-in.o(.text+0x1143b9): In function `cpia2_usb_cleanup':
rand73.log-drivers/media/video/cpia2/cpia2_usb.c:907: undefined reference to `usb_deregister'
rand73.log:make: *** [vmlinux] Error 1
--
rand74.log-: undefined reference to `uevent_helper'
rand74.log-lib/lib.a(kobject_uevent.o)(.text+0x346): In function `kobject_uevent':
rand74.log-: undefined reference to `uevent_helper'
rand74.log:make: *** [vmlinux] Error 1
--
rand75.log-aicasm_macro_gram.y:162: error: conflicting types for 'mmerror'
rand75.log-aicasm_macro_gram.tab.c:1352: error: previous implicit declaration of 'mmerror' was here
rand75.log-  CC [M]  drivers/scsi/aacraid/rx.o
rand75.log:make[4]: *** [aicasm] Error 1
rand75.log:make[3]: *** [drivers/scsi/aic7xxx/aicasm/aicasm] Error 2
rand75.log:make[2]: *** [drivers/scsi/aic7xxx] Error 2
--
rand75.log-  LD      drivers/serial/built-in.o
rand75.log-  CC      drivers/spi/spi_bitbang.o
rand75.log-  LD [M]  drivers/scsi/aacraid/aacraid.o
rand75.log:make[1]: *** [drivers/scsi] Error 2
rand75.log-make[1]: *** Waiting for unfinished jobs....
rand75.log-  LD      drivers/spi/built-in.o
rand75.log:make: *** [drivers] Error 2
--
rand77.log-: undefined reference to `scsi_remove_host'
rand77.log-drivers/built-in.o(.text+0x432f7): In function `cciss_unregister_scsi':
rand77.log-: undefined reference to `scsi_host_put'
rand77.log:make: *** [.tmp_vmlinux1] Error 1
--
rand78.log-sound/isa/opti9xx/opti92x-ad1848.c:2091: error: for each function it appears in.)
rand78.log-sound/isa/opti9xx/opti92x-ad1848.c: In function `alsa_card_opti9xx_exit':
rand78.log-sound/isa/opti9xx/opti92x-ad1848.c:2118: error: `opti9xx_pnpc_driver' undeclared (first use in this function)
rand78.log:make[3]: *** [sound/isa/opti9xx/opti93x.o] Error 1
rand78.log:make[2]: *** [sound/isa/opti9xx] Error 2
rand78.log:make[1]: *** [sound/isa] Error 2
rand78.log:make: *** [sound] Error 2
--
rand79.log-kernel/kprobes.c:147: undefined reference to `module_free'
rand79.log-mm/built-in.o(.text+0x1650e): In function `online_pages':
rand79.log-mm/memory_hotplug.c:129: undefined reference to `online_page'
rand79.log:make: *** [.tmp_vmlinux1] Error 1
--
rand8.log-aicasm_gram.tab.c:3161: error: previous implicit declaration of 'yyerror' was here
rand8.log-aicasm_macro_gram.y:162: error: conflicting types for 'mmerror'
rand8.log-aicasm_macro_gram.tab.c:1352: error: previous implicit declaration of 'mmerror' was here
rand8.log:make[4]: *** [aicasm] Error 1
rand8.log:make[3]: *** [drivers/scsi/aic7xxx/aicasm/aicasm] Error 2
rand8.log:make[2]: *** [drivers/scsi/aic7xxx] Error 2
--
rand8.log-  CC [M]  drivers/usb/net/kaweth.o
rand8.log-  LD [M]  drivers/scsi/lpfc/lpfc.o
rand8.log-  CC [M]  drivers/usb/misc/idmouse.o
rand8.log:make[1]: *** [drivers/scsi] Error 2
--
rand8.log-  LD [M]  drivers/usb/storage/usb-storage.o
rand8.log-  LD [M]  drivers/usb/misc/sisusbvga/sisusbvga.o
rand8.log-  LD      drivers/usb/built-in.o
rand8.log:make: *** [drivers] Error 2
--
rand80.log-drivers/acpi/osl.c:249: error: `AmlCode' undeclared (first use in this function)
rand80.log-drivers/acpi/osl.c:249: error: (Each undeclared identifier is reported only once
rand80.log-drivers/acpi/osl.c:249: error: for each function it appears in.)
rand80.log:make[2]: *** [drivers/acpi/osl.o] Error 1
rand80.log:make[1]: *** [drivers/acpi] Error 2
rand80.log:make: *** [drivers] Error 2
--
rand81.log-: undefined reference to `voyager_status'
rand81.log-arch/i386/mach-voyager/built-in.o(.text+0x408): In function `thread':
rand81.log-: undefined reference to `voyager_status'
rand81.log:make: *** [.tmp_vmlinux1] Error 1
--
rand82.log-make[2]: *** Waiting for unfinished jobs....
rand82.log-  CC      drivers/char/agp/nvidia-agp.o
rand82.log-  CC      fs/cifs/file.o
rand82.log:make[1]: *** [sound/oss] Error 2
rand82.log:make: *** [sound] Error 2
--
rand83.log-sound/isa/opti9xx/opti92x-ad1848.c:2091: error: for each function it appears in.)
rand83.log-sound/isa/opti9xx/opti92x-ad1848.c: In function `alsa_card_opti9xx_exit':
rand83.log-sound/isa/opti9xx/opti92x-ad1848.c:2118: error: `opti9xx_pnpc_driver' undeclared (first use in this function)
rand83.log:make[3]: *** [sound/isa/opti9xx/opti92x-ad1848.o] Error 1
rand83.log:make[2]: *** [sound/isa/opti9xx] Error 2
rand83.log:make[1]: *** [sound/isa] Error 2
rand83.log:make: *** [sound] Error 2
--
rand84.log-drivers/built-in.o(.text+0x10b051): more undefined references to `xquad_portio' follow
rand84.log-arch/i386/oprofile/built-in.o(.text+0x353): In function `alloc_cpu_buffers':
rand84.log-: undefined reference to `cpu_2_node'
rand84.log:make: *** [.tmp_vmlinux1] Error 1
--
rand85.log-: undefined reference to `register_wan_device'
rand85.log-drivers/built-in.o(.exit.text+0x62a): In function `cycx_exit':
rand85.log-: undefined reference to `unregister_wan_device'
rand85.log:make: *** [.tmp_vmlinux1] Error 1
--
rand87.log-: undefined reference to `fg_console'
rand87.log-drivers/built-in.o(.text+0x6373f): In function `device_suspend':
rand87.log-: undefined reference to `vc_cons'
rand87.log:make: *** [vmlinux] Error 1
--
rand88.log-: undefined reference to `quad_local_to_mp_bus_id'
rand88.log-arch/i386/pci/built-in.o(.init.text+0x806): In function `pci_numa_init':
rand88.log-: undefined reference to `quad_local_to_mp_bus_id'
rand88.log:make: *** [.tmp_vmlinux1] Error 1
--
rand89.log-: undefined reference to `framebuffer_release'
rand89.log-drivers/built-in.o(.init.text+0x1238): In function `gxfb_init':
rand89.log-: undefined reference to `fb_get_options'
rand89.log:make: *** [.tmp_vmlinux1] Error 1
--
rand9.log-kernel/kprobes.c:109: undefined reference to `module_alloc'
rand9.log-kernel/built-in.o(.kprobes.text+0x1a6): In function `free_insn_slot':
rand9.log-kernel/kprobes.c:147: undefined reference to `module_free'
rand9.log:make: *** [.tmp_vmlinux1] Error 1
--
rand90.log-drivers/built-in.o(.text+0x50b0f): In function `device_suspend':
rand90.log-drivers/base/power/suspend.c:94: undefined reference to `fg_console'
rand90.log-drivers/built-in.o(.text+0x50b1a):drivers/base/power/suspend.c:94: undefined reference to `vc_cons'
rand90.log:make: *** [.tmp_vmlinux1] Error 1
--
rand91.log-: undefined reference to `fg_console'
rand91.log-drivers/built-in.o(.text+0x371fb): In function `device_suspend':
rand91.log-: undefined reference to `vc_cons'
rand91.log:make: *** [.tmp_vmlinux1] Error 1
--
rand92.log-lib/lib.a(kobject_uevent.o)(.text+0x262):lib/kobject_uevent.c:185: undefined reference to `uevent_helper'
rand92.log-lib/lib.a(kobject_uevent.o)(.text+0x27d): In function `kobject_uevent':
rand92.log-include/linux/kmod.h:46: undefined reference to `uevent_helper'
rand92.log:make: *** [.tmp_vmlinux1] Error 1
--
rand93.log-  CC [M]  net/bridge/br_sysfs_br.o
rand93.log-aicasm_macro_gram.y:162: error: conflicting types for 'mmerror'
rand93.log-aicasm_macro_gram.tab.c:1352: error: previous implicit declaration of 'mmerror' was here
rand93.log:make[4]: *** [aicasm] Error 1
rand93.log:make[3]: *** [drivers/scsi/aic7xxx/aicasm/aicasm] Error 2
rand93.log:make[2]: *** [drivers/scsi/aic7xxx] Error 2
rand93.log:make[1]: *** [drivers/scsi] Error 2
rand93.log:make: *** [drivers] Error 2
--
rand94.log-sound/isa/opti9xx/opti92x-ad1848.c:2091: error: for each function it appears in.)
rand94.log-sound/isa/opti9xx/opti92x-ad1848.c: In function `alsa_card_opti9xx_exit':
rand94.log-sound/isa/opti9xx/opti92x-ad1848.c:2118: error: `opti9xx_pnpc_driver' undeclared (first use in this function)
rand94.log:make[3]: *** [sound/isa/opti9xx/opti92x-ad1848.o] Error 1
rand94.log:make[2]: *** [sound/isa/opti9xx] Error 2
rand94.log:make[1]: *** [sound/isa] Error 2
rand94.log:make: *** [sound] Error 2
--
rand94.log-drivers/mtd/maps/nettel.c:418: error: (Each undeclared identifier is reported only once
rand94.log-drivers/mtd/maps/nettel.c:418: error: for each function it appears in.)
rand94.log-drivers/mtd/maps/nettel.c:418: warning: implicit declaration of function `MKDEV'
rand94.log:make[3]: *** [drivers/mtd/maps/nettel.o] Error 1
rand94.log:make[2]: *** [drivers/mtd/maps] Error 2
rand94.log:make[1]: *** [drivers/mtd] Error 2
--
rand94.log-  LD [M]  drivers/media/video/msp3400.o
rand94.log-  LD      drivers/media/video/built-in.o
rand94.log-  LD      drivers/media/built-in.o
rand94.log:make: *** [drivers] Error 2
--
rand95.log-  CC      drivers/usb/net/cdc_subset.o
rand95.log-  CC      drivers/video/matrox/matroxfb_g450.o
rand95.log-drivers/usb/net/cdc_subset.c:213:2: #error You need to configure some hardware for this driver
rand95.log:make[3]: *** [drivers/usb/net/cdc_subset.o] Error 1
rand95.log:make[2]: *** [drivers/usb/net] Error 2
rand95.log:make[1]: *** [drivers/usb] Error 2
--
rand95.log-  LD      drivers/scsi/sd_mod.o
rand95.log-  LD      drivers/scsi/scsi_mod.o
rand95.log-  LD      drivers/scsi/built-in.o
rand95.log:make: *** [drivers] Error 2

