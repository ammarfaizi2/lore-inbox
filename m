Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268121AbTGIKR0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268110AbTGIKQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:16:09 -0400
Received: from joel.ist.utl.pt ([193.136.198.171]:40905 "EHLO joel.ist.utl.pt")
	by vger.kernel.org with ESMTP id S265911AbTGIKOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:14:11 -0400
Date: Wed, 9 Jul 2003 11:28:44 +0100 (WEST)
From: Rui Saraiva <rmps@joel.ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-bk5 + IEEE1394: ohci1394 doesn't work.
In-Reply-To: <Pine.LNX.4.44.0307090908260.1552-100000@joel.ist.utl.pt>
Message-ID: <Pine.LNX.4.44.0307091126480.1963-100000@joel.ist.utl.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's another problem when I unload the ohci1394 module:

Call Trace:
 [<c011786c>] schedule+0x3c/0x340
 [<c0117dfd>] wait_for_completion+0x8d/0xe0
 [<c0117bc0>] default_wake_function+0x0/0x20
 [<c0117bc0>] default_wake_function+0x0/0x20
 [<c022cdc3>] nodemgr_remove_host+0x33/0x70
 [<c0229272>] highlevel_remove_host+0x32/0x70
 [<c022898c>] hpsb_remove_host+0x4c/0x51
 [<d1d0414c>] ohci1394_pci_remove+0x3c/0x140 [ohci1394]
 [<c01b23ca>] pci_device_remove+0x1a/0x40
 [<c020a480>] device_release_driver+0x40/0x50
 [<c020a4ad>] driver_detach+0x1d/0x30
 [<c020a6c8>] bus_remove_driver+0x28/0x60
 [<c020aa6b>] driver_unregister+0xb/0x1d
 [<c01b263e>] pci_unregister_driver+0xe/0x20
 [<d1d044aa>] ohci1394_cleanup+0xa/0xe [ohci1394]
 [<c012cdf8>] sys_delete_module+0x158/0x180
 [<c013fac7>] sys_munmap+0x37/0x60
 [<c0108c7f>] syscall_call+0x7/0xb

Regards,
  Rui Saraiva

PS: Please CC me any reply, as I'm not subscribed to LKML.

