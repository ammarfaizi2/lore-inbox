Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbULKOxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbULKOxD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 09:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbULKOxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 09:53:03 -0500
Received: from fsmlabs.com ([168.103.115.128]:36544 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261942AbULKOxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 09:53:00 -0500
Date: Sat, 11 Dec 2004 07:52:34 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: George Anzinger <george@mvista.com>
cc: Lee Revell <rlrevell@joe-job.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, Manfred Spraul <manfred@colorfullife.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
In-Reply-To: <41BA698E.8000603@mvista.com>
Message-ID: <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com>
References: <41B8E6F1.4070007@mvista.com> <20041210043102.GC4161@in.ibm.com>
  <41B9FC3F.50601@mvista.com>  <20041210204003.GC4073@in.ibm.com>
 <1102711532.29919.35.camel@krustophenia.net> <41BA0ECF.1060203@mvista.com>
 <Pine.LNX.4.61.0412101558240.24986@montezuma.fsmlabs.com> <41BA59F6.5010309@mvista.com>
 <Pine.LNX.4.61.0412101943260.1101@montezuma.fsmlabs.com> <41BA698E.8000603@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2004, George Anzinger wrote:

> That is ok.  Either we have interrupts off and no softirqs are pending and we
> proceed to the "hlt" (where the interrupt will be taken), or softirqs are
> pending, we turn interrupts on, do the softirq, turn interrupts off and try
> again.  Unless some tasklet (RCU?) never "gives up" or we will exit the while
> with interrupts off and move on to the "hlt".  Or did I miss something?

But the point is that you cannot execute hlt with interrupts disabled.

