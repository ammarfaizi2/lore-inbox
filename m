Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTKKOl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 09:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTKKOl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 09:41:26 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:26240
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263518AbTKKOlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 09:41:25 -0500
Date: Tue, 11 Nov 2003 09:40:42 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Anton Blanchard <anton@samba.org>
cc: Dong V Nguyen <dvnguyen@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 kernel: Bind interrupt question.
In-Reply-To: <20031110224822.GE930@krispykreme>
Message-ID: <Pine.LNX.4.53.0311110939050.8688@montezuma.fsmlabs.com>
References: <OFEED7A2D8.B2402087-ON87256DDA.007B9132@us.ibm.com>
 <20031110224822.GE930@krispykreme>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003, Anton Blanchard wrote:

> > Have you seen any problems with interrupt binding on 2.6.0-drv45003 ?
> > I tried this command to bind interrupt, but it does not work:
> > ============================
> > cat  /proc/irq/165/smp_affinity
> > ffffffff00000000
> > echo 01 > /proc/irq/165/smp_affinity
> > cat  /proc/irq/165/smp_affinity
> > ffffffff00000000
> 
> This is probably a ppc64 specific issue, we can continue this on
> linuxppc64-dev@lists.linuxppc.org
> 
> > There is nothing changed after binding.
> > One thing I see is it shows 16 digits "ffffffff00000000" on 2.6.0 while
> > only 8 digits in 2.4 .
> 
> Its part of the support for > 32way machines, but it looks like its
> broken for some configurations (Im guessing you have CONFIG_NR_CPUS set
> to 32).

There was a fix which went in for something similar on i386 a while back.
