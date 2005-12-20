Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbVLTWyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbVLTWyE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbVLTWyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:54:04 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:46483 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1750923AbVLTWyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:54:02 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17320.35736.89250.390950@gargle.gargle.HOWL>
Date: Wed, 21 Dec 2005 01:54:16 +0300
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: "Mike Snitzer" <snitzer@gmail.com>, "Adrian Bunk" <bunk@stusta.de>,
       "Mark Lord" <lkml@rtr.ca>, "J.A. Magallon" <jamagallon@able.es>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>, <nel@vger.kernel.org>,
       <mpm@selenic.com>
Subject: Re: About 4k kernel stack size....
Newsgroups: gmane.linux.kernel
In-Reply-To: <Pine.LNX.4.61.0512201202090.27692@chaos.analogic.com>
References: <20051218231401.6ded8de2@werewolf.auna.net>
	<43A77205.2040306@rtr.ca>
	<20051220133729.GC6789@stusta.de>
	<170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com>
	<46578.10.10.10.28.1135094132.squirrel@linux1>
	<Pine.LNX.4.61.0512201202090.27692@chaos.analogic.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os \(Dick Johnson\) writes:
 > 

[...]

 > See, isn't rule-making fun? This whole 4k stack-
 > thing is really dumb. Other operating systems
 > use paged virtual memory for stacks, except
 > for the interrupt stack. If Linux used paged
 > virtual memory for stacks, 

... then spin-locks couldn't be held across function calls.

 >                            the pages would not
 > have to be contiguous so dynamic stack allocation
 > would practically never fail. But Linux doesn't
 > use paged virtual memory for stacks. So, there
 > needs to be some rule to control the amount
 > of kernel stack allocated to each task when it
 > executes a system call.
 > 
 > This means, in the limit, that there are two
 > possibilities:
 > 
 > (1)	Implement paged virtual memory for stack.

As an exercise: subscribe to NT kernel development mailing list, and see
the fun they have when page-in code trips over paged out kernel text
page. As a rule, even code cannot pageable without very involving and
fragile analysis. Not to say about stack.

Nikita.
