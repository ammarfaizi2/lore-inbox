Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbTJIRwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 13:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTJIRwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 13:52:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15249 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262345AbTJIRwT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 13:52:19 -0400
Message-ID: <3F85A044.5040109@pobox.com>
Date: Thu, 09 Oct 2003 13:52:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Manfred Spraul <manfred@colorfullife.com>,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
References: <Pine.LNX.4.44.0310091029070.22114-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0310091029070.22114-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Thu, 9 Oct 2003, Jeff Garzik wrote:
> 
>>If you can't stop the NIC hardware from generating interrupts, that's a 
>>driver bug.
> 
> 
> No it's not.
> 
> Think shared interrupts here.

I was being specific in what I said :)

Sure, shared interrupts can still call a driver's handler.

But if the driver doesn't stop _its own_ hardware from generating 
interrupts, you've got screaming interrupts the minute it issues 
free_irq and signals it doesn't care anymore.  The driver damn well 
better be able to stop the _NIC hardware_ from generating interrupts :)

	Jeff



