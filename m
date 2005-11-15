Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbVKOXrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbVKOXrf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 18:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbVKOXrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 18:47:35 -0500
Received: from web34105.mail.mud.yahoo.com ([66.163.178.103]:2432 "HELO
	web34105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965084AbVKOXrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 18:47:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=26u5Cy+f/2sAG6P3JfQ2toP0fgmDxAUtlwdyhvQ1HMPFcLEI1S9LYQQKcqBIVWHD7PJcWUK4ZX0HEwokKuxmNnSM7FrTFz94UE6LnofJk0GADDxE0qQNfEJd8RRxM7exP1eMHFEmGmEqO901T9rKIMOAuvG+35DPqDafsiBPHI4=  ;
Message-ID: <20051115234731.9539.qmail@web34105.mail.mud.yahoo.com>
Date: Tue, 15 Nov 2005 15:47:30 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: re: mmap over nfs leads to excessive system load
To: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051115224645.27832.qmail@web34103.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran the same test again against 2.6.15-rc, and got pretty much the same thing.  It starts nice
and fast (30+MB/s, but drops down to under 10MB/s with the system time pegging one CPU).

Here is the oprofile result:

CPU: P4 / Xeon with 2 hyper-threads, speed 2658.47 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not stopped) with a unit mask
of 0x01 (mandatory) count 100000
samples  %        symbol name
412585   14.6687  find_get_pages_tag
343898   12.2267  mpage_writepages
290144   10.3155  release_pages
288631   10.2617  unlock_page
286181   10.1746  pci_conf1_write
267619    9.5147  clear_page_dirty_for_io
128128    4.5554  __lookup_tag
120895    4.2982  page_waitqueue
52739     1.8750  _spin_lock_irqsave
43623     1.5509  skb_copy_bits
30157     1.0722  __wake_up_bit
29973     1.0656  _read_lock_irqsave


-Kenny



		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
