Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272251AbTGYSuu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 14:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272252AbTGYSuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 14:50:50 -0400
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:55822
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S272251AbTGYSur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 14:50:47 -0400
Message-ID: <3F218224.8030807@rogers.com>
Date: Fri, 25 Jul 2003 15:16:52 -0400
From: gaxt <gaxt@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030708 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: Torrey Hoffman <thoffman@arnor.net>, Sam Bromley <sbromley@cogeco.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
References: <20030725142907.GI23196@ruvolo.net> <20030725142926.GD1512@phunnypharm.org> <20030725154009.GF1512@phunnypharm.org> <20030725160706.GK23196@ruvolo.net> <20030725161803.GJ1512@phunnypharm.org> <1059155483.2525.16.camel@torrey.et.myrio.com> <20030725181303.GO23196@ruvolo.net> <20030725181252.GA607@phunnypharm.org> <3F217A39.2020803@rogers.com> <20030725182642.GD607@phunnypharm.org> <20030725184506.GE607@phunnypharm.org>
In-Reply-To: <20030725184506.GE607@phunnypharm.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.157.78.60] using ID <dw2price@rogers.com> at Fri, 25 Jul 2003 15:05:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
> Maybe it wont. Try reverting back to stock, and apply this patch. I am
> pretty sure this will fix the problem for anyone having this issue.
> 
> Index: linux-2.6/drivers/ieee1394/ieee1394_core.c

...

root@localhost linux # make modules modules_install
...
drivers/ieee1394/csr.c: In function `calculate_expire':
drivers/ieee1394/csr.c:120: warning: implicit declaration of function 
`HPSB_VERBOSE'
...
   Building modules, stage 2.
   MODPOST
*** Warning: "HPSB_VERBOSE" [drivers/ieee1394/ieee1394.ko] undefined!
   LD [M]  drivers/ieee1394/dv1394.ko
...

root@localhost linux # modprobe ieee1394
FATAL: Error inserting ieee1394 
(/lib/modules/2.6.0-test1-mm2/kernel/drivers/ieee1394/ieee1394.ko): 
Unknown symbol in module, or unknown parameter (see dmesg)

...

dmesg:

ieee1394: NodeMgr: Exiting thread
ohci1394_0: Soft reset finished
ohci1394_0: Freeing dma_rcv_ctx 0
ohci1394_0: Freeing dma_rcv_ctx 0
ohci1394_0: Freeing dma_trm_ctx 0
ohci1394_0: Freeing dma_trm_ctx 1
raw1394: /dev/raw1394 device initialized
ohci1394: $Rev$ Ben Collins <bcollins@debian.org>
ohci1394_0: Remapped memory spaces reg 0xd093f800
ohci1394_0: Soft reset finished
ohci1394_0: Iso contexts reg: 000000a8 implemented: 0000000f
ohci1394_0: 4 iso receive contexts available
ohci1394_0: Iso contexts reg: 00000098 implemented: 000000ff
ohci1394_0: 8 iso transmit contexts available
ohci1394_0: GUID: 060050c5:000001ce
ohci1394_0: Receive DMA ctx=0 initialized
ohci1394_0: Receive DMA ctx=0 initialized
ohci1394_0: Transmit DMA ctx=0 initialized
ohci1394_0: Transmit DMA ctx=1 initialized
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[5]  MMIO=[cfffc800-cfffcfff]  Max 
Packet=[2048]
ohci1394_0: request csr_rom address: c3efa000
ohci1394_0: IntEvent: 00020010
ohci1394_0: irq_handler: Bus reset requested
ohci1394_0: Cancel request received
ieee1394: TLABEL: splicing pending packets for abort_requests
ohci1394_0: Got RQPkt interrupt status=0x00008409
ohci1394_0: Single packet rcv'd
ohci1394_0: Got phy packet ctx=0 ... discarded
ohci1394_0: IntEvent: 00010000
ohci1394_0: SelfID interrupt received (phyid 0, root)
ohci1394_0: SelfID packet 0x807f8c56 received
ieee1394: Including SelfID 0x568c7f80
ohci1394_0: SelfID for this node is 0x807f8c56
ohci1394_0: SelfID complete
ohci1394_0: PhyReqFilter=ffffffffffffffff
ieee1394: selfid_complete called with successful SelfID stage ... 
irm_id: 0xFFC0 node_id: 0xFFC0
ieee1394: NodeMgr: Processing host reset for knodemgrd_0
ieee1394: Initiating ConfigROM request for node 0-00:1023
ieee1394: send packet local: ffc00140 ffc0ffff f0000400
ieee1394: TLABEL: appending packet to pending list
ieee1394: TLABEL: packet removed in abort_timedouts
ieee1394: received packet: ffc00140 ffc0ffff f0000400
ieee1394: send packet local: ffc00160 ffc00000 00000000 dee10404
ieee1394: TLABEL: no_waiter, returning
ieee1394: received packet: ffc00160 ffc00000 00000000 dee10404
ieee1394: TLABEL: Checking for tlabel 0
ieee1394: unsolicited response packet received - no tlabel match
ieee1394: contents: ffc00160 ffc00000 00000000 dee10404
ieee1394: send packet local: ffc00540 ffc0ffff f0000400
ieee1394: TLABEL: appending packet to pending list
ieee1394: TLABEL: packet removed in abort_timedouts
ieee1394: received packet: ffc00540 ffc0ffff f0000400
ieee1394: send packet local: ffc00560 ffc00000 00000000 dee10404
ieee1394: TLABEL: no_waiter, returning
ieee1394: received packet: ffc00560 ffc00000 00000000 dee10404
ieee1394: TLABEL: Checking for tlabel 1
ieee1394: unsolicited response packet received - no tlabel match
ieee1394: contents: ffc00560 ffc00000 00000000 dee10404
ieee1394: send packet local: ffc00940 ffc0ffff f0000400
ieee1394: TLABEL: appending packet to pending list
ieee1394: TLABEL: packet removed in abort_timedouts
ieee1394: received packet: ffc00940 ffc0ffff f0000400
ieee1394: send packet local: ffc00960 ffc00000 00000000 dee10404
ieee1394: TLABEL: no_waiter, returning
ieee1394: received packet: ffc00960 ffc00000 00000000 dee10404
ieee1394: TLABEL: Checking for tlabel 2
ieee1394: unsolicited response packet received - no tlabel match
ieee1394: contents: ffc00960 ffc00000 00000000 dee10404
ieee1394: ConfigROM quadlet transaction error for node 0-00:1023
ieee1394: send packet 100: ffff0100 ffc0ffff f0000234 1f0000c0
ohci1394_0: Inserting packet for node 0-63:1023, tlabel=0, tcode=0x0, 
speed=0
ohci1394_0: Starting transmit DMA ctx=0
ohci1394_0: IntEvent: 00000001
ohci1394_0: Got reqTxComplete interrupt status=0x00008011
ohci1394_0: Packet sent to node 63 tcode=0x0 tLabel=0x00 ack=0x11 spd=0 
data=0x1F0000C0 ctx=0
ieee1394: TLABEL: not pending or no response expected, returning
bad: scheduling while atomic!
Call Trace:
  [<c01178e6>] schedule+0x3f6/0x400
  [<c0116c7e>] try_to_wake_up+0x9e/0x180
  [<c0117c41>] wait_for_completion+0x91/0x110
  [<c0117950>] default_wake_function+0x0/0x30
  [<c0117950>] default_wake_function+0x0/0x30
  [<c0124d02>] kill_proc_info+0x62/0x70
  [<d0aab945>] nodemgr_remove_host+0x55/0xa0 [ieee1394]
  [<d0aa70cc>] highlevel_remove_host+0x6c/0x80 [ieee1394]
  [<d094c521>] ohci1394_pci_remove+0x41/0x230 [ohci1394]
  [<c021eabb>] pci_device_remove+0x3b/0x40
  [<c0285436>] device_release_driver+0x66/0x70
  [<c0285460>] driver_detach+0x20/0x30
  [<c02856bd>] bus_remove_driver+0x3d/0x80
  [<c0285af3>] driver_unregister+0x13/0x28
  [<c021ed96>] pci_unregister_driver+0x16/0x30
  [<d094c9df>] ohci1394_cleanup+0xf/0x13 [ohci1394]
  [<c012fdf2>] sys_delete_module+0x152/0x1c0
  [<c0144100>] do_munmap+0x130/0x190
  [<c010921b>] syscall_call+0x7/0xb

ieee1394: NodeMgr: Exiting thread
ohci1394_0: Soft reset finished
ohci1394_0: Freeing dma_rcv_ctx 0
ohci1394_0: Freeing dma_rcv_ctx 0
ohci1394_0: Freeing dma_trm_ctx 0
ohci1394_0: Freeing dma_trm_ctx 1
ieee1394: Unknown symbol HPSB_VERBOSE
root@localhost linux #


