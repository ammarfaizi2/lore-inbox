Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVFLEcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVFLEcc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 00:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVFLEcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 00:32:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:65275 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261870AbVFLEca
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 00:32:30 -0400
Date: Sat, 11 Jun 2005 21:32:09 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Karim Yaghmour <karim@opersys.com>
cc: Ingo Molnar <mingo@elte.hu>, Esben Nielsen <simlo@phys.au.dk>,
       <linux-kernel@vger.kernel.org>, <sdietrich@mvista.com>,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <42ABBA95.3050602@opersys.com>
Message-ID: <Pine.LNX.4.44.0506112126580.24837-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2005, Karim Yaghmour wrote:

> 
> Daniel Walker wrote:
> > Interesting .. So "cli" takes 7 cycles , "sti" takes 7 cycles. The current 
> > method does "lea" which takes 1 cycle, and "or" which takes 1 cycle. I'm 
> > not sure if there is any function call overhead .. So the soft replacment 
> > of cli/sti is 70% faster on a per instruction level .. So it's at least 
> > not any slower .. Does everyone agree on that?
> 
> The proof is in the pudding: it's not for nothing that the results
> we published earlier show that the mere enabling of Adeos actually
> increases Linux's performance under heavy load.

Why do you think that is? Is ADEOS optimized for specific machine 
configurations?

> That being said, I'm not sure exactly why you guys are reinventing the
> wheel. Adeos already does this soft-cli/sti stuff for you, it's been
> available for a few years already, tested, and ported to a number of
> architectures, and is generalized, why not just adopt it? After all,
> like I've been saying for some time, it isn't mutually exclusive with
> PREEMPT_RT.

It doesn't seem like one could really merge the two. From what I've read 
, it seem like ADEOS is something completly indepedent . It would be linux 
and ADEOS , but never just linux . 

Daniel

