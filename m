Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751746AbWIYBHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbWIYBHV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 21:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWIYBHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 21:07:21 -0400
Received: from gw.goop.org ([64.81.55.164]:63674 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751746AbWIYBHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 21:07:20 -0400
Message-ID: <45172BCE.4010708@goop.org>
Date: Sun, 24 Sep 2006 18:07:26 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
References: <1158925861.26261.3.camel@localhost.localdomain> <1158925997.26261.6.camel@localhost.localdomain> <1158926106.26261.8.camel@localhost.localdomain> <1158926215.26261.11.camel@localhost.localdomain> <1158926308.26261.14.camel@localhost.localdomain> <1158926386.26261.17.camel@localhost.localdomain> <4514663E.5050707@goop.org> <20060923081337.GA10534@muc.de>
In-Reply-To: <20060923081337.GA10534@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> I managed to get all this done in head.S before going into C code; is 
>> that not still possible?  Or is there a later patch to do this.
>>     
>
> Why write in assembler what you can write in C?
>   
This stuff is very basic, and you could consider it as being part of the 
kernel's C runtime model, and therefore can be expected to be available 
everywhere.  In particular, the use of current is so prevalent that you 
really can't call anything without having the PDA set up.

    J
