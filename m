Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759714AbWLDV1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759714AbWLDV1i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 16:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759708AbWLDV1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 16:27:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50621 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759702AbWLDV1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 16:27:36 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Greg KH <gregkh@suse.de>
Cc: "Lu, Yinghai" <yinghai.lu@amd.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Stefan Reinauer <stepan@coresystems.de>,
       Peter Stuge <stuge-linuxbios@cdy.org>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 2/2] x86_64: earlyprintk usb debug device support.
References: <5986589C150B2F49A46483AC44C7BCA4907280@ssvlexmb2.amd.com>
	<20061204203308.GA30307@suse.de>
Date: Mon, 04 Dec 2006 14:26:52 -0700
In-Reply-To: <20061204203308.GA30307@suse.de> (Greg KH's message of "Mon, 4
	Dec 2006 12:33:08 -0800")
Message-ID: <m1bqmj8i8z.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> writes:

> On Mon, Dec 04, 2006 at 12:18:30PM -0800, Lu, Yinghai wrote:
>> -----Original Message-----
>> From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 
>> 
>> >arch/x86_64/kernel/early_printk.c |  574
>> +++++++++++++++++++++++++++++++++++++
>> > drivers/usb/host/ehci.h           |    8 +
>> > include/asm-x86_64/fixmap.h       |    1 
>> 
>> Can you separate usbdebug handle out from early_printk? 
>
> Yeah, at least tear it out of x86-64, so those of us stuck on different
> platforms can use this :)
>
> Other than that minor issue, this looks great.  I don't have a x86-64
> box set up here at the moment, so I can't test it, but it looks
> acceptable at first glance.

Makes sense.  I'm curious now what architecture do you have?

Anyway next time I touch this the project will be how to integrate
this into the kernel cleanly.  This round was to figure out how
to get some working code.

If someone beats me to the punch on generalizing this code I won't
mind.

The first pass was a success.  And the performance is reasonable
assuming you don't plug the end you are watching into a usb1 only
port.

Given that I didn't really know anything about usb a week ago I think
I did pretty well :)

Eric
