Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWEORNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWEORNe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWEORNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:13:34 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:4290 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964991AbWEORNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:13:33 -0400
Message-ID: <4468B6BA.3080405@garzik.org>
Date: Mon, 15 May 2006 13:13:30 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org> <1147713568.26686.79.camel@localhost.localdomain>
In-Reply-To: <1147713568.26686.79.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.0 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.0 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2006-05-15 at 13:00 -0400, Jeff Garzik wrote:
>> * PIO-based I/O is now IRQ-driven by default, rather than polled
>>   in a kernel thread.  The polling path will continue to exist for
>>   controllers that need it, and other special cases. (Albert Lee)
> 
> How will this be selected ? Passing ->irq = 0 ?

It is selected at runtime by passing a polling flag to ata_taskfile.

That flag, in turn can be set by anything -- driver flags (for 
controllers that always require polling), user variable requested at 
runtime, whatever.


> For ata_piix given you've destabilized it a bit would now be a good time
> to submit the patches to fix the timing, register scribble and incorrect
> ATAPI caching ?

Sure.

	Jeff


