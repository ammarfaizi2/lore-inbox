Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265146AbUAMRrW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 12:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUAMRrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 12:47:22 -0500
Received: from beholder.inittab.de ([195.226.163.101]:8851 "EHLO
	beholder.inittab.de") by vger.kernel.org with ESMTP id S264498AbUAMRnm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 12:43:42 -0500
Date: Tue, 13 Jan 2004 15:13:10 +0100
From: Norbert Tretkowski <tretkowski@inittab.de>
To: linux-kernel@vger.kernel.org
Subject: [kernel 2.6] crashes when sending wake-on-lan packets
Message-ID: <20040113141309.GB16534@rollcage.inittab.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
Mail-Copies-To: nobody
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[Please CC me, I'm not subscribed]

Hi,

I noticed with Debian's kernel image for kernel 2.6.0 that the kernel
panics when sending wake-on-lan packets with ether-wake to that
machine (complete minicom Output attached, also attached is the oops
and the ksymoops (getting /proc/ksyms wasn't possible, machine freezes
completely after oops) output). Then I tried it with plain 2.6.1 then
(.config also attached), and the machine just freezes without sending
any Oops informations when running ether-wake from a remote machine.

The freeze with 2.6.1 is reproducible with Donald Beckers Intel
EEPRO100 driver and with the alternative driver from Intel.

If you need more informations, just ask.

Norbert

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

Unable to handle kernel NULL pointer dereference at virtual address 0000001b
 printing eip:
c011d2c2
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c011d2c2>]    Not tainted
EFLAGS: 00010046
EIP is at schedule+0x32e/0x4e8
eax: ce97564d   ebx: c02fc000   ecx: c02fc000   edx: 00000000
esi: efb30ca0   edi: 00000003   ebp: c02fc1ec   esp: c02fc1b0
ds: 007b   es: 007b   ss: 0068
Process  (pid: 0, threadinfo=c02fc000 task=c033b405)
Stack: c02fc000 c0109020 c0105000 00000003 c02fc000 c02fc000 00033ce0 00000000
       c02fc1ec 00000679 00000000 3ccbf700 ce97564d 00000017 c02fc000 c02fc000
       c010ae79 c02fc000 00000000 c02fc000 c0109020 c0105000 c02fc000 00000000
Call Trace:
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae79>] need_resched+0x27/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c010ae80>] need_resched+0x2e/0x32
 [<c0109020>] default_idle+0x0/0x28
 [<c0105000>] _stext+0x0/0x50
 [<c0109043>] default_idle+0x23/0x28
 [<c01090be>] cpu_idle+0x32/0x40
 [<c010504d>] _stext+0x4d/0x50
 [<c02fe680>] start_kernel+0x17c/0x184
 
Code: ff 47 18 e9 9b 00 00 00 8d b6 00 00 00 00 39 55 d0 0f 84 8c

--vkogqOf2sHV7VnPd
Content-Type: message/external-body; access-type=x-mutt-deleted;
	expiration="Tue, 13 Jan 2004 18:41:40 +0100"; length=61668

Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="minicom.log"
Content-Transfer-Encoding: quoted-printable


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymoops.txt"
Content-Transfer-Encoding: quoted-printable

Script started on Tue Jan 13 14:28:14 2004
=0D=1B[m=1B[23m=1B[24m=1B[J<0>tretkowski@pc7004[pts/1]:~% =1B[Kk=08ksymoops=
 k=08 =08oops.txt =08=0D=0D
ksymoops 2.4.9 on i686 2.6.0-1-686.  Options used=0D
     -V (default)=0D
     -k /proc/ksyms (default)=0D
     -l /proc/modules (default)=0D
     -o /lib/modules/2.6.0-1-686/ (default)=0D
     -m /boot/System.map-2.6.0-1-686 (default)=0D
=0D
Warning: You did not tell me where to find symbol information.  I will=0D
assume that the log matches the kernel and modules that are running=0D
right now and I'll use the default options above for symbol resolution.=0D
If the current kernel and/or modules do not match the log, you can get=0D
more accurate output by telling me the kernel version and where to find=0D
map, modules, ksyms etc.  ksymoops -h explains the options.=0D
=0D
Error (regular_file): read_ksyms stat /proc/ksyms failed=0D
ksymoops: No such file or directory=0D
No modules in ksyms, skipping objects=0D
No ksyms, skipping lsmod=0D
Unable to handle kernel NULL pointer dereference at virtual address 0000001=
b=0D
c011d2c2=0D
*pde =3D 00000000=0D
Oops: 0002 [#1]=0D
CPU:    0=0D
EIP:    0060:[<c011d2c2>]    Not tainted=0D
Using defaults from ksymoops -t elf32-i386 -a i386=0D
EFLAGS: 00010046=0D
eax: ce97564d   ebx: c02fc000   ecx: c02fc000   edx: 00000000=0D
esi: efb30ca0   edi: 00000003   ebp: c02fc1ec   esp: c02fc1b0=0D
ds: 007b   es: 007b   ss: 0068=0D
Stack: c02fc000 c0109020 c0105000 00000003 c02fc000 c02fc000 00033ce0 00000=
000=0D
       c02fc1ec 00000679 00000000 3ccbf700 ce97564d 00000017 c02fc000 c02fc=
000=0D
       c010ae79 c02fc000 00000000 c02fc000 c0109020 c0105000 c02fc000 00000=
000=0D
Call Trace:=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae79>] need_resched+0x27/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c010ae80>] need_resched+0x2e/0x32=0D
 [<c0109020>] default_idle+0x0/0x28=0D
 [<c0105000>] _stext+0x0/0x50=0D
 [<c0109043>] default_idle+0x23/0x28=0D
 [<c01090be>] cpu_idle+0x32/0x40=0D
 [<c010504d>] _stext+0x4d/0x50=0D
 [<c02fe680>] start_kernel+0x17c/0x184=0D
Code: ff 47 18 e9 9b 00 00 00 8d b6 00 00 00 00 39 55 d0 0f 84 8c=0D
=0D
=0D
>>EIP; c011d2c2 <schedule+32e/4e8>   <=3D=3D=3D=3D=3D=0D
=0D
>>eax; ce97564d <__crc_unregister_serial+d17e8/107089>=0D
>>ebx; c02fc000 <init_thread_union+0/2000>=0D
>>ecx; c02fc000 <init_thread_union+0/2000>=0D
>>esi; efb30ca0 <__crc_llc_sap_open+5063f3/a73288>=0D
>>ebp; c02fc1ec <init_thread_union+1ec/2000>=0D
>>esp; c02fc1b0 <init_thread_union+1b0/2000>=0D
=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae79 <need_resched+27/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c010ae80 <need_resched+2e/32>=0D
Trace; c0109020 <default_idle+0/28>=0D
Trace; c0105000 <_stext+0/0>=0D
Trace; c0109043 <default_idle+23/28>=0D
Trace; c01090be <cpu_idle+32/40>=0D
Trace; c010504d <rest_init+4d/50>=0D
Trace; c02fe680 <start_kernel+17c/184>=0D
=0D
Code;  c011d2c2 <schedule+32e/4e8>=0D
00000000 <_EIP>:=0D
Code;  c011d2c2 <schedule+32e/4e8>   <=3D=3D=3D=3D=3D=0D
   0:   ff 47 18                  incl   0x18(%edi)   <=3D=3D=3D=3D=3D=0D
Code;  c011d2c5 <schedule+331/4e8>=0D
   3:   e9 9b 00 00 00            jmp    a3 <_EIP+0xa3> c011d365 <schedule+=
3d1/4e8>=0D
Code;  c011d2ca <schedule+336/4e8>=0D
   8:   8d b6 00 00 00 00         lea    0x0(%esi),%esi=0D
Code;  c011d2d0 <schedule+33c/4e8>=0D
   e:   39 55 d0                  cmp    %edx,0xffffffd0(%ebp)=0D
Code;  c011d2d3 <schedule+33f/4e8>=0D
  11:   0f 84 8c 00 00 00         je     a3 <_EIP+0xa3> c011d365 <schedule+=
3d1/4e8>=0D
=0D
=0D
1 warning and 1 error issued.  Results may not be reliable.=0D
=0D=1B[m=1B[23m=1B[24m=1B[J<1>tretkowski@pc7004[pts/1]:~% =1B[K=0D=0D

Script done on Tue Jan 13 14:28:20 2004

--vkogqOf2sHV7VnPd--
