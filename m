Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757633AbWKXHwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757633AbWKXHwr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 02:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757630AbWKXHwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 02:52:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16086 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1757628AbWKXHwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 02:52:45 -0500
Subject: Re: 2.6.19-rc6 : Spontaneous reboots, stack overflows - seems to
	implicate xfs, scsi, networking, SMP
From: Arjan van de Ven <arjan@infradead.org>
To: David Chinner <dgc@sgi.com>
Cc: Ingo Oeser <netdev@axxeo.de>, David Miller <davem@davemloft.net>,
       jesper.juhl@gmail.com, chatz@melbourne.sgi.com,
       linux-kernel@vger.kernel.org, xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       netdev@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20061124005528.GF11034@melbourne.sgi.com>
References: <9a8748490611211551v2ebe88fel2bcf25af004c338a@mail.gmail.com>
	 <20061122.201013.112290046.davem@davemloft.net>
	 <20061123070837.GV11034@melbourne.sgi.com>
	 <200611231416.03387.netdev@axxeo.de>
	 <1164307020.3147.3.camel@laptopd505.fenrus.org>
	 <20061124005528.GF11034@melbourne.sgi.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 24 Nov 2006 08:52:38 +0100
Message-Id: <1164354759.3147.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-24 at 11:55 +1100, David Chinner wrote:
> On Thu, Nov 23, 2006 at 07:37:00PM +0100, Arjan van de Ven wrote:
> > On Thu, 2006-11-23 at 14:16 +0100, Ingo Oeser wrote:
> > > Hi there,
> > > 
> > > David Chinner schrieb:
> > > > If the softirqs were run on a different stack, then a lot of these
> > 
> > softirqs DO run on their own stack!
> 
> So they run on a separate stack for 4k stacks on x86?
> 
> They don't run on a separate stack for 8k stacks on x86 -
> Jesper's traces show that - so this may indicate an issue
> with the methodology used to generate the stack overflow
> traces inteh first place. i.e. if 4k stacks use a separate
> stack, then most of the reported overflows are spurious
> and would not normally occur on 4k stack systems..
> 
> Can you confirm this, Arjan?

yes there are separate stacks for softirq and hardirq context with 4K
stacks, but not for 8K stacks.


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

