Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271875AbRHUWrU>; Tue, 21 Aug 2001 18:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271884AbRHUWrB>; Tue, 21 Aug 2001 18:47:01 -0400
Received: from hypatia.unh.edu ([132.177.137.23]:2571 "EHLO hypatia.unh.edu")
	by vger.kernel.org with ESMTP id <S271883AbRHUWqx>;
	Tue, 21 Aug 2001 18:46:53 -0400
Message-ID: <3B82E4E7.5090904@langhorst.com>
Date: Tue, 21 Aug 2001 18:47:03 -0400
From: "Bradley W. Langhorst" <brad@langhorst.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-xfs-1.0.1 i686; en-US; rv:0.9.1) Gecko/20010620
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mtrr: base(0xf8000000) is not aligned on a size(0x180000) boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this message on boot with kernel 2.4.9 on a Dell Optiplex GX110 
 running redhat 7.0 with X upgraded to 4.0.3-5 with rpms from rh 7.1
(i810 chipset)  This occurs during X startup.

Aug 21 16:47:31 bitc kernel: mtrr: base(0xf8000000) is not aligned on a 
size(0x180000) boundary
Aug 21 16:47:31 bitc kernel: inter
Aug 21 16:47:31 bitc kernel: [drm:i810_ioremapfree:mappings] *ERROR* 
Excess frees: 147 frees, 2 allocs
Aug 21 16:47:31 bitc kernel: [drm:i810_ioremapfree:mappings] *ERROR* 
Attempt to free NULL pointer
Aug 21 16:47:31 bitc kernel: [drm:i810_ioremapfree:mappings] *ERROR* 
Excess frees: 148 frees, 2 allocs
Aug 21 16:47:31 bitc kernel: [drm:i810_ioremapfree:mappings] *ERROR* 
Attempt to free NULL pointer
...
Aug 21 16:47:31 bitc kernel: [drm:i810_ioremapfree:mappings] *ERROR* 
Attempt to free NULL pointer
Aug 21 16:47:31 bitc kernel: [drm:i810_ioremapfree:mappings] *ERROR* 
Excess frees: 256 frees, 2 allocs
Aug 21 16:47:31 bitc kernel: [drm:i810_dma_initialize] *ERROR* can not 
find mmio map!
Aug 21 16:47:31 bitc kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000008
Aug 21 16:47:31 bitc kernel:  printing eip:
Aug 21 16:47:31 bitc kernel: c01be813
Aug 21 16:47:31 bitc kernel: *pde = 00000000
Aug 21 16:47:31 bitc kernel: Oops: 0000
Aug 21 16:47:31 bitc kernel: CPU:    0
Aug 21 16:47:31 bitc kernel: EIP:    0010:[i810_irq_install+227/416]
Aug 21 16:47:31 bitc kernel: EFLAGS: 00013246
Aug 21 16:47:31 bitc kernel: eax: 00000000   ebx: c16a6800   ecx: 
00000000   edx: 00000000
Aug 21 16:47:31 bitc kernel: esi: c16a6820   edi: c16a6800   ebp: 
00000009   esp: d5cc1f48
Aug 21 16:47:31 bitc kernel: ds: 0018   es: 0018   ss: 0018
Aug 21 16:47:31 bitc kernel: Process X (pid: 847, stackpage=d5cc1000)
Aug 21 16:47:31 bitc kernel: Stack: d5cc1f60 bffffb88 c01bea0e c16a6800 
00000009 c16a6800 00000002 00000009
Aug 21 16:47:31 bitc kernel:        c16a6800 d5cd8980 bffffb80 40086414 
c01bf674 d519a9a0 d5cd8980 40086414
Aug 21 16:47:31 bitc kernel:        bffffb80 bffffb80 d5cd8980 40086414 
ffffffe7 c013c2b7 d519a9a0 d5cd8980
Aug 21 16:47:31 bitc kernel: Call Trace: [i810_control+142/176] 
[i810_ioctl+228/240] [sys_ioctl+375/400] [system_call+51/56]
Aug 21 16:47:31 bitc kernel:
Aug 21 16:47:31 bitc kernel: Code: 8b 41 08 8b 50 10 0f b7 82 98 20 00 
00 25 00 60 00 00 66 89

cat /proc/meminfo says       
total:    used:    free:  shared: buffers:  cached:
Mem:  392192000 74403840 317788160        0  2420736 36728832
Swap: 164495360        0 164495360
MemTotal:       383000 kB
MemFree:        310340 kB
MemShared:           0 kB
Buffers:          2364 kB
Cached:          35868 kB
SwapCached:          0 kB
Active:           7868 kB
Inact_dirty:     30364 kB
Inact_clean:         0 kB
Inact_target:        0 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       383000 kB
LowFree:        310340 kB
SwapTotal:      160640 kB
SwapFree:       160640 kB

here is the device section from XF86Config-4

Section "Device"
    Identifier "Intel Corporation|82810E CGC [Chipset Gr"
    Driver "i810"
    BoardName "Unknown"
    VideoRam 16384
EndSection

my search for answers using mtrr 2.4 i810  turns up nothing of interest 
so maybe this is a new problem?


please advise

thanks!

brad

