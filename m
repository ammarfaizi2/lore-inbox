Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWARHiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWARHiP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbWARHiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:38:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38021 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030182AbWARHiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:38:14 -0500
Subject: Re: 2.6.15-mm4 failure on power5
From: Arjan van de Ven <arjan@infradead.org>
To: Nathan Lynch <ntl@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       anton@au1.ibm.com, linux-kernel@vger.kernel.org, michael@ellerman.id.au,
       linuxppc64-dev@ozlabs.org, serue@us.ibm.com, paulus@au1.ibm.com
In-Reply-To: <20060118072815.GR2846@localhost.localdomain>
References: <20060116063530.GB23399@sergelap.austin.ibm.com>
	 <200601180032.46867.michael@ellerman.id.au>
	 <20060117140050.GA13188@elte.hu>
	 <200601181119.39872.michael@ellerman.id.au>
	 <20060118033239.GA621@cs.umn.edu> <20060118063732.GA21003@elte.hu>
	 <20060117225304.4b6dd045.akpm@osdl.org>
	 <20060118072815.GR2846@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 08:38:01 +0100
Message-Id: <1137569882.3005.73.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 01:28 -0600, Nathan Lynch wrote:
> Andrew Morton wrote:
> > Ingo Molnar <mingo@elte.hu> wrote:
> > > - so buggy early bootup code which relies on interrupts being 
> > > off might be surprised by it.
> > 
> > I don't think it's necessarily buggy that bootup code needs interrupts
> > disabled.  It _is_ buggy that bootup code which needs interrupts disabled
> > is calling lock_cpu_hotplug().
> 
> I guess I don't understand -- why is it wrong for code that runs only
> in early early bootup, when there is only one process context, to use
> common code to e.g. register a hotplug cpu notifier? 

it's nasty to use things-that-can-sleep there though.
Even if that sleep is a bit theoretical, it still isn't nice.


