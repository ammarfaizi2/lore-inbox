Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbTAJM3G>; Fri, 10 Jan 2003 07:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbTAJM3G>; Fri, 10 Jan 2003 07:29:06 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:61841
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264920AbTAJM3F>; Fri, 10 Jan 2003 07:29:05 -0500
Subject: Re: spin_locks without smp.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030110114546.GN23814@holomorphy.com>
References: <Pine.LNX.4.51.0301101238560.6124@dns.toxicfilms.tv>
	 <20030110114546.GN23814@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042205036.28469.78.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 13:23:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 11:45, William Lee Irwin III wrote:
> On Fri, Jan 10, 2003 at 12:42:34PM +0100, Maciej Soltysiak wrote:
> > while browsing through the network drivers about the etherleak issue i
> > found that some drivers have:
> > #ifdef CONFIG_SMP
> > 	spin_lock_irqsave(...)
> > #endif
> > and some just:
> > 	spin_lock_irqsave(...)
> > or similar.
> > Which version should be practiced? i thought spinlocks are irrelevant
> > without SMP so we should use #ifdef to shorten the execution path.
> 
> Buggy on preempt. Remove the #ifdef

And render the driver unusable. Very clever. How about understanding *why*
something was done first 8)

