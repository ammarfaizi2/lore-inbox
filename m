Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWFNCVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWFNCVu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 22:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWFNCVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 22:21:50 -0400
Received: from web50208.mail.yahoo.com ([206.190.38.49]:53667 "HELO
	web50208.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964919AbWFNCVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 22:21:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=bCKatAMGFycJGL51Jb+TdJhBzVEckFnsGLwVNdGEwkYzBvUSHnaOyNHt7xkSBW7KHzU+BS118jXuKBUg3ftERT/GRtKRUNASonDIsIEnMaASshpb9Qou+UgBCISxSDVfHEkpZR0pSfwynBbKOoeO6fp4sIZNIZFkZhKUD+kxpGo=  ;
Message-ID: <20060614022139.21737.qmail@web50208.mail.yahoo.com>
Date: Tue, 13 Jun 2006 19:21:39 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: Kernel panic when re-inserting Adaptec PCMCIA card
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Alex Davis <alex14641@yahoo.com> wrote:
> 
> The card is an Adaptec SlimSCSI 1460D Fast SCSI card.
> I frequently get this panic when re-inserting the card:
> 
> Jun 13 17:53:29 siafu kernel: [4364313.475000] pccard: PCMCIA card inserted into slot 0
> Jun 13 17:53:29 siafu kernel: [4364313.475000] pcmcia: registering new device pcmcia0.0
> Jun 13 17:53:30 siafu kernel: [4364313.526000] aha152x: resetting bus...
> Jun 13 17:53:30 siafu kernel: [4364313.882000] aha152x2: vital data: rev=1, io=0xd340
> (0xd340/0xd340), irq=3, scsiid=7, reconnect=enabled, parity=enabled, synchronous=enabled,
> delay=100, extended translation=disabled
> Jun 13 17:53:30 siafu kernel: [4364313.882000] aha152x2: trying software interrupt, ok.
> Jun 13 17:53:30 siafu kernel: [4364314.883000] scsi2 : Adaptec 152x SCSI driver; $Revision: 2.7
> $
> Jun 13 17:53:30 siafu kernel: [4364314.895000]
> Jun 13 17:53:30 siafu kernel: [4364314.895000] aha152x0: bottom-half already running!?
> Jun 13 17:53:30 siafu kernel: [4364314.895000]
> Jun 13 17:53:30 siafu kernel: [4364314.895000] queue status:
> Jun 13 17:53:30 siafu kernel: [4364314.895000] issue_SC:
> Jun 13 17:53:30 siafu kernel: [4364314.895000] BUG: unable to handle kernel NULL pointer
> dereference at virtual address 00000066
> Jun 13 17:53:30 siafu kernel: [4364314.895000]  printing eip:
> Jun 13 17:53:30 siafu kernel: [4364314.895000] e0a71e0c
> Jun 13 17:53:30 siafu kernel: [4364314.895000] *pde = 00000000
> Jun 13 17:53:30 siafu kernel: [4364314.895000] Oops: 0000 [#1]
> Jun 13 17:53:30 siafu kernel: [4364314.895000] Modules linked in: ide_cd cdrom radeon drm
[snip]

Same panic occurs in 2.6.17rc6:

Jun 13 17:50:36 siafu kernel: [4295220.230000] pccard: PCMCIA card inserted into slot 0
Jun 13 17:50:36 siafu kernel: [4295220.230000] pcmcia: registering new device pcmcia0.0
Jun 13 17:50:37 siafu kernel: [4295220.281000] aha152x: resetting bus...
Jun 13 17:50:37 siafu kernel: [4295220.637000] aha152x13: vital data: rev=1, io=0xd340
(0xd340/0xd340), irq=3, scsiid=7, reconnect=enabled,
 parity=enabled, synchronous=enabled, delay=100, extended translation=disabled
Jun 13 17:50:37 siafu kernel: [4295220.637000] aha152x13: trying software interrupt, ok.
Jun 13 17:50:37 siafu kernel: [4295221.638000] scsi13 : Adaptec 152x SCSI driver; $Revision: 2.7 $
Jun 13 17:50:37 siafu kernel: [4295221.650000]
Jun 13 17:50:37 siafu kernel: [4295221.650000] aha152x22856: bottom-half already running!?
Jun 13 17:50:37 siafu kernel: [4295221.650000]
Jun 13 17:50:37 siafu kernel: [4295221.650000] queue status:
Jun 13 17:50:37 siafu kernel: [4295221.650000] issue_SC:
Jun 13 17:50:37 siafu kernel: [4295221.650000] current_SC:
Jun 13 17:50:37 siafu kernel: [4295221.650000] BUG: unable to handle kernel paging request at
virtual address 00020016
Jun 13 17:50:37 siafu kernel: [4295221.650000]  printing eip:
Jun 13 17:50:37 siafu kernel: [4295221.650000] e0a64e0c
Jun 13 17:50:37 siafu kernel: [4295221.650000] *pde = 00000000
Jun 13 17:50:37 siafu kernel: [4295221.650000] Oops: 0000 [#1]
Jun 13 17:50:37 siafu kernel: [4295221.650000] Modules linked in: aha152x_cs ide_cd cdrom radeon
drm scsi_transport_spi snd_pcm_oss snd_mix
er_oss ohci_hcd usbhid intel_agp uhci_hcd generic snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm
snd_timer snd soundcore snd_page_alloc 8
250_pci 8250 serial_core tg3 yenta_socket rsrc_nonstatic pcmcia firmware_class crc32 pcmcia_core
nls_iso8859_1 ntfs usbkbd usbmouse agpgart
 usb_storage sd_mod scsi_mod ehci_hcd
Jun 13 17:50:37 siafu kernel: [4295221.650000] CPU:    0
Jun 13 17:50:37 siafu kernel: [4295221.650000] EIP:    0060:[<e0a64e0c>]    Not tainted VLI
Jun 13 17:50:37 siafu kernel: [4295221.650000] EFLAGS: 00010286   (2.6.17-rc6debug #1)
Jun 13 17:50:37 siafu kernel: [4295221.650000] EIP is at show_command+0xc/0x1a0 [aha152x_cs]
Jun 13 17:50:37 siafu kernel: [4295221.650000] eax: 00020012   ebx: 00020012   ecx: 00000000  
edx: 00000000
Jun 13 17:50:37 siafu kernel: [4295221.650000] esi: d77aa800   edi: 00000296   ebp: 00000000  
esp: dff07eb4
Jun 13 17:50:37 siafu kernel: [4295221.650000] ds: 007b   es: 007b   ss: 0068
Jun 13 17:50:37 siafu kernel: [4295221.650000] Process events/0 (pid: 4, threadinfo=dff06000
task=dff63a50)
Jun 13 17:50:37 siafu kernel: [4295221.650000] Stack: 00000296 00000000 c011a947 00020012 00000000
e0a65004 00020012 d77aa800
Jun 13 17:50:37 siafu kernel: [4295221.650000]        d77aa800 dffa2700 e0a64c4f d77aa800 00005948
e0a66aa7 00000286 e0a64c10
Jun 13 17:50:37 siafu kernel: [4295221.650000]        d77aa800 e0a66aa7 c0294667 dff07f4c dff63a50
00000001 00000296 dffa2700
Jun 13 17:50:37 siafu kernel: [4295221.650000] Call Trace:
Jun 13 17:50:37 siafu kernel: [4295221.650000]  <c011a947> printk+0x17/0x20  <e0a65004>
show_queues+0x64/0xc0 [aha152x_cs]
Jun 13 17:50:37 siafu kernel: [4295221.650000]  <e0a64c4f> aha152x_error+0x2f/0x40 [aha152x_cs] 
<e0a64c10> is_complete+0x280/0x290 [aha152x_cs]
Jun 13 17:50:37 siafu kernel: [4295221.650000]  <c0294667> schedule+0x317/0x5d0  <e0a62619>
run+0x19/0x30 [aha152x_cs]
Jun 13 17:50:37 siafu kernel: [4295221.650000]  <c012926f> run_workqueue+0x6f/0xe0  <e0a62600>
run+0x0/0x30 [aha152x_cs]
Jun 13 17:50:37 siafu kernel: [4295221.650000]  <c012942b> worker_thread+0x14b/0x170  <c0116b60>
default_wake_function+0x0/0x20
Jun 13 17:50:37 siafu kernel: [4295221.650000]  <c0116b60> default_wake_function+0x0/0x20 
<c01292e0> worker_thread+0x0/0x170
Jun 13 17:50:37 siafu kernel: [4295221.650000]  <c012c7ea> kthread+0xba/0xc0  <c012c730>
kthread+0x0/0xc0
Jun 13 17:50:37 siafu kernel: [4295221.650000]  <c01013bd> kernel_thread_helper+0x5/0x18
Jun 13 17:50:37 siafu kernel: [4295221.650000] Code: 6b df e9 bc fe ff ff c7 04 24 8f 6b a6 e0 e8
3c 5b 6b df e9 a2 fe ff ff 8d b4 26 00 00
 00 00 53 83 ec 10 8b 5c 24 18 89 5c 24 0c <8b> 53 04 8d 82 34 01 00 00 89 44 24 08 8b 82 70 01 00
00 ba 09
Jun 13 17:50:37 siafu kernel: [4295221.650000] EIP: [<e0a64e0c>] show_command+0xc/0x1a0
[aha152x_cs] SS:ESP 0068:dff07eb4
Jun 13 17:50:53 siafu kernel: [4295221.650000]  <3>(scsi13:0:0) cannot reuse command


I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
