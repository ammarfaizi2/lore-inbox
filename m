Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279261AbRKFNbo>; Tue, 6 Nov 2001 08:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279250AbRKFNbf>; Tue, 6 Nov 2001 08:31:35 -0500
Received: from adsl-216-102-162-162.dsl.snfc21.pacbell.net ([216.102.162.162]:32167
	"EHLO janus") by vger.kernel.org with ESMTP id <S279201AbRKFNbW>;
	Tue, 6 Nov 2001 08:31:22 -0500
Message-ID: <3BE7F362.1090406@gutschke.com>
Date: Tue, 06 Nov 2001 15:27:46 +0100
From: Stephan Gutschke <stephan@gutschke.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops when syncing Sony Clie 760 with USB cradle
In-Reply-To: <E160obZ-0001bO-00@janus> <20011105131014.A4735@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

the output is below, I also added a couple of debug-lines in the 
visor_open()
function. Seems to me like port->read_urb is null and maybe that 
shouldn't be?
Anyways, if I got that all wrong, don't hit me ;-).
I would have like to look a little more around, but I have not really 
any idea of
kernel programming so I have no clue who calls visor_open()
Let me know if I can do anything else.
Oh, and by the way, the crash happens, when I press "Sync" in jpilot, 
before that
everything is fine.

see you later
 Stephan

P.S. sorry i took so long, but i was a little busy here ;-)


> Nov  6 15:15:59 yvette kernel: hub.c: port 1 connection change
> Nov  6 15:15:59 yvette kernel: hub.c: port 1, portstatus 101, change 
> 1, 12 Mb/s
> Nov  6 15:15:59 yvette kernel: hub.c: port 1, portstatus 103, change 
> 0, 12 Mb/s
> Nov  6 15:15:59 yvette kernel: hub.c: USB new device connect on 
> bus1/1, assigned device number 2
> Nov  6 15:15:59 yvette kernel: usb.c: kmalloc IF dbfdcdc0, numif 1
> Nov  6 15:15:59 yvette kernel: usb.c: new device strings: Mfr=1, 
> Product=2, SerialNumber=0
> Nov  6 15:15:59 yvette kernel: usb.c: USB device number 2 default 
> language ID 0x409
> Nov  6 15:15:59 yvette kernel: Manufacturer: Sony Corp.
> Nov  6 15:15:59 yvette kernel: Product: Palm Handheld
> Nov  6 15:15:59 yvette kernel: usbserial.c: Sony Clie 4.0 converter 
> detected
> Nov  6 15:15:59 yvette kernel: visor.c: visor_startup
> Nov  6 15:15:59 yvette kernel: visor.c: visor_startup - Set config to 1
> Nov  6 15:15:59 yvette kernel: visor.c: Sony Clie 4.0: Number of ports: 2
> Nov  6 15:15:59 yvette kernel: visor.c: Sony Clie 4.0: port 1, is for 
> Generic use and is bound to ttyUSB0
> Nov  6 15:15:59 yvette kernel: visor.c: Sony Clie 4.0: port 2, is for 
> HotSync use and is bound to ttyUSB1
> Nov  6 15:15:59 yvette kernel: usb-uhci.c: interrupt, status 2, frame# 984
> Nov  6 15:16:02 yvette kernel: usb_control/bulk_msg: timeout
> Nov  6 15:16:02 yvette kernel: visor.c: visor_startup - error getting 
> first unknown palm command
> Nov  6 15:16:05 yvette kernel: usb_control/bulk_msg: timeout
> Nov  6 15:16:05 yvette kernel: visor.c: visor_startup - error getting 
> second unknown palm command
> Nov  6 15:16:05 yvette kernel: usbserial.c: Sony Clie 4.0 converter 
> now attached to ttyUSB0 (or usb/tts/0 for devfs)
> Nov  6 15:16:05 yvette kernel: usbserial.c: Sony Clie 4.0 converter 
> now attached to ttyUSB1 (or usb/tts/1 for devfs)
> Nov  6 15:16:05 yvette kernel: usb.c: serial driver claimed interface 
> dbfdcdc0
> Nov  6 15:16:05 yvette kernel: usb.c: kusbd: /sbin/hotplug add 2
> Nov  6 15:16:05 yvette kernel: usb.c: kusbd policy returned 0xfffffffe
> Nov  6 15:16:09 yvette kernel: visor.c: visor_open - port 1
> Nov  6 15:16:09 yvette kernel: visor.c: visor_openport->read_urb 
> 00000000             <----- should that be that way?
> Nov  6 15:16:09 yvette kernel: visor.c: visor_openport->serial->dev 
> dda78e00
> Nov  6 15:16:09 yvette kernel: Unable to handle kernel NULL pointer 
> dereference at virtual address 00000024
> Nov  6 15:16:09 yvette kernel:  printing eip:
> Nov  6 15:16:09 yvette kernel: e08a514d
> Nov  6 15:16:09 yvette kernel: *pde = 00000000
> Nov  6 15:16:09 yvette kernel: Oops: 0000
> Nov  6 15:16:09 yvette kernel: CPU:    0
> Nov  6 15:16:09 yvette kernel: EIP:    0010:[<e08a514d>]    Tainted: PF
> Nov  6 15:16:09 yvette kernel: EFLAGS: 00210202
> Nov  6 15:16:09 yvette kernel: eax: 00000000   ebx: db4c3094   ecx: 
> df61a000   edx: 00000001
> Nov  6 15:16:09 yvette kernel: esi: db4c3000   edi: 00000000   ebp: 
> db4c30f0   esp: db4a3eb0
> Nov  6 15:16:09 yvette kernel: ds: 0018   es: 0018   ss: 0018
> Nov  6 15:16:09 yvette kernel: Process jpilot (pid: 533, 
> stackpage=db4a3000)
> Nov  6 15:16:09 yvette kernel: Stack: dce3f000 db7279c0 dedb44a0 
> c180e2e0 e08a0284 db4c3094 db7279c0 00000000
> Nov  6 15:16:09 yvette kernel:        00000000 c018b98b dce3f000 
> db7279c0 00000000 db7279c0 dedb44a0 c180e2e0
> Nov  6 15:16:09 yvette kernel:        4c99880a 08020007 dce3f000 
> c18094a0 db4a3f38 db4a3f38 dedb76e0 00000000
> Nov  6 15:16:09 yvette kernel: Call Trace: [<e08a0284>] 
> [tty_open+511/872] [link_path_walk+1553/1752] [permission+43/48] 
> [chrdev_open+62/76]
> Nov  6 15:16:09 yvette kernel:    [dentry_open+225/392] 
> [filp_open+82/92] [sys_open+54/148] [system_call+51/56]
> Nov  6 15:16:09 yvette kernel:
> Nov  6 15:16:09 yvette kernel: Code: 8b 40 24 50 68 60 62 8a e0 e8 c5 
> 09 87 df 83 c4 08 83 3d 80
> Nov  6 15:16:42 yvette kernel:  <7>hub.c: port 1 connection change
> Nov  6 15:16:42 yvette kernel: hub.c: port 1, portstatus 100, change 
> 3, 12 Mb/s
> Nov  6 15:16:42 yvette kernel: usb.c: USB disconnect on device 2
> Nov  6 15:16:42 yvette kernel: visor.c: visor_shutdown
> Nov  6 15:16:42 yvette kernel: visor.c: visor_close - port 1







Greg KH wrote:

>On Mon, Nov 05, 2001 at 10:36:16AM +0000, Stephan Gutschke wrote:
>
>>Hi there,
>>if anything else is needed, let me know.
>>
>
>Could you load the driver with "debug=1" and then try this again?  If
>the oops happens, can you send me the kernel debug log?
>
>And does this happen at the end of the sync, or the beginning?
>Every time?  Occasionally?
>
>thanks,
>
>greg k-h
>


-- 
Stephan Gutschke



