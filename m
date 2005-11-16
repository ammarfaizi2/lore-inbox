Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965221AbVKPEcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221AbVKPEcg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 23:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbVKPEcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 23:32:36 -0500
Received: from holomorphy.com ([66.93.40.71]:16009 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S965221AbVKPEcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 23:32:35 -0500
Date: Tue, 15 Nov 2005 20:31:52 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: mmap over nfs leads to excessive system load
Message-ID: <20051116043152.GF6916@holomorphy.com>
References: <20051115224645.27832.qmail@web34103.mail.mud.yahoo.com> <20051115234731.9539.qmail@web34105.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115234731.9539.qmail@web34105.mail.mud.yahoo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 03:47:30PM -0800, Kenny Simpson wrote:
> CPU: P4 / Xeon with 2 hyper-threads, speed 2658.47 MHz (estimated)
> Counted GLOBAL_POWER_EVENTS events (time during which processor is not stopped) with a unit mask
> of 0x01 (mandatory) count 100000
> samples  %        symbol name
> 412585   14.6687  find_get_pages_tag
> 343898   12.2267  mpage_writepages
> 290144   10.3155  release_pages
> 288631   10.2617  unlock_page
> 286181   10.1746  pci_conf1_write
> 267619    9.5147  clear_page_dirty_for_io
> 128128    4.5554  __lookup_tag
> 120895    4.2982  page_waitqueue
> 52739     1.8750  _spin_lock_irqsave
> 43623     1.5509  skb_copy_bits
> 30157     1.0722  __wake_up_bit
> 29973     1.0656  _read_lock_irqsave

67%, or 2/3 of the samples, are in the top 6 functions. Have you tried
instruction-level profiling? It would be interesting to see what
codepaths within the functions are the largest offenders.


-- wli
