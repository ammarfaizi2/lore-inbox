Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264781AbSJVRSM>; Tue, 22 Oct 2002 13:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264787AbSJVRSM>; Tue, 22 Oct 2002 13:18:12 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:50956
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264781AbSJVRSL>; Tue, 22 Oct 2002 13:18:11 -0400
Subject: Re: [PATCH] NMI request/release
From: Robert Love <rml@tech9.net>
To: Corey Minyard <cminyard@mvista.com>
Cc: John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3DB54C53.9010603@mvista.com>
References: <3DB4AABF.9020400@mvista.com>
	<20021022021005.GA39792@compsoc.man.ac.uk> <3DB4B8A7.5060807@mvista.com>
	<20021022025346.GC41678@compsoc.man.ac.uk>  <3DB54C53.9010603@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 13:23:47 -0400
Message-Id: <1035307430.1008.1476.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 09:02, Corey Minyard wrote:

> I looked, and the rcu code relys on turning off interrupts to avoid 
> preemption.  So it won't work.

At least on the variant of RCU that is in 2.5, the RCU code does the
read side by disabling preemption.  Nothing else.

The write side is the same with or without preemption - wait until all
readers are quiescent, change the copy, etc.

But anyhow, disabling interrupts should not affect NMIs, no?

	Robert Love

