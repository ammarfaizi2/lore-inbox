Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUJIIwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUJIIwr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 04:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUJIIwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 04:52:47 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52153 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266486AbUJIIwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 04:52:44 -0400
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Lee Revell <rlrevell@joe-job.com>
To: dwalker@mvista.com
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>,
       "Amakarov@Ru. Mvista. Com" <amakarov@ru.mvista.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       "Ext-Rt-Dev@Mvista. Com" <ext-rt-dev@mvista.com>,
       New Zhang Haitao <hzhang@ch.mvista.com>,
       "Yyang@Ch. Mvista. Com" <yyang@ch.mvista.com>
In-Reply-To: <1097307234.13748.1.camel@dhcp153.mvista.com>
References: <41677E4D.1030403@mvista.com>
	 <1097304045.1442.166.camel@krustophenia.net>
	 <1097307234.13748.1.camel@dhcp153.mvista.com>
Content-Type: text/plain
Message-Id: <1097311963.1428.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 04:52:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 03:33, Daniel Walker wrote:
> Do you have 4k stacks turned off? The docs make note of this.
> 

OK after fixing this it builds OK, but several modules complain about
unresolved symbols:

Oct  9 04:43:23 krustophenia kernel: usbcore: Unknown symbol kmutex_unlock
Oct  9 04:43:23 krustophenia kernel: usbcore: Unknown symbol kmutex_lock
Oct  9 04:43:23 krustophenia kernel: usbcore: Unknown symbol kmutex_init
Oct  9 04:43:23 krustophenia kernel: uhci_hcd: Unknown symbol usb_hcd_pci_probe
Oct  9 04:43:23 krustophenia kernel: uhci_hcd: Unknown symbol usb_check_bandwidth
Oct  9 04:43:23 krustophenia kernel: uhci_hcd: Unknown symbol usb_disabled
Oct  9 04:43:23 krustophenia kernel: uhci_hcd: Unknown symbol usb_release_bandwidth
Oct  9 04:43:23 krustophenia kernel: uhci_hcd: Unknown symbol usb_register_root_hub
Oct  9 04:43:23 krustophenia kernel: uhci_hcd: Unknown symbol usb_put_dev
Oct  9 04:43:23 krustophenia kernel: uhci_hcd: Unknown symbol usb_get_dev
Oct  9 04:43:23 krustophenia kernel: uhci_hcd: Unknown symbol usb_claim_bandwidth
Oct  9 04:43:23 krustophenia kernel: uhci_hcd: Unknown symbol usb_hcd_giveback_urb
Oct  9 04:43:23 krustophenia kernel: uhci_hcd: Unknown symbol kmutex_unlock
Oct  9 04:43:23 krustophenia kernel: uhci_hcd: Unknown symbol kmutex_lock
Oct  9 04:43:23 krustophenia kernel: uhci_hcd: Unknown symbol usb_hcd_pci_remove
Oct  9 04:43:23 krustophenia kernel: uhci_hcd: Unknown symbol kmutex_init
Oct  9 04:43:23 krustophenia kernel: uhci_hcd: Unknown symbol usb_alloc_dev
Oct  9 04:43:23 krustophenia kernel: usbcore: Unknown symbol kmutex_unlock
Oct  9 04:43:23 krustophenia kernel: usbcore: Unknown symbol kmutex_lock
Oct  9 04:43:23 krustophenia kernel: usbcore: Unknown symbol kmutex_init
Oct  9 04:43:23 krustophenia kernel: usbhid: Unknown symbol usb_alloc_urb
Oct  9 04:43:23 krustophenia kernel: usbhid: Unknown symbol usb_free_urb
Oct  9 04:43:23 krustophenia kernel: usbhid: Unknown symbol usb_register
Oct  9 04:43:23 krustophenia kernel: usbhid: Unknown symbol usb_submit_urb
Oct  9 04:43:23 krustophenia kernel: usbhid: Unknown symbol usb_control_msg
Oct  9 04:43:23 krustophenia kernel: usbhid: Unknown symbol usb_deregister
Oct  9 04:43:23 krustophenia kernel: usbhid: Unknown symbol usb_string
Oct  9 04:43:23 krustophenia kernel: usbhid: Unknown symbol usb_unlink_urb
Oct  9 04:43:23 krustophenia kernel: usbhid: Unknown symbol kmutex_unlock
Oct  9 04:43:23 krustophenia kernel: usbhid: Unknown symbol kmutex_lock
Oct  9 04:43:23 krustophenia kernel: usbhid: Unknown symbol usb_kill_urb
Oct  9 04:43:23 krustophenia kernel: usbhid: Unknown symbol usb_buffer_free
Oct  9 04:43:23 krustophenia kernel: usbhid: Unknown symbol kmutex_init
Oct  9 04:43:23 krustophenia kernel: usbhid: Unknown symbol __usb_get_extra_descriptor
Oct  9 04:43:23 krustophenia kernel: usbhid: Unknown symbol usb_buffer_alloc
Oct  9 04:43:23 krustophenia kernel: via_rhine: Unknown symbol kmutex_unlock
Oct  9 04:43:23 krustophenia kernel: via_rhine: Unknown symbol kmutex_lock
Oct  9 04:43:23 krustophenia kernel: via_rhine: Unknown symbol kmutex_init

Lee

