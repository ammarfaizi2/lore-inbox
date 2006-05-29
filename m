Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWE2J21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWE2J21 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 05:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWE2J21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 05:28:27 -0400
Received: from smtp2.actcom.co.il ([192.114.47.35]:29646 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S1750807AbWE2J20
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 05:28:26 -0400
Message-ID: <023201c6830a$827539b0$c400a8c0@Chavalaptop>
From: "Chava Leviatan" <chavale@actcom.net.il>
To: <bidulock@openss7.org>
Cc: <linux-kernel@vger.kernel.org>
References: <003101c682ff$1b7c7350$c400a8c0@Chavalaptop> <20060529021315.B23539@openss7.org>
Subject: Re: Ethernet driver module compilation  (8139too)
Date: Mon, 29 May 2006 12:27:34 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

I did reboot the machine, and saw that during boot time there is a call to 
depmod.
I did depmod -ae as you've requested, and here are the results:
  [root@NettGain root]# depmod -ae >chav.dat
depmod: /lib/modules/2.4.18-3/kernel/drivers/net/makefile.8139 is not an ELF 
file
depmod: /lib/modules/2.4.18-3/kernel/drivers/net/makefile.eepro is not an 
ELF file
depmod: *** Unresolved symbols in 
/lib/modules/2.4.18-3/kernel/drivers/net/8139too.o
depmod:         __netdev_watchdog_up
depmod:         flush_signals
depmod:         eth_type_trans
depmod:         mii_ethtool_sset
depmod:         __kfree_skb
depmod:         alloc_skb
depmod:         pci_register_driver
depmod:         mii_link_ok
depmod:         pci_free_consistent
depmod:         pci_enable_device
depmod:         pci_read_config_byte
depmod:         alloc_etherdev
depmod:         mii_ethtool_gset
depmod:         reparent_to_init
depmod:         cpu_raise_softirq
depmod:         free_irq
depmod:         unregister_netdev
depmod:         kill_proc
depmod:         iounmap
depmod:         pci_alloc_consistent
depmod:         interruptible_sleep_on_timeout
depmod:         __ioremap
depmod:         pci_read_config_word
depmod:         skb_copy_and_csum_dev
depmod:         register_netdev
depmod:         kfree
depmod:         pci_release_regions
depmod:         wait_for_completion
depmod:         request_irq
depmod:         mii_nway_restart
depmod:         netif_rx
depmod:         pci_unregister_driver
depmod:         skb_over_panic
depmod:         pci_set_master
depmod:         do_BUG
depmod:         rtnl_unlock
depmod:         pci_write_config_word
depmod:         daemonize
depmod:         jiffies
depmod:         softnet_data
depmod:         rtnl_lock
depmod:         printk
depmod:         complete_and_exit
depmod:         kernel_thread
depmod:         __const_udelay
depmod:         pci_request_regions


Please note that if I manually insmod mii , then the insmod 8139too passes 
w/o problems .

Chava
----- Original Message ----- 
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: "Chava Leviatan" <chavale@actcom.net.il>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, May 29, 2006 10:13 AM
Subject: Re: Ethernet driver module compilation (8139too)


> Chava,
>
> On Mon, 29 May 2006, Chava Leviatan wrote:
>> I then tried to manually install it (insmod) and was promp with 
>> unresolved
>> external. I found out that
>> those unresolved belong to mii.o which was not loaded during the boot
>> process.
>
> Did you reboot the machine?  Did you do depmod -ae?
>
> Which symbols?  What did the error message say exactly...  What is the
> output of depmod -ae with the module installed?
>
> --brian
> 

