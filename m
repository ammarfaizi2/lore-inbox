Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266531AbUFVCHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbUFVCHQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 22:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUFVCHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 22:07:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53891 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266531AbUFVCGn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 22:06:43 -0400
Message-ID: <40D7941F.3020909@pobox.com>
Date: Mon, 21 Jun 2004 22:06:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Takashi Iwai <tiwai@suse.de>, Matt Porter <mporter@kernel.crashing.org>,
       Jamey Hicks <jamey.hicks@hp.com>, Ian Molton <spyro@f2s.com>,
       linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       david-b@pacbell.net, joshua@joshuawise.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: DMA API issues
References: <20040618175902.778e616a.spyro@f2s.com> <20040618110721.B3851@home.com> <40D3356E.8040800@hp.com> <20040618122112.D3851@home.com> <20040618204322.C17516@flint.arm.linux.org.uk> <s5hoendm3td.wl@alsa2.suse.de> <20040622000838.B7802@flint.arm.linux.org.uk>
In-Reply-To: <20040622000838.B7802@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Jun 21, 2004 at 03:35:42PM +0200, Takashi Iwai wrote:
>>Yes, the struct page pointer is needed for vma_ops.nopage in mmap on
>>ALSA.  So far, this is broken on some architectures like ARM.  We need
>>a proper conversion from virtual/bus pointer to a page struct.
> 
> 
> Please get away from your nopage implementation.  We've been around this
> before with Linus, and the conclusion was that it's up to architectures
> to provide a MMAP method for DMA memory, which _may_ use the nopage
> method if and only if it is appropriate for their implementation.


Can you elaborate?

When I was writing sound/oss/via82cxxx_audio.c, Linus specifically 
recommended using ->nopage, which worked out quite well (modulo cleaning 
up VM_xxx flags).

	Jeff


