Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318246AbSGQJDA>; Wed, 17 Jul 2002 05:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318247AbSGQJC7>; Wed, 17 Jul 2002 05:02:59 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:34196 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S318246AbSGQJC5>; Wed, 17 Jul 2002 05:02:57 -0400
Date: Wed, 17 Jul 2002 11:05:54 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Subject: Re: Breakage with "usb-storage: catch bad commands"
Message-ID: <20020717090554.GB14581@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
References: <20020716140722.GM7955@tahoe.alcove-fr> <20020716103503.B14269@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020716103503.B14269@one-eyed-alien.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 10:35:04AM -0700, Matthew Dharm wrote:

> Can you recompile with the verbose debugging turned on so we can see which
> command caused the problem?

Sure, here it comes (regenerated with 2.5.26 now available):

Jul 17 10:10:25 crusoe kernel: uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
Jul 17 10:10:25 crusoe kernel: hcd-pci.c: uhci-hcd @ 00:07.2, Intel Corp. 82371AB PIIX4 USB
Jul 17 10:10:25 crusoe kernel: hcd-pci.c: irq 9, io base 00001060
Jul 17 10:10:25 crusoe kernel: hcd.c: new USB bus registered, assigned bus number 1
Jul 17 10:10:25 crusoe kernel: hub.c: USB hub found at /
Jul 17 10:10:25 crusoe kernel: hub.c: 2 ports detected
Jul 17 10:10:26 crusoe kernel: hub.c: new USB device 00:07.2-2, assigned address 2
Jul 17 10:10:26 crusoe kernel: usb.c: USB device 2 (vend/prod 0x54c/0x32) is not claimed by any active driver.
Jul 17 10:10:28 crusoe /etc/hotplug/usb.agent: Setup usbcore for USB product 0/0/205
Jul 17 10:10:29 crusoe /etc/hotplug/usb.agent: Setup usbcore for USB product 0/0/205
Jul 17 10:10:29 crusoe /etc/hotplug/usb.agent: Setup usb-storage for USB product 54c/32/131
Jul 17 10:10:29 crusoe kernel: Initializing USB Mass Storage driver...
Jul 17 10:10:29 crusoe kernel: usb.c: registered new driver usb-storage
Jul 17 10:10:29 crusoe kernel: usb-storage: act_altsetting is 0
Jul 17 10:10:29 crusoe kernel: usb-storage: id_index calculated to be: 24
Jul 17 10:10:29 crusoe kernel: usb-storage: Array length appears to be: 67
Jul 17 10:10:29 crusoe kernel: usb-storage: Vendor: Sony
Jul 17 10:10:29 crusoe kernel: usb-storage: Product: Memorystick MSC-U01N
Jul 17 10:10:29 crusoe kernel: usb-storage: USB Mass Storage device detected
Jul 17 10:10:29 crusoe kernel: usb-storage: Endpoints: In: 0xc5ca87e0 Out: 0xc5ca87f4 Int: 0xc5ca8808 (Period 255)
Jul 17 10:10:29 crusoe kernel: usb-storage: New GUID 054c00320000000000000000
Jul 17 10:10:29 crusoe kernel: usb-storage: Transport: Control/Bulk
Jul 17 10:10:29 crusoe kernel: usb-storage: Protocol: Uniform Floppy Interface (UFI)
Jul 17 10:10:29 crusoe kernel: usb-storage: Allocating usb_ctrlrequest
Jul 17 10:10:29 crusoe kernel: usb-storage: Allocating URB
Jul 17 10:10:29 crusoe kernel: usb-storage: *** thread sleeping.
Jul 17 10:10:29 crusoe kernel: scsi0 : SCSI emulation for USB Mass Storage devices
Jul 17 10:10:29 crusoe kernel: usb-storage: queuecommand() called
Jul 17 10:10:29 crusoe kernel: usb-storage: *** thread awakened.
Jul 17 10:10:29 crusoe kernel: usb-storage: Command INQUIRY (6 bytes)
Jul 17 10:10:30 crusoe kernel: usb-storage: 12 00 00 00 24 00 00 00 00 00 00 00
Jul 17 10:10:30 crusoe kernel: usb-storage: Call to usb_stor_control_msg() returned 12
Jul 17 10:10:30 crusoe kernel: usb-storage: usb_stor_transfer_partial(): xfer 36 bytes
Jul 17 10:10:30 crusoe kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 36/36
Jul 17 10:10:30 crusoe kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jul 17 10:10:30 crusoe kernel: usb-storage: CB data stage result is 0x0
Jul 17 10:10:30 crusoe kernel: usb-storage: -- CB transport device requiring auto-sense
Jul 17 10:10:30 crusoe kernel: usb-storage: ** no auto-sense for a special command
Jul 17 10:10:30 crusoe kernel: usb-storage: Fixing INQUIRY data to show SCSI rev 2
Jul 17 10:10:30 crusoe kernel: usb-storage: scsi cmd done, result=0x0
Jul 17 10:10:30 crusoe kernel: usb-storage: *** thread sleeping.
Jul 17 10:10:30 crusoe kernel:   Vendor: Sony      Model: MSC-U01N          Rev: 1.00
Jul 17 10:10:30 crusoe kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jul 17 10:10:30 crusoe kernel: usb-storage: queuecommand() called
Jul 17 10:10:30 crusoe kernel: usb-storage: *** thread awakened.
Jul 17 10:10:30 crusoe kernel: usb-storage: Command INQUIRY (6 bytes)
Jul 17 10:10:30 crusoe kernel: usb-storage: 12 01 00 00 ff 00 00 00 00 00 00 00
Jul 17 10:10:30 crusoe kernel: usb-storage: Call to usb_stor_control_msg() returned 12

Jul 17 10:10:30 crusoe kernel: kernel BUG at transport.c:351!
Jul 17 10:10:30 crusoe kernel: invalid operand: 0000
Jul 17 10:10:30 crusoe kernel: CPU:    0
Jul 17 10:10:30 crusoe kernel: EIP:    0010:[<c78ed481>]    Not tainted
Jul 17 10:10:30 crusoe kernel: EFLAGS: 00010293
Jul 17 10:10:30 crusoe kernel: eax: 000000ff   ebx: 00000024   ecx: c78f1260   edx: ffffffff
Jul 17 10:10:30 crusoe kernel: esi: c4d4be00   edi: 00000000   ebp: c4d4be00   esp: c47c7f2c
Jul 17 10:10:30 crusoe kernel: ds: 0018   es: 0018   ss: 0018
Jul 17 10:10:30 crusoe kernel: Stack: 0000000c c4d4b800 c4d4be00 c78ee10a c4d4be00 c4d4be00 00000000 c4d4b800 
Jul 17 10:10:30 crusoe kernel:        c78ed95b c4d4be00 c4d4b800 c4d4be00 c78f0102 c78f3280 00000012 00000001 
Jul 17 10:10:30 crusoe kernel:        00000000 00000000 c4d4be00 00000000 c4d4b800 c78f4b2c c78ed1af c4d4be00 
Jul 17 10:10:30 crusoe kernel: Call Trace: [<c78ee10a>] [<c78ed95b>] [<c78f0102>] [<c78f3280>] [<c78f4b2c>] 
Jul 17 10:10:30 crusoe kernel:    [<c78ed1af>] [<c78eed4f>] [<c01122f0>] [<c0108519>] [<c78ee9ef>] [<c0106ea6>] 
Jul 17 10:10:30 crusoe kernel:    [<c78ee9ef>] [<c78f4b2c>] 
Jul 17 10:10:30 crusoe kernel: Code: 0f 0b 5f 01 04 36 8f c7 89 d8 5b 5e 5f c3 8b 44 24 04 8b 40 

>>EIP; c78ed481 <[usb-storage]usb_stor_transfer_length+19d/1ab>   <=====
Trace; c78ee10a <[usb-storage]usb_stor_CB_transport+c3/fd>
Trace; c78ed95b <[usb-storage]usb_stor_invoke_transport+1b/300>
Trace; c78f0102 <[usb-storage]usb_stor_show_command+3a6/3ab>
Trace; c78f3280 <[usb-storage].rodata.end+2a91/42d1>
Trace; c78f4b2c <[usb-storage]usb_stor_sense_notready+0/14>
Trace; c78ed1af <[usb-storage]usb_stor_ufi_command+10a/132>
Trace; c78eed4f <[usb-storage]usb_stor_control_thread+360/44a>
Trace; c01122f0 <schedule_tail+1a/1d>
Trace; c0108519 <ret_from_fork+5/14>
Trace; c78ee9ef <[usb-storage]usb_stor_control_thread+0/44a>
Trace; c0106ea6 <kernel_thread+26/30>
Trace; c78ee9ef <[usb-storage]usb_stor_control_thread+0/44a>
Trace; c78f4b2c <[usb-storage]usb_stor_sense_notready+0/14>
Code;  c78ed481 <[usb-storage]usb_stor_transfer_length+19d/1ab>
00000000 <_EIP>:
Code;  c78ed481 <[usb-storage]usb_stor_transfer_length+19d/1ab>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c78ed483 <[usb-storage]usb_stor_transfer_length+19f/1ab>
   2:   5f                        pop    %edi
Code;  c78ed484 <[usb-storage]usb_stor_transfer_length+1a0/1ab>
   3:   01 04 36                  add    %eax,(%esi,%esi,1)
Code;  c78ed487 <[usb-storage]usb_stor_transfer_length+1a3/1ab>
   6:   8f c7                     pop    %edi
Code;  c78ed489 <[usb-storage]usb_stor_transfer_length+1a5/1ab>
   8:   89 d8                     mov    %ebx,%eax
Code;  c78ed48b <[usb-storage]usb_stor_transfer_length+1a7/1ab>
   a:   5b                        pop    %ebx
Code;  c78ed48c <[usb-storage]usb_stor_transfer_length+1a8/1ab>
   b:   5e                        pop    %esi
Code;  c78ed48d <[usb-storage]usb_stor_transfer_length+1a9/1ab>
   c:   5f                        pop    %edi
Code;  c78ed48e <[usb-storage]usb_stor_transfer_length+1aa/1ab>
   d:   c3                        ret    
Code;  c78ed48f <[usb-storage]usb_stor_blocking_completion+0/c>
   e:   8b 44 24 04               mov    0x4(%esp,1),%eax
Code;  c78ed493 <[usb-storage]usb_stor_blocking_completion+4/c>
  12:   8b 40 00                  mov    0x0(%eax),%eax

Jul 17 10:10:35 crusoe kernel:  <7>usb-storage: command_abort() called
Jul 17 10:10:35 crusoe kernel: usb-storage: usb_stor_abort_transport called
Jul 17 10:10:35 crusoe kernel: usb-storage: queuecommand() called

Jul 17 10:10:35 crusoe kernel: kernel BUG at scsiglue.c:150!
Jul 17 10:10:35 crusoe kernel: invalid operand: 0000
Jul 17 10:10:35 crusoe kernel: CPU:    0
Jul 17 10:10:35 crusoe kernel: EIP:    0010:[<c78ec1c6>]    Not tainted
Jul 17 10:10:35 crusoe kernel: EFLAGS: 00010002
Jul 17 10:10:35 crusoe kernel: eax: 00000003   ebx: c4d4b800   ecx: 00000001   edx: 00000001
Jul 17 10:10:35 crusoe kernel: esi: c4d4be00   edi: c4d4be00   ebp: c47c3f28   esp: c47c3ef0
Jul 17 10:10:35 crusoe kernel: ds: 0018   es: 0018   ss: 0018
Jul 17 10:10:35 crusoe kernel: Stack: c47c2000 00000292 c788356b c4d4be00 c788303e c4d4ba00 00000000 00000000 
Jul 17 10:10:35 crusoe kernel:        00000000 c47c3f34 c47c3f34 00000046 00000000 c0115a37 00000000 00000000 
Jul 17 10:10:35 crusoe kernel:        00000000 c47c3f34 c47c3f34 c4d4be00 c4d4b800 00000202 c4d4be00 c4d4be58 
Jul 17 10:10:35 crusoe kernel: Call Trace: [<c788356b>] [<c788303e>] [<c0115a37>] [<c7883398>] [<c7883f02>] 
Jul 17 10:10:36 crusoe kernel:    [<c78ec066>] [<c78846aa>] [<c0108519>] [<c78ec066>] [<c0106ea6>] [<c788454a>] 
Jul 17 10:10:36 crusoe kernel: Code: 0f 0b 96 00 08 35 8f c7 8b 44 24 10 8d 8b 7c 01 00 00 89 86 

>>EIP; c78ec1c6 <[usb-storage]queuecommand+3e/6d>   <=====
Trace; c788356b <[scsi_mod]scsi_send_eh_cmnd+ac/1e0>
Trace; c788303e <[scsi_mod]scsi_eh_done+0/6c>
Trace; c0115a37 <printk+11d/13e>
Trace; c7883398 <[scsi_mod]scsi_test_unit_ready+85/10b>
Trace; c7883f02 <[scsi_mod]scsi_unjam_host+31f/967>
Trace; c78ec066 <[usb-storage]detect+0/28>
Trace; c78846aa <[scsi_mod]scsi_error_handler+160/1b2>
Trace; c0108519 <ret_from_fork+5/14>
Trace; c78ec066 <[usb-storage]detect+0/28>
Trace; c0106ea6 <kernel_thread+26/30>
Trace; c788454a <[scsi_mod]scsi_error_handler+0/1b2>
Code;  c78ec1c6 <[usb-storage]queuecommand+3e/6d>
00000000 <_EIP>:
Code;  c78ec1c6 <[usb-storage]queuecommand+3e/6d>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c78ec1c8 <[usb-storage]queuecommand+40/6d>
   2:   96                        xchg   %eax,%esi
Code;  c78ec1c9 <[usb-storage]queuecommand+41/6d>
   3:   00 08                     add    %cl,(%eax)
Code;  c78ec1cb <[usb-storage]queuecommand+43/6d>
   5:   35 8f c7 8b 44            xor    $0x448bc78f,%eax
Code;  c78ec1d0 <[usb-storage]queuecommand+48/6d>
   a:   24 10                     and    $0x10,%al
Code;  c78ec1d2 <[usb-storage]queuecommand+4a/6d>
   c:   8d 8b 7c 01 00 00         lea    0x17c(%ebx),%ecx
Code;  c78ec1d8 <[usb-storage]queuecommand+50/6d>
  12:   89 86 00 00 00 00         mov    %eax,0x0(%esi)

Jul 17 10:10:36 crusoe kernel:  <6>note: scsi_eh_0[1296] exited with preempt_count 1
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
