Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965249AbWIVWnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbWIVWnv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbWIVWnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:43:51 -0400
Received: from gw.goop.org ([64.81.55.164]:13509 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965241AbWIVWnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:43:50 -0400
Message-ID: <45146725.4070109@goop.org>
Date: Fri, 22 Sep 2006 15:43:49 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
References: <1158925861.26261.3.camel@localhost.localdomain> <1158925997.26261.6.camel@localhost.localdomain> <1158926106.26261.8.camel@localhost.localdomain> <1158926215.26261.11.camel@localhost.localdomain> <1158926308.26261.14.camel@localhost.localdomain> <1158926386.26261.17.camel@localhost.localdomain> <20060922123215.GA98728@muc.de>
In-Reply-To: <20060922123215.GA98728@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> BTW I changed my copy sorry. I redid the early PDA support
> to not be in assembler.

I went to the trouble of making the PDA completely set up before any C 
code ran.  Did you undo that?

Andrew mentioned that people have various hacks which hook into mcount, 
and want to use current/smp_processor_id, which means that that they 
have to work from the first function prologue.
It also simplifies things to get all that set up ASAP so there's no 
bootstrap dependency problem.

    J
