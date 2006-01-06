Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWAFNi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWAFNi3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 08:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWAFNi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 08:38:29 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:1416 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932387AbWAFNi2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 08:38:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VFUeFHZ410FURvUgLcCamgu7SkjNfL0PBJE7KFxq/YE9c8QK1+LHlGIOOWDEqH9kreRPrXghgp1H35EX3xRvt/AFU6B/sBqC5Nhr0OMvsyY9ofoYPnPSnPznvBHsDTmfSjiODBcclGJU+xxdRt/0SQHDyGkcb8FwjdKd79UklPI=
Message-ID: <a070070d0601060538m487d099ax@mail.gmail.com>
Date: Fri, 6 Jan 2006 14:38:27 +0100
From: Cornelia Huck <cornelia.huck@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com,
       Greg K-H <greg@kroah.com>
Subject: Re: [CFT 1/29] Add bus_type probe, remove, shutdown methods.
In-Reply-To: <20060106114822.GA11071@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060105142951.13.01@flint.arm.linux.org.uk>
	 <20060106114822.GA11071@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/1/6, Russell King <rmk+lkml@arm.linux.org.uk>:

> Could the s390 folk also look at what's required for ccw_driver and
> css_driver please?

ccw_driver should be easy: Just don't set ->probe and ->remove in
ccw_driver_register() and move ccw_device_remove() and
ccw_device_probe() to the bus type.

css_driver needs some wrapper functions added, since
io_subchannel_{probe,remove,shutdown} are really specific to I/O
subchannels.

I'll see what I can put together when I'm back at work next week.

Cornelia
