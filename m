Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbVFLPrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbVFLPrL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 11:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVFLPrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 11:47:11 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:48112 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S262626AbVFLPrI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 11:47:08 -0400
Date: Sun, 12 Jun 2005 08:46:55 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
cc: Ingo Molnar <mingo@elte.hu>, Esben Nielsen <simlo@phys.au.dk>,
       Linux Kernel <linux-kernel@vger.kernel.org>, sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <Pine.LNX.4.61.0506120926331.15684@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.10.10506120846040.7591-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I was just trying to get an idea of the possible slow down if any, and for
x86 I'm convinced that it's not a slowdown..

Daniel

On Sun, 12 Jun 2005, Zwane Mwaikambo wrote:

> On Sat, 11 Jun 2005, Daniel Walker wrote:
> 
> > Interesting .. So "cli" takes 7 cycles , "sti" takes 7 cycles. The current 
> > method does "lea" which takes 1 cycle, and "or" which takes 1 cycle. I'm 
> > not sure if there is any function call overhead .. So the soft replacment 
> > of cli/sti is 70% faster on a per instruction level .. So it's at least 
> > not any slower .. Does everyone agree on that?
> 
> Well you also have to take into account the memory access, so it's not 
> always that straightforward.
> 
> 	Zwane
> 
> 

