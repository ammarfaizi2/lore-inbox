Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVIQPc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVIQPc2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 11:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVIQPc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 11:32:28 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:19426 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1751118AbVIQPc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 11:32:27 -0400
Message-ID: <432C344D.1030604@linuxtv.org>
Date: Sat, 17 Sep 2005 19:20:45 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: free free irq and Oops on cat /proc/interrupts (2)
Content-Type: multipart/mixed;
 boundary="------------040700000807000103090809"
X-PopBeforeSMTPSenders: manu@kromtek.com
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040700000807000103090809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Can somebody give me a pointer as to what i am possibly doing wrong.

The module loads fine..
The module unloads fine.. But i get a "free free IRQ" on free_irq()..
I do a cat /proc/interrupts .. I get an Oops.. Attached dmesg [1]
I did an Oops trace down to vsprintf.c, using make EXTRA_CFLAGS="-g 
-Wa,-a,-ad" lib/vsprintf.o > lib/vsprintf.asm, but still couldn't find 
what the real bug is.


Thanks,
Manu


[1] dmesg_cat_int_kern_debug.txt


--------------040700000807000103090809
Content-Type: text/plain;
 name="dmesg_cat_int_kern_debug.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_cat_int_kern_debug.txt"

DEVPATH=/bus/pci/drivers/3c59x SUBSYSTEM=drivers
[   48.016174] 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
[   48.016183] 0000:02:0a.0: 3Com PCI 3c905C Tornado at 0xdc00. Vers LK1.1.19
[   48.037817] kobject eth0: registering. parent: net, set: class_obj
[   48.037852] kobject_hotplug
[   48.037858] fill_kobj_path: path = '/class/net/eth0'
[   48.037863] fill_kobj_path: path = '/devices/pci0000:00/0000:00:1e.0/0000:02:0a.0'
[   48.037869] kobject_hotplug: /bin/true net seq=767 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/net/eth0 SUBSYSTEM=net
[   52.929876] kobject_hotplug
[   52.929885] fill_kobj_path: path = '/class/vc/vcs1'
[   52.929890] kobject_hotplug: /sbin/hotplug vc seq=768 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs1 SUBSYSTEM=vc
[   52.930806] kobject vcs1: cleaning up
[   52.930814] kobject_hotplug
[   52.930820] fill_kobj_path: path = '/class/vc/vcsa1'
[   52.930825] kobject_hotplug: /sbin/hotplug vc seq=769 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa1 SUBSYSTEM=vc
[   52.931633] kobject vcsa1: cleaning up
[   52.960992] kobject vcs1: registering. parent: vc, set: class_obj
[   52.961012] kobject_hotplug
[   52.961019] fill_kobj_path: path = '/class/vc/vcs1'
[   52.961024] kobject_hotplug: /sbin/hotplug vc seq=770 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs1 SUBSYSTEM=vc
[   52.977237] kobject vcsa1: registering. parent: vc, set: class_obj
[   52.977254] kobject_hotplug
[   52.977261] fill_kobj_path: path = '/class/vc/vcsa1'
[   52.977266] kobject_hotplug: /sbin/hotplug vc seq=771 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa1 SUBSYSTEM=vc
[   53.027411] kobject vcs3: registering. parent: vc, set: class_obj
[   53.027438] kobject_hotplug
[   53.027445] fill_kobj_path: path = '/class/vc/vcs3'
[   53.027450] kobject_hotplug: /sbin/hotplug vc seq=772 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs3 SUBSYSTEM=vc
[   53.042249] kobject vcsa3: registering. parent: vc, set: class_obj
[   53.042268] kobject_hotplug
[   53.042274] fill_kobj_path: path = '/class/vc/vcsa3'
[   53.042280] kobject_hotplug: /sbin/hotplug vc seq=773 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa3 SUBSYSTEM=vc
[   53.057455] kobject_hotplug
[   53.057464] fill_kobj_path: path = '/class/vc/vcs3'
[   53.057469] kobject_hotplug: /sbin/hotplug vc seq=774 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs3 SUBSYSTEM=vc
[   53.058354] kobject vcs3: cleaning up
[   53.058362] kobject_hotplug
[   53.058368] fill_kobj_path: path = '/class/vc/vcsa3'
[   53.058372] kobject_hotplug: /sbin/hotplug vc seq=775 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa3 SUBSYSTEM=vc
[   53.059174] kobject vcsa3: cleaning up
[   53.086977] kobject vcs3: registering. parent: vc, set: class_obj
[   53.086995] kobject_hotplug
[   53.087002] fill_kobj_path: path = '/class/vc/vcs3'
[   53.087007] kobject_hotplug: /sbin/hotplug vc seq=776 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs3 SUBSYSTEM=vc
[   53.102045] kobject vcsa3: registering. parent: vc, set: class_obj
[   53.102063] kobject_hotplug
[   53.102070] fill_kobj_path: path = '/class/vc/vcsa3'
[   53.102075] kobject_hotplug: /sbin/hotplug vc seq=777 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa3 SUBSYSTEM=vc
[   53.119860] kobject vcs2: registering. parent: vc, set: class_obj
[   53.119876] kobject_hotplug
[   53.119883] fill_kobj_path: path = '/class/vc/vcs2'
[   53.119888] kobject_hotplug: /sbin/hotplug vc seq=778 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs2 SUBSYSTEM=vc
[   53.134609] kobject vcsa2: registering. parent: vc, set: class_obj
[   53.134626] kobject_hotplug
[   53.134633] fill_kobj_path: path = '/class/vc/vcsa2'
[   53.134638] kobject_hotplug: /sbin/hotplug vc seq=779 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa2 SUBSYSTEM=vc
[   53.149755] kobject_hotplug
[   53.149764] fill_kobj_path: path = '/class/vc/vcs2'
[   53.149769] kobject_hotplug: /sbin/hotplug vc seq=780 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs2 SUBSYSTEM=vc
[   53.150595] kobject vcs2: cleaning up
[   53.150603] kobject_hotplug
[   53.150609] fill_kobj_path: path = '/class/vc/vcsa2'
[   53.150614] kobject_hotplug: /sbin/hotplug vc seq=781 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa2 SUBSYSTEM=vc
[   53.151406] kobject vcsa2: cleaning up
[   53.179977] kobject vcs2: registering. parent: vc, set: class_obj
[   53.179994] kobject_hotplug
[   53.180001] fill_kobj_path: path = '/class/vc/vcs2'
[   53.180006] kobject_hotplug: /sbin/hotplug vc seq=782 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs2 SUBSYSTEM=vc
[   53.194865] kobject vcsa2: registering. parent: vc, set: class_obj
[   53.194882] kobject_hotplug
[   53.194889] fill_kobj_path: path = '/class/vc/vcsa2'
[   53.194894] kobject_hotplug: /sbin/hotplug vc seq=783 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa2 SUBSYSTEM=vc
[   53.211319] kobject vcs4: registering. parent: vc, set: class_obj
[   53.211336] kobject_hotplug
[   53.211342] fill_kobj_path: path = '/class/vc/vcs4'
[   53.211348] kobject_hotplug: /sbin/hotplug vc seq=784 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs4 SUBSYSTEM=vc
[   53.228170] kobject vcs5: registering. parent: vc, set: class_obj
[   53.228187] kobject_hotplug
[   53.228195] fill_kobj_path: path = '/class/vc/vcs5'
[   53.228200] kobject_hotplug: /sbin/hotplug vc seq=785 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs5 SUBSYSTEM=vc
[   53.244342] kobject vcs6: registering. parent: vc, set: class_obj
[   53.244359] kobject_hotplug
[   53.244366] fill_kobj_path: path = '/class/vc/vcs6'
[   53.244371] kobject_hotplug: /sbin/hotplug vc seq=786 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs6 SUBSYSTEM=vc
[   53.259735] kobject vcsa4: registering. parent: vc, set: class_obj
[   53.259752] kobject_hotplug
[   53.259759] fill_kobj_path: path = '/class/vc/vcsa4'
[   53.259764] kobject_hotplug: /sbin/hotplug vc seq=787 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa4 SUBSYSTEM=vc
[   53.274530] kobject_hotplug
[   53.274538] fill_kobj_path: path = '/class/vc/vcs4'
[   53.274544] kobject_hotplug: /sbin/hotplug vc seq=788 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs4 SUBSYSTEM=vc
[   53.275366] kobject vcs4: cleaning up
[   53.275373] kobject_hotplug
[   53.275379] fill_kobj_path: path = '/class/vc/vcsa4'
[   53.275384] kobject_hotplug: /sbin/hotplug vc seq=789 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa4 SUBSYSTEM=vc
[   53.276169] kobject vcsa4: cleaning up
[   53.304566] kobject vcs4: registering. parent: vc, set: class_obj
[   53.304583] kobject_hotplug
[   53.304590] fill_kobj_path: path = '/class/vc/vcs4'
[   53.304595] kobject_hotplug: /sbin/hotplug vc seq=790 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs4 SUBSYSTEM=vc
[   53.319918] kobject vcsa4: registering. parent: vc, set: class_obj
[   53.319936] kobject_hotplug
[   53.319943] fill_kobj_path: path = '/class/vc/vcsa4'
[   53.319948] kobject_hotplug: /sbin/hotplug vc seq=791 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa4 SUBSYSTEM=vc
[   53.335003] kobject vcsa5: registering. parent: vc, set: class_obj
[   53.335021] kobject_hotplug
[   53.335028] fill_kobj_path: path = '/class/vc/vcsa5'
[   53.335033] kobject_hotplug: /sbin/hotplug vc seq=792 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa5 SUBSYSTEM=vc
[   53.350739] kobject_hotplug
[   53.350748] fill_kobj_path: path = '/class/vc/vcs5'
[   53.350753] kobject_hotplug: /sbin/hotplug vc seq=793 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs5 SUBSYSTEM=vc
[   53.351581] kobject vcs5: cleaning up
[   53.351588] kobject_hotplug
[   53.351595] fill_kobj_path: path = '/class/vc/vcsa5'
[   53.351599] kobject_hotplug: /sbin/hotplug vc seq=794 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa5 SUBSYSTEM=vc
[   53.352399] kobject vcsa5: cleaning up
[   53.362783] kobject vcs5: registering. parent: vc, set: class_obj
[   53.362800] kobject_hotplug
[   53.362825] fill_kobj_path: path = '/class/vc/vcs5'
[   53.362830] kobject_hotplug: /sbin/hotplug vc seq=795 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs5 SUBSYSTEM=vc
[   53.365582] kobject vcsa5: registering. parent: vc, set: class_obj
[   53.365604] kobject_hotplug
[   53.365610] fill_kobj_path: path = '/class/vc/vcsa5'
[   53.365616] kobject_hotplug: /sbin/hotplug vc seq=796 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa5 SUBSYSTEM=vc
[   53.367241] kobject vcsa6: registering. parent: vc, set: class_obj
[   53.367264] kobject_hotplug
[   53.367270] fill_kobj_path: path = '/class/vc/vcsa6'
[   53.367275] kobject_hotplug: /sbin/hotplug vc seq=797 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa6 SUBSYSTEM=vc
[   53.382643] kobject_hotplug
[   53.382651] fill_kobj_path: path = '/class/vc/vcs6'
[   53.382656] kobject_hotplug: /sbin/hotplug vc seq=798 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs6 SUBSYSTEM=vc
[   53.383493] kobject vcs6: cleaning up
[   53.383501] kobject_hotplug
[   53.383507] fill_kobj_path: path = '/class/vc/vcsa6'
[   53.383512] kobject_hotplug: /sbin/hotplug vc seq=799 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa6 SUBSYSTEM=vc
[   53.384316] kobject vcsa6: cleaning up
[   53.412410] kobject vcs6: registering. parent: vc, set: class_obj
[   53.412428] kobject_hotplug
[   53.412435] fill_kobj_path: path = '/class/vc/vcs6'
[   53.412440] kobject_hotplug: /sbin/hotplug vc seq=800 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs6 SUBSYSTEM=vc
[   53.427499] kobject vcsa6: registering. parent: vc, set: class_obj
[   53.427516] kobject_hotplug
[   53.427523] fill_kobj_path: path = '/class/vc/vcsa6'
[   53.427528] kobject_hotplug: /sbin/hotplug vc seq=801 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa6 SUBSYSTEM=vc
[   66.053903] kobject mb86a15: registering. parent: <NULL>, set: module
[   66.053928] kobject_hotplug
[   66.053938] fill_kobj_path: path = '/module/mb86a15'
[   66.053942] kobject_hotplug: /sbin/hotplug module seq=802 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/module/mb86a15 SUBSYSTEM=module
[   66.080182] kobject i2c_core: registering. parent: <NULL>, set: module
[   66.080210] kobject_hotplug
[   66.080218] fill_kobj_path: path = '/module/i2c_core'
[   66.080222] kobject_hotplug: /sbin/hotplug module seq=803 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/module/i2c_core SUBSYSTEM=module
[   66.095640] subsystem i2c: registering
[   66.095645] kobject i2c: registering. parent: <NULL>, set: bus
[   66.095664] kobject devices: registering. parent: i2c, set: <NULL>
[   66.095681] kobject drivers: registering. parent: i2c, set: <NULL>
[   66.095699] kobject i2c_adapter: registering. parent: <NULL>, set: drivers
[   66.095716] kobject_hotplug
[   66.095722] fill_kobj_path: path = '/bus/i2c/drivers/i2c_adapter'
[   66.095727] kobject_hotplug: /sbin/hotplug drivers seq=804 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/bus/i2c/drivers/i2c_adapter SUBSYSTEM=drivers
[   66.111371] subsystem i2c-adapter: registering
[   66.111377] kobject i2c-adapter: registering. parent: <NULL>, set: class
[   66.166071] kobject dvb_core: registering. parent: <NULL>, set: module
[   66.166099] kobject_hotplug
[   66.166106] fill_kobj_path: path = '/module/dvb_core'
[   66.166111] kobject_hotplug: /sbin/hotplug module seq=805 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/module/dvb_core SUBSYSTEM=module
[   66.181805] subsystem dvb: registering
[   66.181811] kobject dvb: registering. parent: <NULL>, set: class
[   66.231633] kobject mantis: registering. parent: <NULL>, set: module
[   66.231665] kobject_hotplug
[   66.231672] fill_kobj_path: path = '/module/mantis'
[   66.231677] kobject_hotplug: /sbin/hotplug module seq=806 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/module/mantis SUBSYSTEM=module
[   66.247491] kobject mantis: registering. parent: <NULL>, set: drivers
[   66.247509] kobject_hotplug
[   66.247516] fill_kobj_path: path = '/bus/pci/drivers/mantis'
[   66.247520] kobject_hotplug: /sbin/hotplug drivers seq=807 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/bus/pci/drivers/mantis SUBSYSTEM=drivers
[   66.263094] mantis_pci_probe: Got a device
[   66.263277] mantis_pci_probe: We got an IRQ
[   85.837263] Trying to free free IRQ23
[   85.837423] kobject mantis: unregistering
[   85.837426] kobject_hotplug
[   85.837437] fill_kobj_path: path = '/bus/pci/drivers/mantis'
[   85.837442] kobject_hotplug: /sbin/hotplug drivers seq=808 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/bus/pci/drivers/mantis SUBSYSTEM=drivers
[   85.853153] kobject mantis: cleaning up
[   85.853541] kobject mantis: unregistering
[   85.853545] kobject_hotplug
[   85.853551] fill_kobj_path: path = '/module/mantis'
[   85.853556] kobject_hotplug: /sbin/hotplug module seq=809 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/module/mantis SUBSYSTEM=module
[   85.869299] kobject mantis: cleaning up
[   91.576833] Unable to handle kernel paging request at virtual address f92b83ea
[   91.577132]  printing eip:
[   91.577242] c0207487
[   91.577332] *pde = 01bc4067
[   91.577446] *pte = 00000000
[   91.577559] Oops: 0000 [#1]
[   91.577672] SMP DEBUG_PAGEALLOC
[   91.577819] Modules linked in: dvb_core i2c_core mb86a15 3c59x piix sd_mod
[   91.578166] CPU:    0
[   91.578167] EIP:    0060:[<c0207487>]    Not tainted VLI
[   91.578168] EFLAGS: 00010097   (2.6.13) 
[   91.578634] EIP is at vsnprintf+0x337/0x4c0
[   91.578807] eax: f92b83ea   ebx: 0000000a   ecx: f92b83ea   edx: fffffffe
[   91.579071] esi: f082e122   edi: 00000000   ebp: f0956ee4   esp: f0956eac
[   91.579341] ds: 007b   es: 007b   ss: 0068
[   91.579506] Process cat (pid: 2337, threadinfo=f0956000 task=f4ca8b00)
[   91.579765] Stack: f0956ef4 f082efff 00000000 00000000 0000000a fffffffd 00000000 00000000 
[   91.580186]        ffffffff ffffffff f082efff f4190de0 f09c385c 00000017 f0956f00 c01804f6 
[   91.580604]        f082e120 00000ee0 c036756e f0956f14 00000008 f0956f28 c0105a04 f4190de0 
[   91.581024] Call Trace:
[   91.581135]  [<c0103e6f>] show_stack+0x7f/0xa0
[   91.581333]  [<c0104020>] show_registers+0x160/0x1d0
[   91.581549]  [<c0104250>] die+0x100/0x180
[   91.581729]  [<c0114ee9>] do_page_fault+0x369/0x6ed
[   91.581950]  [<c0103a93>] error_code+0x4f/0x54
[   91.582152]  [<c01804f6>] seq_printf+0x36/0x60
[   91.582355]  [<c0105a04>] show_interrupts+0x2d4/0x3d0
[   91.582579]  [<c017fff9>] seq_read+0x1c9/0x2c0
[   91.582778]  [<c015ead8>] vfs_read+0xb8/0x190
[   91.582974]  [<c015ee8b>] sys_read+0x4b/0x80
[   91.583169]  [<c0102f23>] sysenter_past_esp+0x54/0x75
[   91.583389] Code: ff c7 45 ec 08 00 00 00 83 cf 01 eb ba 8b 45 14 8b 55 e8 83 45 14 04 8b 08 b8 c5 6b 36 c0 81 f9 ff 0f 00 00 0f 46 c8 89 c8 eb 06 <80> 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75 1d 
[   91.584807]  

--------------040700000807000103090809
Content-Type: text/plain;
 name="mantis_pci.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mantis_pci.c"

#include <asm/io.h>
#include <asm/pgtable.h>
#include <asm/page.h>
#include <linux/kmod.h>
#include <linux/vmalloc.h>
#include <linux/init.h>
#include <linux/device.h>
#include "mantis_common.h"
#include "mantis_dma.h"
#include "mantis_i2c.h"
#include "mantis_eeprom.h"

#include <asm/irq.h>
#include <linux/signal.h>
#include <linux/sched.h>
#include <linux/interrupt.h>

unsigned int verbose = 1;
module_param(verbose, int, 0644);
MODULE_PARM_DESC(verbose, "verbose startup messages, default is 1 (yes)");

#define PCI_VENDOR_ID_MANTIS			0x1822
#define PCI_DEVICE_ID_MANTIS_R11		0x4e35
#define DRIVER_NAME				"mantis"

static struct pci_device_id mantis_pci_table[] = {
	{ PCI_DEVICE(PCI_VENDOR_ID_MANTIS, PCI_DEVICE_ID_MANTIS_R11) },
	{ 0 },
};

MODULE_DEVICE_TABLE(pci, mantis_pci_table);

static irqreturn_t mantis_pci_irq(int irq, void *dev_id, struct pt_regs *regs)
{
	struct mantis_pci *mantis;

	dprintk(verbose, MANTIS_DEBUG, 1, "Mantis PCI IRQ");
	mantis = (struct mantis_pci *) dev_id;
	if (mantis == NULL)
		dprintk(verbose, MANTIS_DEBUG, 1, "Aeio, mantis ISR");

	return IRQ_NONE;	// temporarily
}

static int mantis_i2c_setup(struct mantis_pci *mantis)
{
	u32 config;

//	mmwrite(0x80, MANTIS_DMA_CTL); // MCU i2c read
	config = mmread(MANTIS_DMA_CTL);
	dprintk(verbose, MANTIS_DEBUG, 1, "Mantis Ctl reg=0x%04x", config);

	return 0;
}

static int mantis_reg_dump(struct mantis_pci *mantis)
{
	u32 ctlreg, intstat, intmask, i2cdata;

	ctlreg = mmread(MANTIS_DMA_CTL);
	intstat = mmread(MANTIS_INT_STAT);
	intmask = mmread(MANTIS_INT_MASK);
	i2cdata = mmread(MANTIS_I2C_DATA);
	dprintk(verbose, MANTIS_DEBUG, 1, "CTL_REG=0x%04x, INT_STAT=0x%04x, \
		INT_MASK=0x%04x, I2C_DATA=0x%04x", ctlreg, intstat,		\
		intmask, i2cdata);

	return 0;
}

static int __devinit mantis_pci_probe(struct pci_dev *pdev,
				const struct pci_device_id *mantis_pci_table)
{
	u8 revision, latency;
	struct mantis_pci *mantis;

	mantis = (struct mantis_pci *)
				kmalloc(sizeof (struct mantis_pci), GFP_KERNEL);
	if (mantis == NULL) {
		dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
		return -ENOMEM;
	}
	dprintk(verbose, MANTIS_ERROR, 1, "Got a device");
	if (request_irq(pdev->irq, mantis_pci_irq, SA_SHIRQ | SA_INTERRUPT, 
						DRIVER_NAME, mantis) < 0) {
		dprintk(verbose, MANTIS_ERROR, 1, "Mantis IRQ reg failed");
		goto err;
	}
	dprintk(verbose, MANTIS_DEBUG, 1, "We got an IRQ");
	return 0;

err:
	dprintk(verbose, MANTIS_DEBUG, 1, "<freak out>");
	kfree(mantis);
	return -ENODEV;
}



static void __devexit mantis_pci_remove(struct pci_dev *pdev)
{
	free_irq(pdev->irq, pdev);
}

static struct pci_driver mantis_pci_driver = {
	.name = DRIVER_NAME,
	.id_table = mantis_pci_table,
	.probe = mantis_pci_probe,
	.remove = mantis_pci_remove,
};

static int __devinit mantis_pci_init(void)
{
	return pci_register_driver(&mantis_pci_driver);
}

static void __devexit mantis_pci_exit(void)
{
	pci_unregister_driver(&mantis_pci_driver);
}

module_init(mantis_pci_init);
module_exit(mantis_pci_exit);

MODULE_DESCRIPTION("Mantis PCI DTV bridge driver");
MODULE_AUTHOR("Manu Abraham");
MODULE_LICENSE("GPL");

--------------040700000807000103090809
Content-Type: application/x-bzip;
 name="vsprintf.asm.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="vsprintf.asm.bz2"

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
oIyM9K9db8Y7yb62PrnfT1g867cphu0xma3x1nbjpFJ1bzu4xSPVkqLJ1bFgwZloXLDGbHZl
RIPO/G2tV4OxTZbsz7oF5fNfWhnZmDlW+3bGtcjTu2188HowoCT0IeQJLrpsFu8OGJgzurBD
D2q4dyFYD6gJiOkOpAXBkP6CAAQPMhrfk1NQxhTMGh25LvV870+rvniQmqpC80gEWB+66F0k
YxCE8HtCIeHGwjactpgYdZypM0ooxhfRj2QLOY2zyj7WDIL2uJDwkPvMwbeeZ/E67S/E99Kf
6g9ZTGEFRGDCS2giCCIkiESMZGSQidhRUJEmoIE4wKnzdTPB0Hk3dXZpOHDy9H3raxn/T6Kp
eyIiVHT/s/ir0OfYcWnp9tRSBNQMgwOQP9oUOA/Mn8Z2PwCgOw/o6n71YoiqqpFVUYqqKqKq
qqIwiqqqv+C2KKiCkWKoiKqqqIqqKqqqiqqKiwICqNbIoiKqioiKwVYKqqKqqqqqoqqrISCk
UYqooqirFgjFVVkWCqioqitaoqqqgqqqKrJILGtFRBYqqqqIqqqqqqqKqqqqiqqoqiqooqqr
AIfkVWAL69wIiMJlfzdNCqdgDwIAoQiqAixEVABQFkWQRZEkYRiyCgskFJIIgKsAUk/S14Cn
u3w9v4eX1Yn0/YK/gDQVEhRU+dnQOaIdxY6ePx/Wtrnp0/CsB2sOhsMYcZ11C0RH/Pp3IiIA
iEW6d8uACLqXpaRf2RALtIM9XJASxMMGUVQhISClQkYD+Hx4b958PxueB0RRGUHhEBo/cFv4
Tm4rDj6WwJBwH5ycmZEVBjFiL0txyO7IQCXG/K1FUf57e8gIjR+RAFfx8uz8a5c+mPll3hrA
+6KtQCQiHCcbs7sgbZ3QkqY1kUkFCdJIWK4yVIjCKCwjuiv67UMxs5YFQ7+KTENMnCocoTSd
2CkWQvFk2qqmZQmKqIhisnfpKQhjCHZkmMlZAxlemGAgmMizoidoyV/a9juWTb2pYJouM5GC
ZQP+rZZOAs/tUwQDSwYLjh/r0zyxpQ2vUoaBbv8bpZbWMghHVQl9G9Lf3nF6uUZANALkgKGw
QBKMXhWb+VxGDz3g+U1EbEFipTGZKqhd1ma7At3l0rW6bNSc0FPNWxcOsxiyHUgSFdHdvYeT
Slxhk3e6llkEWcwb07gOAXlzEyaOalvyieCCXNc442BvSrlymBOvHcDd1gzLebO4jsHS0cUb
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
--------------040700000807000103090809
Content-Type: text/plain;
 name="debug.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug.txt"

 337              	.L34:
  92:lib/vsprintf.c **** 			base = 8;
  93:lib/vsprintf.c **** 			cp++;
  94:lib/vsprintf.c **** 			if ((toupper(*cp) == 'X') && isxdigit(cp[1])) {
  95:lib/vsprintf.c **** 				cp++;
  96:lib/vsprintf.c **** 				base = 16;
  97:lib/vsprintf.c **** 			}
  98:lib/vsprintf.c **** 		}
  99:lib/vsprintf.c **** 	} else if (base == 16) {
 100:lib/vsprintf.c **** 		if (cp[0] == '0' && toupper(cp[1]) == 'X')

--------------040700000807000103090809--
