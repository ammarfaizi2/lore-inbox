Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWCQHGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWCQHGK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 02:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbWCQHGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 02:06:10 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:27807 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751353AbWCQHGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 02:06:07 -0500
Date: Fri, 17 Mar 2006 00:49:51 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: emist emist <emistz@gmail.com>
Cc: linux-kernel@vger.kernel.org, prasanna@in.ibm.com
Subject: Re: Kernel Oops-jprobe
Message-ID: <20060316191951.GA2077@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <347f31c90603122207y2017344eh2ddd0272a4f9f0fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <347f31c90603122207y2017344eh2ddd0272a4f9f0fe@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 01:07:23AM -0500, emist emist wrote:
> Greetings,
> 
> The following oops occurs when probing the sys_open function.
> Following is the oops and a module with which the error can be
> replicated.

I tried to recreate on 4-way i386 box, but could not 
recreate it. 
Could you please give me the config file you used?

Thanks
prasanna

> 
> [17192145.756000] kobject sysensor: registering. parent: <NULL>, set: module
> [17192145.756000] kobject_hotplug
> [17192145.756000] fill_kobj_path: path = '/module/sysensor'
> [17192145.756000] kobject_hotplug: /sbin/udevsend module seq=1024
> HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add
> DEVPATH=/module/sysensor SUBSYSTEM=module[17192146.124000] Unable to
> handle kernel paging request at virtual address 080c9566
> [17192146.124000]  printing eip:
> [17192146.124000] c01c61ae
> [17192146.124000] *pde = 0e124067
> [17192146.124000] *pte = 00000000
> [17192146.124000] Oops: 0000 [#1]
> [17192146.124000] PREEMPT
> [17192146.124000] Modules linked in: sysensor ppp_deflate zlib_deflate
> bsd_comp ppp_async crc_ccitt ppp_generic slhc ipv6 acpi_cpufreq
> speedstep_lib cpufreq_powersave cpufreq_userspace serial_cs
> cpufreq_ondemand i915 pcmcia drm video battery container fan button
> thermal processor ac ohci1394 yenta_socket rsrc_nonstatic pcmcia_core
> ipw2200 ieee80211 ieee80211_crypt firmware_class b44 mii snd_intel8x0
> snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm
> snd_timer snd soundcore snd_page_alloc i2c_i801 i2c_core generic piix
> shpchp pci_hotplug ehci_hcd uhci_hcd usbcore intel_agp agpgart rtc
> joydev md_mod dm_mod sr_mod sbp2 scsi_mod ieee1394 psmouse mousedev
> parport_pc lp parport unix
> [17192146.124000] CPU:    0
> [17192146.124000] EIP:    0060:[<c01c61ae>]    Not tainted VLI
> [17192146.124000] EFLAGS: 00210097   (2.6.15.4)
> [17192146.124000] EIP is at vsnprintf+0x235/0x3f4
> [17192146.124000] eax: 080c9566   ebx: c03cf1fa   ecx: 080c9566   edx: fffffffe
> [17192146.124000] esi: c65fbfb8   edi: ffffffff   ebp: ffffffff   esp: c65fbef4
> [17192146.124000] ds: 007b   es: 007b   ss: 0068
> [17192146.124000] Process sh (pid: 25185, threadinfo=c65fa000 task=d33c4a90)
> [17192146.124000] Stack: 00000000 c03cf5df 0000000a 00000400 00008802
> c03cf1e0 c65fa000 c01c6384
> [17192146.124000]        c03cf1e0 00000400 e05612e5 c65fbfb0 080c9566
> c0116c7d c03cf1e0 00000400
> [17192146.124000]        e05612cd c65fbfb0 c65fbf84 00000000 b7eaa038
> 00200046 c03c3acc 00000002
> [17192146.124000] Call Trace:
> [17192146.124000]  [<c01c6384>] vscnprintf+0x17/0x24
> [17192146.124000]  [<c0116c7d>] vprintk+0x62/0x22a
> [17192146.124000]  [<c02a8682>] int3+0x1e/0x24
> [17192146.124000]  [<c0116c18>] printk+0xe/0x11
> [17192146.124000]  [<e05610ac>] jsys_open+0x1d/0x28 [sysensor]
> [17192146.124000]  [<c0102cef>] sysenter_past_esp+0x54/0x75
> [17192146.124000] Code: 77 03 c6 03 20 4d 43 85 ed 7f f1 e9 9e 01 00
> 00 89 f0 89 fa 83 c6 04 8b 08 b8 19 14 2d c0 81 f9 ff 0f 00 00 0f 46
> c8 89 c8 eb 06 <80> 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 f6 04 24 10
> 89 c7 75
> [17192146.124000]  <3>Debug: sleeping function called from invalid
> context at include/linux/rwsem.h:43
> [17192146.124000] in_atomic():1, irqs_disabled():0
> [17192146.124000]  [<c0114258>] __might_sleep+0x90/0x98
> [17192146.124000]  [<c0117396>] profile_task_exit+0x12/0x41
> [17192146.124000]  [<c01188e3>] do_exit+0x16/0x39a
> [17192146.124000]  [<c0103dda>] do_divide_error+0x0/0x86
> [17192146.124000]  [<c02a94a2>] do_page_fault+0x3b4/0x561
> [17192146.124000]  [<c02a90ee>] do_page_fault+0x0/0x561
> [17192146.124000]  [<c01037df>] error_code+0x4f/0x54
> [17192146.124000]  [<c01c61ae>] vsnprintf+0x235/0x3f4
> [17192146.124000]  [<c01c6384>] vscnprintf+0x17/0x24
> [17192146.124000]  [<c0116c7d>] vprintk+0x62/0x22a
> [17192146.124000]  [<c02a8682>] int3+0x1e/0x24
> [17192146.124000]  [<c0116c18>] printk+0xe/0x11
> [17192146.124000]  [<e05610ac>] jsys_open+0x1d/0x28 [sysensor]
> [17192146.124000]  [<c0102cef>] sysenter_past_esp+0x54/0x75
> [17192146.124000] note: sh[25185] exited with preempt_count 3
> 
> Code to reproduce the error:
> 
> #include <linux/module.h>
> #include <linux/kprobes.h>
> #include <linux/kallsyms.h>
> 
> asmlinkage long jsys_open(const char *filename, int flags, int mode);
> static struct jprobe jopen = {
>         .entry = (kprobe_opcode_t *)jsys_open
> };
> static int register_jumpprobe(struct jprobe *probe, char *name)
> {
>         int ret;
>         probe->kp.addr = (kprobe_opcode_t *) kallsyms_lookup_name(name);
>         if(!probe->kp.addr)
>         {
>                 printk("Couldn't find %s to probe\n", name);
>                 return -1;
>         }
>         if((ret = register_jprobe(probe)) < 0)
>         {
>                 printk("Registration failed, returned %d\n", ret);
>                 return -1;
>         }
>         return 0;
> }
> asmlinkage long jsys_open(const char * filename, int flags, int mode)
> {
>         jprobe_return();
>         return 0;
> }
> int init_module(void)
> {
>         register_jumpprobe(&jopen, "sys_open");
>         return 0;
> }
> 
> 
> void cleanup_module(void)
> {
>         unregister_jprobe(&jopen);
> }
> MODULE_LICENSE("GPL");
> 
> Have a good one,
> 
> Igor H.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
