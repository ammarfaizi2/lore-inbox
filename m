Return-Path: <linux-kernel-owner+w=401wt.eu-S1751465AbXAPUbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbXAPUbP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 15:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbXAPUbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 15:31:15 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:39558 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751469AbXAPUbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 15:31:14 -0500
Date: Tue, 16 Jan 2007 15:31:10 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.20-rc5: BUG: lock held at task exit time!
 (pm_mutex){--..}, at: [<c013bfff>] enter_state+0x3f/0x170
In-Reply-To: <200701162122.42581.arvidjaar@mail.ru>
Message-ID: <Pine.LNX.4.44L0.0701161515150.2550-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2007, Andrey Borzenkov wrote:

> I have Toshiba Portege 4000 that almost always hangs dead resuming from STR. 
> This was better before 2.6.18, since then STR is unusable. Sometimes it 
> manages to resume; yesterday I got on console and in dmesg:
> 
> =====================================
> [ BUG: lock held at task exit time! ]
> - -------------------------------------
> echo/28793 is exiting with locks still held!
> 1 lock held by echo/28793:
>  #0:  (pm_mutex){--..}, at: [<c013bfff>] enter_state+0x3f/0x170
> 
> stack backtrace:
>  [<c0103fea>] show_trace_log_lvl+0x1a/0x30
>  [<c01045f2>] show_trace+0x12/0x20
>  [<c01046a6>] dump_stack+0x16/0x20
>  [<c0132377>] debug_check_no_locks_held+0x87/0x90
>  [<c011c8bb>] do_exit+0x4db/0x820
>  [<c011cc29>] do_group_exit+0x29/0x70
>  [<c011cc7f>] sys_exit_group+0xf/0x20
>  [<c010300e>] sysenter_past_esp+0x5f/0x99
>  =======================

Have you tried using 2.6.19?  There was a bug which got fixed in that 
release.

Alan Stern

