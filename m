Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161232AbWJRQpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161232AbWJRQpR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161233AbWJRQpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:45:16 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:56073 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1161232AbWJRQpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:45:14 -0400
Date: Wed, 18 Oct 2006 17:45:12 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andi Kleen <ak@suse.de>
cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 Time: Avoid PIT SMP lockups
In-Reply-To: <p73y7rdbndp.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.64N.0610181739550.28841@blysk.ds.pg.gda.pl>
References: <1160596462.5973.12.camel@localhost.localdomain>
 <20061011142646.eb41fac3.akpm@osdl.org> <Pine.LNX.4.64N.0610181650001.28841@blysk.ds.pg.gda.pl>
 <p73y7rdbndp.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006, Andi Kleen wrote:

> It wouldn't work on dual core laptop chipsets which support C3 and where
> the APIC timer stops during C3.
> 
> I had a apicrunsmaintimer option for some time on x86-64 but it broke
> on a few other non laptop machines for unknown reasons too, so I cannot 
> really recommend it.

 So they managed to break it too?  Oh well...

 If you look at early APIC documentation, then you'll see how the APIC 
timers were recommended to be the only source of the clock tick for SMP 
systems in favour to the old-fashioned PIT.  Now, how can it be used if it 
does not run all the time?...

  Maciej
