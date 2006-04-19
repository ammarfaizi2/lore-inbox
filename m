Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWDSOqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWDSOqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 10:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWDSOqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 10:46:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1760 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750807AbWDSOqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 10:46:05 -0400
Subject: Re: irqbalance mandatory on SMP kernels?
From: Arjan van de Ven <arjan@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Lee Revell <rlrevell@joe-job.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org,
       Randy Dunlap <rddunlap@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andre Hedrick <andre@linux-ide.org>,
       Manfred Spraul <manfreds@colorfullife.com>, Alan Cox <alan@redhat.com>,
       Kamal Deen <kamal@kdeen.net>
In-Reply-To: <20060419143815.GH706@thunk.org>
References: <Pine.LNX.4.44.0604171438490.14894-100000@hubble.stokkie.net>
	 <4443A6D9.6040706@mbligh.org> <1145286094.16138.22.camel@mindpipe>
	 <20060418163539.GB10933@thunk.org>
	 <1145384357.2976.39.camel@laptopd505.fenrus.org>
	 <20060419124210.GB24807@harddisk-recovery.com>
	 <1145456594.3085.42.camel@laptopd505.fenrus.org>
	 <20060419143815.GH706@thunk.org>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 16:45:36 +0200
Message-Id: <1145457937.3085.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 10:38 -0400, Theodore Ts'o wrote:
> On Wed, Apr 19, 2006 at 04:23:14PM +0200, Arjan van de Ven wrote:
> > as long as the irqs are spread the apaches will (on average) follow your
> > irq to the right cpu. Only if you put both irqs on the same cpu you have
> > an issue
> 
> Maybe I'm being stupid but I don't see how the Apache's will follow
> the IRQ's to the right CPU.  I agree this would be a good thing to do,
> but how does the scheduler accomplish this?

iirc this part of the kernel uses wake_up_sync() and such, which tend to
pull the apache to the cpu (if it's idle) in the long term
(or it ought to; at one point it did)

