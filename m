Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTKJMPM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 07:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbTKJMPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 07:15:12 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:58834 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263376AbTKJMPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 07:15:08 -0500
Message-ID: <3FAF82D2.2050004@pacbell.net>
Date: Mon, 10 Nov 2003 04:21:38 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, colin@colino.net
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6 : cdc_acm problem
References: <3FAE77B7.8040901@pacbell.net> <20031109225027.GA2425@kroah.com>
In-Reply-To: <20031109225027.GA2425@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>The problem is that cdc_acm calls a "softirq-only" routine
>>in a hardirq context.  See this patch:
>>
>>http://marc.theaimsgroup.com/?l=linux-usb-devel&m=106764585001038&w=2
>>
>>It's not clear that'll make it into 2.6.0-final.
> 
> 
> I've not planned to submit it for 2.6.0 as it's a relativly big change,
> and I don't have the hardware to test it out.  Anyone have any other
> thoughts about this?

Doesn't seem big to me.  It could be shrunk a smidgeon, but
that's the version that's gotten the positive test results.

The folk who have this kind of hardware have reported this
happening for quite a few months now, and it does seem to
fill up log buffers with catastrophic-seeming stack traces.

Colin, does it fix your problem?  Can you eke more than
twenty minutes from your laptop battery now?  :)

- Dave

