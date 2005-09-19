Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932636AbVISXMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbVISXMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 19:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbVISXMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 19:12:15 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:10966
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932636AbVISXMP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 19:12:15 -0400
Subject: Re: [ANNOUNCE] ktimers subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, paulmck@us.ibm.com
In-Reply-To: <Pine.LNX.4.62.0509191601490.27528@schroedinger.engr.sgi.com>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
	 <Pine.LNX.4.62.0509191500040.27238@schroedinger.engr.sgi.com>
	 <1127168232.24044.265.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.62.0509191521400.27238@schroedinger.engr.sgi.com>
	 <1127169849.24044.279.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.62.0509191601490.27528@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 20 Sep 2005 01:12:22 +0200
Message-Id: <1127171542.24044.301.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 16:04 -0700, Christoph Lameter wrote:
> On Tue, 20 Sep 2005, Thomas Gleixner wrote:
> 
> > Hmm. I don't understand the argument line completely. 
> > 
> > 1. The kernel has to provide ugly mechanisms because a lot of
> > applications implementations are doing the Wrong Thing ?
> 
> Lets skip the "wrong thing"... Or are you saying that glibc and all the 
> apps are all wrong? 
> 
> Applications call gettimeofday for a variety of reasons. One is because it 
> is widely available over different platformsn and application want to 
> schedule things, need timestamps etc etc.

Accepted. But I still doubt that the number of calls to gettimeofday is
in anyway justified. The question I'm asking if it is really worth a
long and epic discussion about a single add instruction ?


> > > Many platforms can execute gettimeofday 
> > > without having to enter the kernel.
> > 
> > Which ones ? How is this achieved with respect to all the time adjust,
> > correction... code ?
> 
> IA64 f.e. has a special instruction that allows access to kernel user 
> space without having to do a context switch.

Ok, was not aware of that and John kindly clarified this already. 

tglx


