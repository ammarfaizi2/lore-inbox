Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbULKCqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbULKCqJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 21:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbULKCqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 21:46:08 -0500
Received: from fsmlabs.com ([168.103.115.128]:36255 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261915AbULKCqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 21:46:05 -0500
Date: Fri, 10 Dec 2004 19:45:32 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: George Anzinger <george@mvista.com>
cc: Lee Revell <rlrevell@joe-job.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, Manfred Spraul <manfred@colorfullife.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
In-Reply-To: <41BA59F6.5010309@mvista.com>
Message-ID: <Pine.LNX.4.61.0412101943260.1101@montezuma.fsmlabs.com>
References: <41B8E6F1.4070007@mvista.com> <20041210043102.GC4161@in.ibm.com>
  <41B9FC3F.50601@mvista.com>  <20041210204003.GC4073@in.ibm.com>
 <1102711532.29919.35.camel@krustophenia.net> <41BA0ECF.1060203@mvista.com>
 <Pine.LNX.4.61.0412101558240.24986@montezuma.fsmlabs.com> <41BA59F6.5010309@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2004, George Anzinger wrote:

> > But that's a deadlock and if you enable interrupts you race.
> 
> Again, I remind you we are in the idle task.  Nothing more important to do.
> Or do you mean that softirq_pending() will NEVER return false?
> 
> The other question is: "Is useful work being done?"

We're in the idle task but obviously interrupts (such as network) are 
still coming in. So you may take an interrupt after your while 
(softirq_pending()) loop has exited.
