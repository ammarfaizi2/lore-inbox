Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267610AbUHWJTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267610AbUHWJTQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 05:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267613AbUHWJTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 05:19:16 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:61359 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S267610AbUHWJSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 05:18:51 -0400
Date: Mon, 23 Aug 2004 11:18:47 +0200
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: scheduling while atomic in visor/serial (2.6.8.1-mm4)
Message-ID: <20040823091847.GC7230@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi USB Gurus!

Since several kernel revisions I get hurt by a
	scheduling while atomic!
when doing transfers via usb to my palm:	

bad: scheduling while atomic!
 [schedule+1210/1216] schedule+0x4ba/0x4c0
 [group_send_sig_info+127/144] group_send_sig_info+0x7f/0x90
 [usb_kill_urb+221/304] usb_kill_urb+0xdd/0x130
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [usb_unlink_urb+69/80] usb_unlink_urb+0x45/0x50
 [serial_throttle+56/144] serial_throttle+0x38/0x90
 [n_tty_receive_buf+463/3664] n_tty_receive_buf+0x1cf/0xe50
 [preempt_schedule+42/80] preempt_schedule+0x2a/0x50
 [sock_aio_write+221/256] sock_aio_write+0xdd/0x100
 [flush_to_ldisc+152/256] flush_to_ldisc+0x98/0x100
 [visor_read_bulk_callback+273/512] visor_read_bulk_callback+0x111/0x200
 [uhci_destroy_urb_priv+181/256] uhci_destroy_urb_priv+0xb5/0x100
 [usb_hcd_giveback_urb+29/96] usb_hcd_giveback_urb+0x1d/0x60
 [uhci_finish_urb+57/96] uhci_finish_urb+0x39/0x60
 [uhci_finish_completion+51/80] uhci_finish_completion+0x33/0x50
 [uhci_irq+377/464] uhci_irq+0x179/0x1d0
 [usb_hcd_irq+46/96] usb_hcd_irq+0x2e/0x60
 [handle_IRQ_event+48/96] handle_IRQ_event+0x30/0x60
 [do_IRQ+144/304] do_IRQ+0x90/0x130
 [common_interrupt+24/32] common_interrupt+0x18/0x20
visor ttyUSB1: visor_unthrottle - failed submitting read urb, error -1


I already have asked this once but since then nothing has changed. So
are there any chances to get this fixed?

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
STURRY (n.,vb.)
A token run. Pedestrians who have chosen to cross a road immediately
in front of an approaching vehicle generally give a little wave and
break into a sturry. This gives the impression of hurrying without
having any practical effect on their speed whatsoever.
			--- Douglas Adams, The Meaning of Liff
