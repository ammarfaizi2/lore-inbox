Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbVHPKMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbVHPKMu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 06:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbVHPKMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 06:12:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48560 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965190AbVHPKMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 06:12:49 -0400
Date: Tue, 16 Aug 2005 11:12:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: shahid shaikh <shahid.shaikh@patni.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Defination of Flag CONFIG_DEBUG_SPINLOCK_SLEEP in AS4 UP1
Message-ID: <20050816101248.GA22395@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	shahid shaikh <shahid.shaikh@patni.com>,
	linux-kernel@vger.kernel.org
References: <00a501c5a24a$4339aca0$11051aac@pcp41116>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a501c5a24a$4339aca0$11051aac@pcp41116>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's AS UP1 in your subject?

On Tue, Aug 16, 2005 at 03:37:07PM +0530, shahid shaikh wrote:
> Hi all,
> While doing insmod for a psuedo driver, kernel is dumping a stack because
> sleep function is called.
> My init_module function for psuedo driver calls add_disk to register admin
> device.
> In add_disk(), kernel is allocating memory using kmalloc with flag
> GFP_KERNEL. This is hardcoded in kernel code for add_disk.
> 
> Whenever kernel inserts any module or driver it disable all interrupts.

No, it doesn't you must be doing it yourself somewhere, probably using
a spin_lock_irq or spin_lock_irqsave.  If you can't find the problem
yourself post your module source to the kernelnewbies@nl.linux.org list
the deals with such basic problems.

