Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWERP0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWERP0I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWERP0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:26:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48197 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750891AbWERP0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:26:06 -0400
Date: Thu, 18 May 2006 11:26:06 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH -rt 2/2] arm update
In-reply-to: <1147962452.17117.25.camel@c-67-180-134-207.hsd1.ca.comcast.net>
X-X-Sender: nico@localhost.localdomain
To: Daniel Walker <dwalker@mvista.com>
Cc: mingo@elte.hu, tglx@linutronix.de, lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0605181115490.18071@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <200605141557.k4EFv5Sd004979@dwalker1.mvista.com>
 <Pine.LNX.4.64.0605180947180.18071@localhost.localdomain>
 <1147962452.17117.25.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2006, Daniel Walker wrote:

> On Thu, 2006-05-18 at 09:53 -0400, Nicolas Pitre wrote:
> > >  - adds a new NR_syscalls macro, converts the old one into __NR_syscalls for
> > >    calculating the table padding .
> > 
> > Why?
> > 
> 
> > And no NR_syscalls definition should be present in asm-arm/unistd.h at 
> > all.
> > 
> 
> Right , it's not normally needed .. In RT we size an array by
> NR_syscalls for latency tracing (kernel/latency.c) . So we need some way
> to determine the the number of syscalls .. Do you know of another way we
> can get that number of syscalls on ARM ? 

Just do the same as in entry-common.S: define the CALL() macro and 
include calls.S.

Or declare a global variable in entry-common.S and assign it the 
NR_syscalls value.


Nicolas
