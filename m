Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWILTp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWILTp4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 15:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWILTp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 15:45:56 -0400
Received: from holoclan.de ([62.75.158.126]:4494 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S1030390AbWILTpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 15:45:55 -0400
Date: Tue, 12 Sep 2006 16:41:06 +0200
From: Martin Lorenz <martin@lorenz.eu.org>
To: linux-thinkpad@linux-thinkpad.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ltp] do I have to worry?
Message-ID: <20060912144106.GT7767@gimli>
Mail-Followup-To: linux-thinkpad@linux-thinkpad.org,
	linux-kernel@vger.kernel.org
References: <20060912102844.GH7767@gimli>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912102844.GH7767@gimli>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Tue, Sep 12, 2006 at 12:28:44PM +0200, Dipl.-Ing.
	Martin Lorenz wrote: > Hi all, > > I found another error in my dmesg: >
	> [50219.992000] e1000: eth0: e1000_watchdog: NIC Link is Down >
	[50225.266000] Trying to free already-free IRQ 201 > [50225.271000]
	bridge-eth0: disabling the bridge > [50225.274000] bridge-eth0: down >
	[50225.317000] IRQ handler type mismatch for IRQ 90 > [50225.318000]
	[<c0103d74>] show_trace_log_lvl+0x5b/0x14d > [50225.318000] [<c01044a3>]
	show_trace+0xf/0x11 > [50225.318000] [<c01045a6>] dump_stack+0x15/0x17 >
	[50225.318000] [<c01403bf>] setup_irq+0x17d/0x190 > [50225.318000]
	[<c014044e>] request_irq+0x7c/0x98 > [50225.318000] [<c02514ea>]
	e1000_open+0xcd/0x1a4 > [50225.319000] [<c0295134>] dev_open+0x2b/0x62 >
	[50225.320000] [<c0293c59>] dev_change_flags+0x47/0xe4 > [50225.321000]
	[<c02c7791>] devinet_ioctl+0x252/0x556 > [50225.322000] [<c028b083>]
	sock_ioctl+0x19a/0x1be > [50225.323000] [<c016b58b>] do_ioctl+0x1f/0x62
	> [50225.324000] [<c016b813>] vfs_ioctl+0x245/0x257 > [50225.324000]
	[<c016b871>] sys_ioctl+0x4c/0x67 > [50225.324000] [<c0102dab>]
	syscall_call+0x7/0xb > [50225.324000] DWARF2 unwinder stuck at
	syscall_call+0x7/0xb > [50225.324000] Leftover inexact backtrace: >
	[50225.324000] e1000: eth0: e1000_request_irq: Unable to allocate
	interrupt > Error: -16 > [50226.370000] bridge-eth0: enabling the bridge
	> [50226.370000] bridge-eth0: up > [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 12:28:44PM +0200, Dipl.-Ing. Martin Lorenz wrote:
> Hi all,
> 
> I found another error in my dmesg:
> 
> [50219.992000] e1000: eth0: e1000_watchdog: NIC Link is Down
> [50225.266000] Trying to free already-free IRQ 201
> [50225.271000] bridge-eth0: disabling the bridge
> [50225.274000] bridge-eth0: down
> [50225.317000] IRQ handler type mismatch for IRQ 90
> [50225.318000]  [<c0103d74>] show_trace_log_lvl+0x5b/0x14d
> [50225.318000]  [<c01044a3>] show_trace+0xf/0x11
> [50225.318000]  [<c01045a6>] dump_stack+0x15/0x17
> [50225.318000]  [<c01403bf>] setup_irq+0x17d/0x190
> [50225.318000]  [<c014044e>] request_irq+0x7c/0x98
> [50225.318000]  [<c02514ea>] e1000_open+0xcd/0x1a4
> [50225.319000]  [<c0295134>] dev_open+0x2b/0x62
> [50225.320000]  [<c0293c59>] dev_change_flags+0x47/0xe4
> [50225.321000]  [<c02c7791>] devinet_ioctl+0x252/0x556
> [50225.322000]  [<c028b083>] sock_ioctl+0x19a/0x1be
> [50225.323000]  [<c016b58b>] do_ioctl+0x1f/0x62
> [50225.324000]  [<c016b813>] vfs_ioctl+0x245/0x257
> [50225.324000]  [<c016b871>] sys_ioctl+0x4c/0x67
> [50225.324000]  [<c0102dab>] syscall_call+0x7/0xb
> [50225.324000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
> [50225.324000] Leftover inexact backtrace:
> [50225.324000] e1000: eth0: e1000_request_irq: Unable to allocate interrupt
> Error: -16
> [50226.370000] bridge-eth0: enabling the bridge
> [50226.370000] bridge-eth0: up
> 

> 
> I have no idea what it tries to tell me here.
> it happened on undocking my X60s from the ultrabay
> 
now I saw the same one twice in the dmesg on resume

if I'm not very much mistaken this is an e1000 issue


here is the one on resume:

[65284.946000] Trying to free already-free IRQ 201
[65284.949000] bridge-eth0: disabling the bridge
[65284.952000] bridge-eth0: down
[65284.966000] IRQ handler type mismatch for IRQ 90
[65284.966000]  [<c0103d74>] show_trace_log_lvl+0x5b/0x14d
[65284.966000]  [<c01044a3>] show_trace+0xf/0x11
[65284.967000]  [<c01045a6>] dump_stack+0x15/0x17
[65284.967000]  [<c01403bf>] setup_irq+0x17d/0x190
[65284.967000]  [<c014044e>] request_irq+0x7c/0x98
[65284.967000]  [<c02514ea>] e1000_open+0xcd/0x1a4
[65284.968000]  [<c0295134>] dev_open+0x2b/0x62
[65284.969000]  [<c0293c59>] dev_change_flags+0x47/0xe4
[65284.970000]  [<c02c7791>] devinet_ioctl+0x252/0x556
[65284.971000]  [<c028b083>] sock_ioctl+0x19a/0x1be
[65284.972000]  [<c016b58b>] do_ioctl+0x1f/0x62
[65284.972000]  [<c016b813>] vfs_ioctl+0x245/0x257
[65284.973000]  [<c016b871>] sys_ioctl+0x4c/0x67
[65284.973000]  [<c0102dab>] syscall_call+0x7/0xb
[65284.973000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
[65284.973000] Leftover inexact backtrace:
[65284.973000] e1000: eth0: e1000_request_irq: Unable to allocate interrupt
Error: -16
[65286.019000] IRQ handler type mismatch for IRQ 98
[65286.019000]  [<c0103d74>] show_trace_log_lvl+0x5b/0x14d
[65286.019000]  [<c01044a3>] show_trace+0xf/0x11
[65286.019000]  [<c01045a6>] dump_stack+0x15/0x17
[65286.019000]  [<c01403bf>] setup_irq+0x17d/0x190
[65286.019000]  [<c014044e>] request_irq+0x7c/0x98
[65286.019000]  [<c02514ea>] e1000_open+0xcd/0x1a4
[65286.020000]  [<c0295134>] dev_open+0x2b/0x62
[65286.021000]  [<c0293c59>] dev_change_flags+0x47/0xe4
[65286.021000]  [<c02c7791>] devinet_ioctl+0x252/0x556
[65286.022000]  [<c028b083>] sock_ioctl+0x19a/0x1be
[65286.023000]  [<c016b58b>] do_ioctl+0x1f/0x62
[65286.023000]  [<c016b813>] vfs_ioctl+0x245/0x257
[65286.023000]  [<c016b871>] sys_ioctl+0x4c/0x67
[65286.024000]  [<c0102dab>] syscall_call+0x7/0xb
[65286.024000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
[65286.024000] Leftover inexact backtrace:
[65286.024000] e1000: eth0: e1000_request_irq: Unable to allocate interrupt
Error: -16
[65287.070000] bridge-eth0: enabling the bridge
[65287.070000] bridge-eth0: up

thanks
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
