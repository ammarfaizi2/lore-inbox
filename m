Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbVGHNlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVGHNlt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 09:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVGHNls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 09:41:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34550 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262659AbVGHNkq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 09:40:46 -0400
Subject: Re: PREEMPT_RT and latency_trace
From: Daniel Walker <dwalker@mvista.com>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1120826951.6225.167.camel@ibiza.btsn.frna.bull.fr>
References: <1120826951.6225.167.camel@ibiza.btsn.frna.bull.fr>
Content-Type: text/plain
Date: Fri, 08 Jul 2005 06:40:07 -0700
Message-Id: <1120830007.19225.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-08 at 14:49 +0200, Serge Noiraud wrote:
> Hi,
> 
> I have a big dilemna on one machine :
> I run a task with RT priority which make a loop to mesure the system
> perturbation.
> It works well except on  one machine.
> On a multi-cpu, If I run the program on cpu 1, I get 23us. It's OK.
> If I run the same program on cpu 0, I get 17373us !

If it's not at RT priority 99 , then your application could be held off
until higher priority applications have run. 17373us is a pretty long
hold off time though .

Daniel

