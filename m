Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWKGMDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWKGMDA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 07:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754212AbWKGMDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 07:03:00 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:20409 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1754210AbWKGMC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 07:02:59 -0500
Message-ID: <455075E9.4080202@garzik.org>
Date: Tue, 07 Nov 2006 07:02:49 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Nate Diller <nate.diller@gmail.com>
CC: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       LKML <linux-kernel@vger.kernel.org>,
       Oleg Verych <olecom@flower.upol.cz>, Pavel Machek <pavel@ucw.cz>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
References: <1154985aa0591036@2ka.mipt.ru> <1162380963981@2ka.mipt.ru>	 <20061101130614.GB7195@atrey.karlin.mff.cuni.cz>	 <20061101132506.GA6433@2ka.mipt.ru> <20061101160551.GA2598@elf.ucw.cz>	 <20061101162403.GA29783@2ka.mipt.ru>	 <slrnekhpbr.2j1.olecom@flower.upol.cz>	 <20061101185745.GA12440@2ka.mipt.ru> <5c49b0ed0611011812w8813df3p830e44b6e87f09f4@mail.gmail.com>
In-Reply-To: <5c49b0ed0611011812w8813df3p830e44b6e87f09f4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nate Diller wrote:
> Indesiciveness has certainly been an issue here, but I remember akpm
> and Ulrich both giving concrete suggestions.  I was particularly
> interested in Andrew's request to explain and justify the differences
> between kevent and BSD's kqueue interface.  Was there a discussion
> that I missed?  I am very interested to see your work on this
> mechanism merged, because you've clearly emphasized performance and
> shown impressive results.  But it seems like we lose out on a lot by
> throwing out all the applications that already use kqueue.


kqueue looks pretty nice, the filter/note models in particular.  I don't 
see anything about ring buffers though.

I also wonder about the asynchronous event side (send), not just the 
event reception side.

	Jeff


