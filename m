Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266043AbUA1VjM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 16:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266178AbUA1VjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 16:39:12 -0500
Received: from ns.suse.de ([195.135.220.2]:32706 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266043AbUA1VjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 16:39:07 -0500
Date: Wed, 28 Jan 2004 22:39:05 +0100
From: Andi Kleen <ak@suse.de>
To: Grant Grundler <iod00d@hp.com>
Cc: ishii.hironobu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, anton@samba.org
Subject: Re: [RFC/PATCH, 1/4] readX_check() performance evaluation
Message-Id: <20040128223905.2ecfb683.ak@suse.de>
In-Reply-To: <20040128211405.GG5722@cup.hp.com>
References: <00a201c3e541$c0e7d680$2987110a@lsd.css.fujitsu.com>
	<20040128172004.GB5494@cup.hp.com>
	<20040128184137.616b6425.ak@suse.de>
	<20040128190923.GA6333@cup.hp.com>
	<20040128201701.045670db.ak@suse.de>
	<20040128211405.GG5722@cup.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004 13:14:05 -0800
Grant Grundler <iod00d@hp.com> wrote:

> 
> > I believe ppc64 has adopted it too. Of course most drivers don't 
> > use it yet.
> 
> <search 2.6.2-rc2 source tree>
> grundler <502>find -name '*.[chS]' | xargs fgrep pci_dma_error
> ./include/asm-x86_64/pci.h:#define pci_dma_error(x) ((x) ==
> bad_dma_address)
> grundler <503>
> 
> That explains why most drivers don't use it yet.
> It's only supported on one arch.
> Maybe propose this to linux-pci mailing list?

It was discussed on linux-arch and ppc64 at least agreed on it.
The other architectures can get it via a comptibility #define that 
is always 0.

There was a patch for that somewhere, but apparently it was never merged
or not merged yet.

Anton, what was the state of that?

-Andi
