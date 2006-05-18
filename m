Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWERO1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWERO1f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 10:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWERO1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 10:27:35 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:49398 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751092AbWERO1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 10:27:34 -0400
Subject: Re: [PATCH -rt 2/2] arm update
From: Daniel Walker <dwalker@mvista.com>
To: Nicolas Pitre <nico@cam.org>
Cc: mingo@elte.hu, tglx@linutronix.de, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605180947180.18071@localhost.localdomain>
References: <200605141557.k4EFv5Sd004979@dwalker1.mvista.com>
	 <Pine.LNX.4.64.0605180947180.18071@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 18 May 2006 07:27:31 -0700
Message-Id: <1147962452.17117.25.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-18 at 09:53 -0400, Nicolas Pitre wrote:
> >  - adds a new NR_syscalls macro, converts the old one into __NR_syscalls for
> >    calculating the table padding .
> 
> Why?
> 

> And no NR_syscalls definition should be present in asm-arm/unistd.h at 
> all.
> 

Right , it's not normally needed .. In RT we size an array by
NR_syscalls for latency tracing (kernel/latency.c) . So we need some way
to determine the the number of syscalls .. Do you know of another way we
can get that number of syscalls on ARM ? 

Daniel

