Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbWGZEla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbWGZEla (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 00:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbWGZEla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 00:41:30 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:3726 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030380AbWGZEl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 00:41:29 -0400
Message-ID: <44C6F26C.2080203@garzik.org>
Date: Wed, 26 Jul 2006 00:41:16 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Jesper Juhl <jesper.juhl@gmail.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Andrew Morton <akpm@osdl.org>, Mike Miller <mike.miller@hp.com>,
       iss_storagedev@hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CCISS: Don't print driver version until we actually	find
 a device
References: <200607251636.42765.bjorn.helgaas@hp.com>	 <9a8748490607251543w7496864dtd587abc45b93394a@mail.gmail.com> <1153867675.8932.68.camel@laptopd505.fenrus.org>
In-Reply-To: <1153867675.8932.68.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2006-07-26 at 00:43 +0200, Jesper Juhl wrote:
>> On 26/07/06, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>>> If we don't find any devices, we shouldn't print anything.
>>>
>> I disagree.
>> I find it quite nice to be able to see that the driver loaded even if
>> it finds nothing. At least then when there's a problem, I can quickly
>> see that at least it is not because I didn't forget to load the
>> driver, it's something else. Saves time since I can start looking for
>> reasons why the driver didn't find anything without first spending
>> additional time checking if I failed to cause it to load for some
>> reason.
> 
> I'll add a second reason: it is a REALLY nice property to be able to see
> which driver is started last in case of a crash/hang, so that the guilty
> party is more obvious..

OTOH, it is not a property that scales well at all.

When you build extra drivers into the kernel, or distros load drivers 
you don't need (_every_ distro does this), you wind up with a bunch of 
version strings for drivers for hardware you don't have.

	Jeff



