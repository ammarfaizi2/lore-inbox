Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270243AbTHGPMh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271034AbTHGPLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:11:01 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:32447 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S270383AbTHGPIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:08:24 -0400
Date: Thu, 07 Aug 2003 08:07:57 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: p.mayers@imperial.ac.uk
Subject: [Bug 1053] New: Creative ov511 USB camera not working in 2.6
Message-ID: <32760000.1060268877@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1053

           Summary: Creative ov511 USB camera not working in 2.6
    Kernel Version: 2.6.0-test2
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: p.mayers@imperial.ac.uk


Distribution: RedHat 8 with 2.6 kernel
Hardware Environment: Intel P4 w/ Intel 82845G-based motherboard
Software Environment: Gnome/X
Problem Description:

I have a Creative ov511-based USB webcam which worked fine under numerous 2.4
kernel versions. Using 2.6.0-test2, I get numerous errors, but most
significantly if I try xawtv:

Aug  7 11:56:54 wildfire0 kernel: hub 2-1:0: debounce: port 2: delay 100ms
stable 4 status 0x101
Aug  7 11:56:54 wildfire0 kernel: hub 2-1:0: new USB device on port 2, assigned
address 12
Aug  7 11:56:54 wildfire0 kernel: drivers/usb/media/ov511.c: USB OV511+ video
device found
Aug  7 11:56:54 wildfire0 kernel: drivers/usb/media/ov511.c: model: Creative
Labs WebCam 3
Aug  7 11:56:54 wildfire0 kernel: drivers/usb/media/ov511.c: Sensor is an OV7620
Aug  7 11:56:55 wildfire0 kernel: drivers/usb/media/ov511.c: Device at
usb-0000:00:1d.1-1.2 registered to minor 0
Aug  7 12:13:13 wildfire0 kernel: Debug: sleeping function called from invalid
context at drivers/usb/core/hcd.c:1350
Aug  7 12:13:13 wildfire0 kernel: Call Trace:
Aug  7 12:13:13 wildfire0 kernel:  [<c011d2d6>] __might_sleep+0x5c/0x60
Aug  7 12:13:13 wildfire0 kernel:  [<c032ba81>] hcd_endpoint_disable+0xb7/0x162
Aug  7 12:13:13 wildfire0 kernel:  [<c032cecd>] usb_set_interface+0x10b/0x204
Aug  7 12:13:13 wildfire0 kernel:  [<c032b9ca>] hcd_endpoint_disable+0x0/0x162
Aug  7 12:13:13 wildfire0 kernel:  [<d0a331f7>]
ov511_set_packet_size+0x14b/0x2e0 [ov511]
Aug  7 12:13:13 wildfire0 kernel:  [<c035b0ab>] sock_destroy_inode+0x1d/0x22
Aug  7 12:13:13 wildfire0 kernel:  [<d0a38606>] ov51x_stop_isoc+0x42/0x92 [ov511]
Aug  7 12:13:13 wildfire0 kernel:  [<c016b537>] iput+0x63/0x7c
Aug  7 12:13:13 wildfire0 kernel:  [<d0a38e75>] ov51x_v4l1_close+0x57/0x14a [ov511]
Aug  7 12:13:13 wildfire0 kernel:  [<c0153333>] __fput+0xfd/0x110
Aug  7 12:13:13 wildfire0 kernel:  [<c0151abb>] filp_close+0x4b/0x74
Aug  7 12:13:13 wildfire0 kernel:  [<c0120b14>] put_files_struct+0x90/0x104
Aug  7 12:13:13 wildfire0 kernel:  [<c01216fc>] do_exit+0x17e/0x3aa
Aug  7 12:13:13 wildfire0 kernel:  [<c015263b>] sys_write+0x3f/0x5e
Aug  7 12:13:13 wildfire0 kernel:  [<c012195b>] sys_exit+0x15/0x16
Aug  7 12:13:13 wildfire0 kernel:  [<c01092c7>] syscall_call+0x7/0xb
Aug  7 12:13:13 wildfire0 kernel: 
Aug  7 12:13:24 wildfire0 kernel: Debug: sleeping function called from invalid
context at drivers/usb/core/hcd.c:1350
Aug  7 12:13:24 wildfire0 kernel: Call Trace:
Aug  7 12:13:24 wildfire0 kernel:  [<c011d2d6>] __might_sleep+0x5c/0x60
Aug  7 12:13:24 wildfire0 kernel:  [<c032ba81>] hcd_endpoint_disable+0xb7/0x162
Aug  7 12:13:24 wildfire0 kernel:  [<c032cecd>] usb_set_interface+0x10b/0x204
Aug  7 12:13:24 wildfire0 kernel:  [<c032b9ca>] hcd_endpoint_disable+0x0/0x162
Aug  7 12:13:24 wildfire0 kernel:  [<d0a331f7>]
ov511_set_packet_size+0x14b/0x2e0 [ov511]
Aug  7 12:13:24 wildfire0 kernel:  [<c035b0ab>] sock_destroy_inode+0x1d/0x22
Aug  7 12:13:24 wildfire0 kernel:  [<d0a38606>] ov51x_stop_isoc+0x42/0x92 [ov511]
Aug  7 12:13:24 wildfire0 kernel:  [<c016b537>] iput+0x63/0x7c
Aug  7 12:13:24 wildfire0 kernel:  [<d0a38e75>] ov51x_v4l1_close+0x57/0x14a [ov511]
Aug  7 12:13:24 wildfire0 kernel:  [<c0153333>] __fput+0xfd/0x110
Aug  7 12:13:24 wildfire0 kernel:  [<c0151abb>] filp_close+0x4b/0x74
Aug  7 12:13:24 wildfire0 kernel:  [<c0120b14>] put_files_struct+0x90/0x104
Aug  7 12:13:24 wildfire0 kernel:  [<c01216fc>] do_exit+0x17e/0x3aa
Aug  7 12:13:24 wildfire0 kernel:  [<c015263b>] sys_write+0x3f/0x5e
Aug  7 12:13:24 wildfire0 kernel:  [<c012195b>] sys_exit+0x15/0x16
Aug  7 12:13:24 wildfire0 kernel:  [<c01092c7>] syscall_call+0x7/0xb
Aug  7 12:13:24 wildfire0 kernel: 
Aug  7 12:13:25 wildfire0 kernel: drivers/usb/media/ov511.c: reg write: error
-110: NAK (device does not respond)
Aug  7 12:13:25 wildfire0 kernel: drivers/usb/media/ov511.c: ERROR:
urb->status=-84: CRC/Timeout
Aug  7 12:13:25 wildfire0 last message repeated 2 times
Aug  7 12:13:25 wildfire0 kernel: usb 2-1.2: USB disconnect, address 12
Aug  7 12:13:25 wildfire0 kernel: hub 2-1:0: debounce: port 2: delay 100ms
stable 4 status 0x101
Aug  7 12:13:25 wildfire0 kernel: hub 2-1:0: new USB device on port 2, assigned
address 13
Aug  7 12:13:25 wildfire0 kernel: drivers/usb/media/ov511.c: USB OV511+ video
device found
Aug  7 12:13:25 wildfire0 kernel: drivers/usb/media/ov511.c: model: Creative
Labs WebCam 3
Aug  7 12:13:25 wildfire0 kernel: drivers/usb/media/ov511.c: Sensor is an OV7620
Aug  7 12:13:26 wildfire0 kernel: drivers/usb/media/ov511.c: Device at
usb-0000:00:1d.1-1.2 registered to minor 0


xawtv reports:

[root@wildfire0 root]# xawtv       
This is xawtv-3.74, running on Linux/i686 (2.6.0-test2)
xinerama 0: 1152x864+0+0
xinerama 1: 1152x864+1152+0
/dev/video0 [v4l]: no overlay support
ioctl: VIDIOCGPICT(params=0/0/0/0/0,depth=0,fmt=0): Input/output error
ioctl: VIDIOCGCHAN(0,Camera,flags=0x0,type=2,norm=0): Input/output error
ioctl: VIDIOCGPICT(params=0/0/0/0/0,depth=0,fmt=0): Input/output error
ioctl: VIDIOCGPICT(params=0/0/0/0/0,depth=0,fmt=0): Input/output error
ioctl: VIDIOCGPICT(params=0/0/0/0/0,depth=0,fmt=0): Input/output error
ioctl: VIDIOCGPICT(params=0/0/0/0/0,depth=0,fmt=0): Input/output error
ioctl: VIDIOCGPICT(params=0/0/0/0/0,depth=0,fmt=0): Input/output error
ioctl: VIDIOCSPICT(params=0/0/0/0/0,depth=0,fmt=0): Input/output error
ioctl: VIDIOCGPICT(params=0/0/0/0/0,depth=0,fmt=0): Input/output error
ioctl: VIDIOCSPICT(params=0/0/0/0/0,depth=0,fmt=0): Input/output error
ioctl: VIDIOCGPICT(params=0/0/0/0/0,depth=0,fmt=0): Input/output error
ioctl: VIDIOCSPICT(params=0/0/0/0/0,depth=0,fmt=0): Input/output error
ioctl: VIDIOCGPICT(params=0/0/0/0/0,depth=0,fmt=0): Input/output error
ioctl: VIDIOCSPICT(params=0/0/0/0/0,depth=0,fmt=0): Input/output error
ioctl: VIDIOCSCHAN(0,Camera,flags=0x0,type=2,norm=0): Input/output error
ioctl: VIDIOCGCHAN(0,Camera,flags=0x0,type=2,norm=0): Input/output error
ioctl: VIDIOCSCHAN(0,Camera,flags=0x0,type=2,norm=0): Input/output error
ioctl: VIDIOCGCAP(OV511+ USB
Camera,type=0x201,chan=1,audio=0,size=64x48-640x480): Input/output error
ioctl: VIDIOCMCAPTURE(0,fmt=7,size=64x48): Input/output error
ioctl: VIDIOCGCAP(OV511+ USB
Camera,type=0x201,chan=1,audio=0,size=64x48-640x480): Input/output error
ioctl: VIDIOCMCAPTURE(0,fmt=15,size=64x48): Input/output error
ioctl: VIDIOCGCAP(OV511+ USB
Camera,type=0x201,chan=1,audio=0,size=64x48-640x480): Input/output error
ioctl: VIDIOCMCAPTURE(0,fmt=3,size=64x48): Input/output error
ioctl: VIDIOCGCAP(OV511+ USB
Camera,type=0x201,chan=1,audio=0,size=64x48-640x480): Input/output error
ioctl: VIDIOCGCAP(OV511+ USB
Camera,type=0x201,chan=1,audio=0,size=64x48-640x480): Input/output error


...and so on.

lspci gives:

[root@wildfire0 root]# lspci -tv
-[00]-+-00.0  Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge
      +-01.0-[01]----00.0  Matrox Graphics, Inc. MGA G400 AGP
      +-1d.0  Intel Corp. 82801DB USB (Hub #1)
      +-1d.1  Intel Corp. 82801DB USB (Hub #2)
      +-1d.2  Intel Corp. 82801DB USB (Hub #3)
      +-1e.0-[02]--+-01.0  National Semiconductor Corporation DP83820
10/100/1000 Ethernet Controller
      |            +-02.0  Intel Corp. 82557/8/9 [Ethernet Pro 100]
      |            \-08.0  Intel Corp. 82801BD PRO/100 VE (LOM) Ethernet Controller
      +-1f.0  Intel Corp. 82801DB ISA Bridge (LPC)
      +-1f.1  Intel Corp. 82801DB ICH4 IDE
      +-1f.3  Intel Corp. 82801DB SMBus
      \-1f.5  Intel Corp. 82801DB AC'97 Audio

and "lsusb -t":

Bus#  3
`-Dev#   1 Vendor 0x0000 Product 0x0000
Bus#  2
`-Dev#   1 Vendor 0x0000 Product 0x0000
  `-Dev#   5 Vendor 0x03eb Product 0x3301
    |-Dev#  13 Vendor 0x05a9 Product 0xa511
    `-Dev#   6 Vendor 0x0451 Product 0x1446
      |-Dev#   7 Vendor 0x045e Product 0x001d
      `-Dev#   8 Vendor 0x045e Product 0x0039
Bus#  1
`-Dev#   1 Vendor 0x0000 Product 0x0000
  `-Dev#   2 Vendor 0x04a9 Product 0x220d


...however this happens on all the USB ports on the machine.

Steps to reproduce: Plug ov511 in, modprobe ov511, start xawtv; occurs every time


