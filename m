Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWAJMnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWAJMnL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWAJMnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:43:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22414 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750810AbWAJMnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:43:09 -0500
Date: Tue, 10 Jan 2006 04:42:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
Message-Id: <20060110044240.3d3aa456.akpm@osdl.org>
In-Reply-To: <43C3A85A.7000003@reub.net>
References: <20060107052221.61d0b600.akpm@osdl.org>
	<43BFD8C1.9030404@reub.net>
	<20060107133103.530eb889.akpm@osdl.org>
	<43C38932.7070302@reub.net>
	<20060110104759.GA30546@elte.hu>
	<43C3A85A.7000003@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> Ok here's the latest one, this time with KALLSYMS_ALL, CONFIG_FRAME_POINTER, 
>  CONFIG_DETECT_SOFTLOCKUP and the DEBUG_WARN_ON(current->state != TASK_RUNNING); 
>  patch from Ingo.

This is quite ugly.  I'd be suspecting a block layer problem: RAID or the
underlying device driver (ahci) has lost an IO.
