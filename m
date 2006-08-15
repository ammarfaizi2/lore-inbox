Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWHOXLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWHOXLL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 19:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWHOXLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 19:11:11 -0400
Received: from 125.14.cm.sunflower.com ([24.124.14.125]:55531 "EHLO
	mail.atipa.com") by vger.kernel.org with ESMTP id S1750787AbWHOXLK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 19:11:10 -0400
Message-ID: <44E25496.20705@atipa.com>
Date: Tue, 15 Aug 2006 18:11:18 -0500
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: What determines which interrupts are shared under Linux?
References: <fa.xiop2gho7OdOydmzXzpUsR5ksXM@ifi.uio.no> <fa.1abHK6YDIfV51f77xhbkgnQpLwk@ifi.uio.no> <fa.UkMpPU+vkXMkIeBVGEpBG9C87M4@ifi.uio.no> <fa.9EHh5X478LQIXFY79H/n57rBfRE@ifi.uio.no> <fa.OQ0aZlfKc9NmI+ugRx8PT515Nks@ifi.uio.no> <44E252E9.40704@shaw.ca>
In-Reply-To: <44E252E9.40704@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Aug 2006 23:11:30.0234 (UTC) FILETIME=[245371A0:01C6C0C0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Roger Heflin wrote:
>> On the specific kernel that I have I appear to have both IDE and
>> sata_nv drivers, is there a way to force things to use sata_nv/libata
>> rather than the older ide driver for the NVIDIA sata controller?
> 
> Are you saying that drivers/ide is binding to the NVIDIA SATA 
> controller? That seems odd, at least in the Fedora Core 5 kernel 
> configuration, drivers/ide would never try to bind to the SATA 
> controllers for me, only sata_nv would. Maybe you have some 
> configuration option turned on to make drivers/ide grab anything that 
> looks like an IDE controller, which probably shouldn't be turned on.
> 

This kernel is a bit weird, ide is build into the kernel so it gets
first shot at anything it can manage.    I am not sure why the choices
were made to set it up the way it is setup, probably something historical.

I adjusted it so that IDE is a module and setup IDE to load after
sata_nv, so sata_nv is picking up the NVIDIA stuff, and it appears to
be alot better behaved.

                                   Roger
