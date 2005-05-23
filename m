Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVEWJoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVEWJoO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 05:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVEWJoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 05:44:14 -0400
Received: from odin2.bull.net ([192.90.70.84]:36797 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261872AbVEWJoJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 05:44:09 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, dwalker@mvista.com,
       Joe King <atom_bomb@rocketmail.com>, ganzinger@mvista.com,
       Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20050523082637.GA15696@elte.hu>
References: <20050523082637.GA15696@elte.hu>
Content-Type: text/plain; charset=iso-8859-15
Organization: BTS
Message-Id: <1116840848.1498.4.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Mon, 23 May 2005 11:34:09 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 23/05/2005 à 10:26, Ingo Molnar a écrit :
> i have released the -V0.7.47-06 Real-Time Preemption patch, which can be 
> downloaded from the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/

Cannot generate correctly for i686 :

--- linux/Makefile.orig
+++ linux/Makefile

...

@@ -190,8 +190,8 @@ SUBARCH := $(shell uname -m | sed -e s/i
 # Default value for CROSS_COMPILE is not to prefix executables
 # Note: Some architectures assign CROSS_COMPILE in their
arch/*/Makefile

-ARCH       ?= $(SUBARCH)
-CROSS_COMPILE  ?=
+ARCH = x86_64                             <====
+CROSS_COMPILE = x86_64-linux-             <====

 # Architecture as present in compile.h
 UTS_MACHINE := $(ARCH)

...


