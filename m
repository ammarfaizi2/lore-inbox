Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282400AbRLZRCD>; Wed, 26 Dec 2001 12:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283876AbRLZRBx>; Wed, 26 Dec 2001 12:01:53 -0500
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.69]:55559 "EHLO
	gandalf.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id <S282400AbRLZRBs>; Wed, 26 Dec 2001 12:01:48 -0500
Date: Wed, 26 Dec 2001 18:00:21 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17]: oops in usbcore during suspend
Message-ID: <20011226180021.A30644@galadriel.physik.uni-konstanz.de>
In-Reply-To: <20011223230723.GA1483@bogon.ms20.nix> <20011223184243.D5941@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011223184243.D5941@kroah.com>; from greg@kroah.com on Sun, Dec 23, 2001 at 06:42:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2001 at 06:42:43PM -0800, Greg KH wrote:
> On Mon, Dec 24, 2001 at 12:07:23AM +0100, Guido Guenther wrote:
> > Hi,
> > when suspending my Omnibook XE3 (via Fn+F12) im seeing:
> 
> Can you run that oops through ksymoops?
> 
> And if you unload the usb modules before suspending, does the same
> problem happen?

This is what I'm seeing when unloading usb-uhci and usbcore first:

ksymoops 2.4.3 on i686 2.4.17-bogon.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-bogon/ (default)
     -m /boot/System.map-2.4.17-bogon (default)

Unable to handle kernel paging request at virtual address 006f7317
c8c6d876
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[usbcore:usb_devfs_handle_Re9c5f87f+125922/197931166]    Not tainted
EFLAGS: 00013246
eax: 00000000   ebx: c77ce000   ecx: c1210000   edx: c8c7978c
esi: 00000000   edi: 006f7267   ebp: 00000000   esp: c77cfed0
ds: 0018   es: 0018   ss: 0018
Process kapm-idled (pid: 46, stackpage=c77cf000)
Stack: c77ce000 00000000 c7ce3600 c8c7959d 006f7267 c1210008 c1213ab4 c1213aa0 
       00000003 00000000 c8c7979b c7ce3600 00000000 c019f7cc c1210000 00000003 
       c019f8ae c1210000 00000003 c1213aa0 00000003 00000003 c0225d80 c019f997 
Call Trace: [usbcore:usb_devfs_handle_Re9c5f87f+174345/197882743] [usbcore:usb_devfs_handle_Re9c5f87f+174855/197882233] [pci_pm_suspend_device+32/36] [pci_pm_suspend_bus+82/104] [pci_pm_suspend+35/68] 
Code: 8b 9c 38 b0 00 00 00 85 db 74 28 8b 43 50 85 c0 74 1a 8b 80 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 9c 38 b0 00 00 00      mov    0xb0(%eax,%edi,1),%ebx
Code;  00000006 Before first symbol
   7:   85 db                     test   %ebx,%ebx
Code;  00000008 Before first symbol
   9:   74 28                     je     33 <_EIP+0x33> 00000032 Before first symbol
Code;  0000000a Before first symbol
   b:   8b 43 50                  mov    0x50(%ebx),%eax
Code;  0000000e Before first symbol
   e:   85 c0                     test   %eax,%eax
Code;  00000010 Before first symbol
  10:   74 1a                     je     2c <_EIP+0x2c> 0000002c Before first symbol
Code;  00000012 Before first symbol
  12:   8b 80 00 00 00 00         mov    0x0(%eax),%eax

Cheers,
 -- Guido
