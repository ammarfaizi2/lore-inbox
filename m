Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932805AbWJINZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932805AbWJINZH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 09:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932806AbWJINZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 09:25:07 -0400
Received: from holoclan.de ([62.75.158.126]:6584 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S932805AbWJINZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 09:25:03 -0400
Date: Mon, 9 Oct 2006 15:24:30 +0200
From: Martin Lorenz <martin@lorenz.eu.org>
To: linux-kernel@vger.kernel.org
Subject: BUG: warning at drivers/pci/msi.c:680/pci_enable_msi() - DWARF2 unwinder stuck at syscall_call+0x7/0xb
Message-ID: <20061009132430.GB6413@gimli>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  I currently play around with various options to localize
	my acpi problem and found the following recurring BUG warning: Oct 9
	15:11:55 gimli kernel: [ 2671.631000] BUG: warning at
	drivers/pci/msi.c:680/pci_enable_msi() Oct 9 15:11:55 gimli kernel: [
	2671.632000] [<c0103bd9>] dump_trace+0x69/0x1af Oct 9 15:11:55 gimli
	kernel: [ 2671.632000] [<c0103d37>] show_trace_log_lvl+0x18/0x2c Oct 9
	15:11:55 gimli kernel: [ 2671.632000] [<c01043d6>] show_trace+0xf/0x11
	Oct 9 15:11:55 gimli kernel: [ 2671.632000] [<c01044d9>]
	dump_stack+0x15/0x17 Oct 9 15:11:55 gimli kernel: [ 2671.632000]
	[<c0211c5e>] pci_enable_msi+0x78/0x22e Oct 9 15:11:55 gimli kernel: [
	2671.634000] [<c0275d8d>] e1000_open+0x64/0x176 Oct 9 15:11:55 gimli
	kernel: [ 2671.636000] [<c02b8ec1>] dev_open+0x2b/0x62 Oct 9 15:11:55
	gimli kernel: [ 2671.638000] [<c02b79cf>] dev_change_flags+0x47/0xe4 Oct
	9 15:11:55 gimli kernel: [ 2671.640000] [<c02eba8b>]
	devinet_ioctl+0x252/0x556 Oct 9 15:11:55 gimli kernel: [ 2671.643000]
	[<c02aec3a>] sock_ioctl+0x19e/0x1c2 Oct 9 15:11:55 gimli kernel: [
	2671.645000] [<c0169a3f>] do_ioctl+0x1f/0x62 Oct 9 15:11:55 gimli
	kernel: [ 2671.646000] [<c0169cc7>] vfs_ioctl+0x245/0x257 Oct 9 15:11:55
	gimli kernel: [ 2671.647000] [<c0169d25>] sys_ioctl+0x4c/0x67 Oct 9
	15:11:55 gimli kernel: [ 2671.647000] [<c0102dc3>] syscall_call+0x7/0xb
	Oct 9 15:11:55 gimli kernel: [ 2671.647000] DWARF2 unwinder stuck at
	syscall_call+0x7/0xb Oct 9 15:11:55 gimli kernel: [ 2671.647000] Oct 9
	15:11:55 gimli kernel: [ 2671.647000] Leftover inexact backtrace: Oct 9
	15:11:55 gimli kernel: [ 2671.647000] Oct 9 15:11:55 gimli kernel: [
	2671.648000] ======================= [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I currently play around with various options to localize my acpi problem and
found the following recurring BUG warning:

Oct  9 15:11:55 gimli kernel: [ 2671.631000] BUG: warning at drivers/pci/msi.c:680/pci_enable_msi()
Oct  9 15:11:55 gimli kernel: [ 2671.632000]  [<c0103bd9>] dump_trace+0x69/0x1af
Oct  9 15:11:55 gimli kernel: [ 2671.632000]  [<c0103d37>] show_trace_log_lvl+0x18/0x2c
Oct  9 15:11:55 gimli kernel: [ 2671.632000]  [<c01043d6>] show_trace+0xf/0x11
Oct  9 15:11:55 gimli kernel: [ 2671.632000]  [<c01044d9>] dump_stack+0x15/0x17
Oct  9 15:11:55 gimli kernel: [ 2671.632000]  [<c0211c5e>] pci_enable_msi+0x78/0x22e
Oct  9 15:11:55 gimli kernel: [ 2671.634000]  [<c0275d8d>] e1000_open+0x64/0x176
Oct  9 15:11:55 gimli kernel: [ 2671.636000]  [<c02b8ec1>] dev_open+0x2b/0x62
Oct  9 15:11:55 gimli kernel: [ 2671.638000]  [<c02b79cf>] dev_change_flags+0x47/0xe4
Oct  9 15:11:55 gimli kernel: [ 2671.640000]  [<c02eba8b>] devinet_ioctl+0x252/0x556
Oct  9 15:11:55 gimli kernel: [ 2671.643000]  [<c02aec3a>] sock_ioctl+0x19e/0x1c2
Oct  9 15:11:55 gimli kernel: [ 2671.645000]  [<c0169a3f>] do_ioctl+0x1f/0x62
Oct  9 15:11:55 gimli kernel: [ 2671.646000]  [<c0169cc7>] vfs_ioctl+0x245/0x257
Oct  9 15:11:55 gimli kernel: [ 2671.647000]  [<c0169d25>] sys_ioctl+0x4c/0x67
Oct  9 15:11:55 gimli kernel: [ 2671.647000]  [<c0102dc3>] syscall_call+0x7/0xb
Oct  9 15:11:55 gimli kernel: [ 2671.647000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
Oct  9 15:11:55 gimli kernel: [ 2671.647000]
Oct  9 15:11:55 gimli kernel: [ 2671.647000] Leftover inexact backtrace:
Oct  9 15:11:55 gimli kernel: [ 2671.647000]
Oct  9 15:11:55 gimli kernel: [ 2671.648000]  =======================

this one happened when undocking for the second time in sequence but I found
the same several times in the log in conjunction with suspend2ram 

it never happens on first suspend (or dock/undock) after booting but very
often on second sometimes not before third time 

when it has occured I can still suspend and resume, but after that no 
ACPI events are generated anymore


gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107
