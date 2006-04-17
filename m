Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWDQPBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWDQPBj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 11:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWDQPBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 11:01:39 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:42395 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751065AbWDQPBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 11:01:39 -0400
Subject: Re: irqbalance mandatory on SMP kernels?
From: Lee Revell <rlrevell@joe-job.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org,
       Randy Dunlap <rddunlap@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andre Hedrick <andre@linux-ide.org>,
       Manfred Spraul <manfreds@colorfullife.com>, Alan Cox <alan@redhat.com>,
       Kamal Deen <kamal@kdeen.net>
In-Reply-To: <4443A6D9.6040706@mbligh.org>
References: <Pine.LNX.4.44.0604171438490.14894-100000@hubble.stokkie.net>
	 <4443A6D9.6040706@mbligh.org>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 11:01:33 -0400
Message-Id: <1145286094.16138.22.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-17 at 07:31 -0700, Martin J. Bligh wrote:
> Robert M. Stockmann wrote:
> > Hi,
> > 
> > I noticed that the latest editions of RedHat EL 4.3 and direct
> > descendants today need a program called irqbalance to activate
> > true SMP IRQ load balancing for your machine's hardware.
> > 
> > If one boots a SMP kernel (2.4.xx or 2.6.xx) kernel on a machine
> > which either has 2 or more physical CPU's (also dual-core CPU's) 
> > , and one does not start up the irqbalance util from the
> > kernel-utils package ( see e.g. 
> 
> There is an in-kernel IRQ balancer. Redhat just choose to turn it
> off, and do it in userspace instead. You can re-enable it if you
> compile your own kernel.

Round-robin IRQ balancing is inefficient anyway.  You'd get better cache
utilization letting one CPU take them all.

Lee

