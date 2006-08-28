Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWH1JPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWH1JPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 05:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWH1JPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 05:15:24 -0400
Received: from rosi.naasa.net ([212.8.0.13]:41401 "EHLO rosi.naasa.net")
	by vger.kernel.org with ESMTP id S932353AbWH1JPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 05:15:23 -0400
From: Joerg Platte <lists@naasa.net>
Reply-To: jplatte@naasa.net
To: linux-kernel@vger.kernel.org
Subject: 2.6.17.11: soft lockup detected on CPU#0
Date: Mon, 28 Aug 2006 11:15:20 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200608281115.20692.lists@naasa.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm regulary suspending my notebook. After resume skype typically produces a 
lot of processor load when trying to call somebody and I have to restart it 
to make it work again. Today, with a new kernel, skype seems to cause a soft 
lockup resulting in a freeze for a few seconds:

BUG: soft lockup detected on CPU#0!
 <c012dd51> softlockup_tick+0x85/0x99  <c011b6d4> 
update_process_times+0x35/0x57
 <c01053b1> timer_interrupt+0x3e/0x69  <c012ddee> handle_IRQ_event+0x23/0x4c
 <c012de8f> __do_IRQ+0x78/0xd1  <c01042cb> do_IRQ+0x19/0x24
 <c0102cae> common_interrupt+0x1a/0x20
BUG: soft lockup detected on CPU#0!
 <c012dd51> softlockup_tick+0x85/0x99  <c011b6d4> 
update_process_times+0x35/0x57
 <c01053b1> timer_interrupt+0x3e/0x69  <c012ddee> handle_IRQ_event+0x23/0x4c
 <c012de8f> __do_IRQ+0x78/0xd1  <c01042cb> do_IRQ+0x19/0x24
 <c0102cae> common_interrupt+0x1a/0x20

I know, skype is closed source and cannot be debugged, but even a closed 
source userland program should not be able to cause a lockup. Is the 
information given above useful to find the problem inside the kernel? If not, 
what can I do to provide better debug information? I'm using a vanilla 
2.6.17.11 kernel: 
Linux ibm 2.6.17.11 #1 PREEMPT Sat Aug 26 18:55:43 CEST 2006 i686 GNU/Linux

regards,
Jörg
