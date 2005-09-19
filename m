Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVISXF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVISXF2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 19:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVISXF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 19:05:27 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:60565 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750721AbVISXF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 19:05:27 -0400
Date: Mon, 19 Sep 2005 16:04:43 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Thomas Gleixner <tglx@linutronix.de>
cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
In-Reply-To: <1127169849.24044.279.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.62.0509191601490.27528@schroedinger.engr.sgi.com>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de> 
 <Pine.LNX.4.62.0509191500040.27238@schroedinger.engr.sgi.com> 
 <1127168232.24044.265.camel@tglx.tec.linutronix.de> 
 <Pine.LNX.4.62.0509191521400.27238@schroedinger.engr.sgi.com>
 <1127169849.24044.279.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2005, Thomas Gleixner wrote:

> Hmm. I don't understand the argument line completely. 
> 
> 1. The kernel has to provide ugly mechanisms because a lot of
> applications implementations are doing the Wrong Thing ?

Lets skip the "wrong thing"... Or are you saying that glibc and all the 
apps are all wrong? 

Applications call gettimeofday for a variety of reasons. One is because it 
is widely available over different platformsn and application want to 
schedule things, need timestamps etc etc.

> > Many platforms can execute gettimeofday 
> > without having to enter the kernel.
> 
> Which ones ? How is this achieved with respect to all the time adjust,
> correction... code ?

IA64 f.e. has a special instruction that allows access to kernel user 
space without having to do a context switch.

