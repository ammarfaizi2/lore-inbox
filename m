Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVFCIeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVFCIeq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 04:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVFCIeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 04:34:46 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:29926 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261180AbVFCIeo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 04:34:44 -0400
References: <1117291619.9665.6.camel@localhost>
            <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org>
            <84144f0205052911202863ecd5@mail.gmail.com>
            <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org>
            <1117399764.9619.12.camel@localhost>
            <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org>
            <1117466611.9323.6.camel@localhost>
            <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org>
            <courier.429C05C1.00005CC5@courier.cs.helsinki.fi>
            <20050601073544.GA21384@elte.hu>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: "Pekka J Enberg" <penberg@cs.helsinki.fi>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Pekka Enberg <penberg@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TASK_NONINTERACTIVE (was: Machine Freezes while Running Crossover Office)
Date: Fri, 03 Jun 2005 11:34:43 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42A01623.00005D5C@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, 

On Wed, 2005-06-01 at 09:35 +0200, Ingo Molnar wrote:
> > Pekka, could you check whether the patch below solves your Wine problem 
> > (without hurting interactivity otherwise)?

On Wed, 2005-06-01 at 13:26 +0300, Pekka J Enberg wrote:
> I have been running a patched 2.6.12-rc5 for over an hour now with no 
> interactivity problems whatsoever (although on a different laptop). I am 
> using Eclipse, Tomcat, XMMS, Firefox, and Evolution. From my POV, this is 
> 2.6.12 and -stable material. Thanks! 

Unfortunately I have to take that comment back. Under heavy CPU load [*], 
the interactivity is worse than with 2.6.11.10. XMMS skips and the X mouse 
cursor is all jerky. A better short-term fix would be to reduce pipe
buffer size to 4 KB. 

[*] Running Eclipse and Tomcat while exercising Selenium JavaScript tests
   in Firefox. In other words, a JavaScript bot going through a Java web
   application. 

                    Pekka 

