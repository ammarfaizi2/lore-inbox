Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbULCU6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbULCU6g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 15:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbULCU6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 15:58:33 -0500
Received: from ns.onesite.org ([69.50.195.197]:59870 "EHLO floc.net")
	by vger.kernel.org with ESMTP id S262372AbULCU6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 15:58:22 -0500
Date: Fri, 3 Dec 2004 21:58:19 +0100
From: Alain Tesio <alain@onesite.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM=4G slows down ps2pdf with 2.4.28
Message-ID: <20041203215819.15bab008@alain>
In-Reply-To: <20041202190815.GA2843@dmt.cyclades>
References: <20041201232522.6e39c954@alain>
	<20041202190815.GA2843@dmt.cyclades>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2004 17:08:15 -0200
Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

> On Wed, Dec 01, 2004 at 11:25:22PM +0100, Alain Tesio wrote:
> > Hi,
> > 
> > With a 2.4.28 kernel, 1.5 Go RAM and nothing exotic, everything works fine
> > with CONFIG_HIGHMEM4G and CONFIG_HIGHMEM=y except that
> > ps2pdf is about 30 times slower 

> How does /proc/mtrr look like? 
> 
> Maybe some of your memory is configured as uncacheable.

reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
reg01: base=0x40000000 (1024MB), size= 256MB: write-back, count=1
reg02: base=0x50000000 (1280MB), size= 128MB: write-back, count=1
reg03: base=0x58000000 (1408MB), size=  64MB: write-back, count=1
reg04: base=0x5c000000 (1472MB), size=  32MB: write-back, count=1
reg05: base=0x5e000000 (1504MB), size=  16MB: write-back, count=1

I don't think that the hosting company played with the bios settings,
and I don't do anything special with memory.

Alain
