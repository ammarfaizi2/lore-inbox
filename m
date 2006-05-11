Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030407AbWEKSDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbWEKSDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 14:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWEKSDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 14:03:24 -0400
Received: from web52901.mail.yahoo.com ([206.190.49.11]:37279 "HELO
	web52901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030407AbWEKSDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 14:03:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=3qZx+pZ541s0yAtfYABje3J4rf9gTmdIE9kACizLxC6fg4GBzNYpGKGOjdVZ0H1Selr5Osx8oiPR/8xrSSF4mVekQPR8ddMi4Ms7VTMR2BAi1vrRx/X+c2Js0T07zkJ1TOSJSIYVFRauWOJ/oNLpDQGkgNmmyyBp84nbUYaVdoI=  ;
Message-ID: <20060511180320.49788.qmail@web52901.mail.yahoo.com>
Date: Thu, 11 May 2006 11:03:19 -0700 (PDT)
From: Winn Johnston <winn_johnston@yahoo.com>
Subject: BUG: soft lockup detected on CPU#0!
To: linux-kernel@vger.kernel.org
In-Reply-To: <20060511173312.GI25010@moss.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Error:

kernel: hdi: drive_cmd: status=0xd0 { Busy }
kernel: ide: failed opcode was: 0xea
BUG: soft lockup detected on CPU#0!

the odd thing is the system experiences a hard lockup,
so it is not a false positive. I am working on a
trace, but it is hard to get.

My supervisor has asked me to help research this
problem. We are using multiple ata cards in our backup
machine. We have a Promiss sata 300tx4, and three ATA
cards (3 SIG UltraATA 133 PCI) or (3 promise ultra
100tx2). We are experiencing hard lockups. The system
resides on a scsi drive connected to the on board
controler Adaptec AIC-7899P (Tyan S2462
motherboard)the error is repeated for all drives
connected to the promis cards, and the error continues
until a lock up is eventualy reached.

Also, its in dma mode, not pio.
PREEMPT_NONE is already set, so its not the preemption
model

possibly related posts
http://www.ussg.iu.edu/hypermail/linux/kernel/0309.1/0444.html

http://groups.google.com/group/linux.kernel/browse_thread/thread/450966ffa3043609/59e6a2350b7690bf?lnk=st&q=kernel%3A+ide%3A+failed+opcode+was%3A+0xea%22+BUG%3A+soft+lockup+detected+on+CPU%230!%22&rnum=1&hl=en#59e6a2350b7690bf





__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
