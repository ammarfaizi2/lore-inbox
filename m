Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTD2JJI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 05:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTD2JJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 05:09:08 -0400
Received: from main.gmane.org ([80.91.224.249]:31669 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261292AbTD2JJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 05:09:07 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Thomas Backlund <tmb@iki.fi>
Subject: Re: 2.4.21-rc1-ac2 Promise IDE DMA won't work
Date: Tue, 29 Apr 2003 12:21:19 +0300
Message-ID: <b8lg4a$dhk$1@main.gmane.org>
References: <Pine.LNX.4.10.10304281855540.20264-100000@master.linux-ide.org> <200304282234.59745.tabris@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tabris wrote:

> On Monday 28 April 2003 09:58 pm, Andre Hedrick wrote:
>> NO ATAPI DMA!
>>
>> I will not write the driver core to attempt to support the various
>> combinations.  The ATAPI DMA engine space is used support 48bit.
>> Use the onboard controller for ATAPI.
>> Andre Hedrick
>> LAD Storage Consulting Group
> 
> Can I object that it came built onto the board? okok... i'll take that
> as a no for now...
> 
> Tho i'm still not quite sure how it makes a diff to be honest, unless
> you mean that the Promise and HPT will never be supported for DMA?
> 
> and the only other thing i should say is that altho i'm not exactly a
> n00b, the average user WILL expect it to work.
> 
> can i expect this to be fixed by 2.6? (yeah, i know... 2.4-ac-ide code
> is similar to 2.5-ide code)
> --
> tabris

The point is that you should put your ATAPI device (in this case the cd-rom)
on the VIA controllers, and place the hdd's on the promise controller,
since dma is supported for hdd's...

This is also their intended primary functions by the manufacturers...,
for example the HPT370 controller with bios version >1.1.x.xxx does
not have ATAPI support (atleast officially, I haven't tried it)


Thomas



