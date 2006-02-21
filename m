Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161388AbWBUGRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161388AbWBUGRy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161391AbWBUGRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:17:54 -0500
Received: from smtp.net4india.com ([202.71.129.73]:1194 "EHLO
	smx3.net4india.com") by vger.kernel.org with ESMTP id S1161388AbWBUGRx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:17:53 -0500
Message-ID: <43FAB0CB.6010506@designergraphix.com>
Date: Tue, 21 Feb 2006 11:48:51 +0530
From: Kaiwan N Billimoria <kaiwan@designergraphix.com>
Organization: Designer Graphix
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: Greg KH <greg@kroah.com>, Philippe Seewer <philippe.seewer@bfh.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: Stuck creating sysfs hooks for a driver..
References: <43F2DE34.60101@designergraphix.com>	<20060215221301.GA25941@kroah.com>	<43F46319.9090400@designergraphix.com> <20060219142311.ba0f8a38.khali@linux-fr.org>
In-Reply-To: <20060219142311.ba0f8a38.khali@linux-fr.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:

>Hi Kaiwan,
>
>You must stay away from writing a driver for the board itself. What you
>must write is in fact two different drivers:
>
>1* A driver for the SPI interface of your board (basically a parallel
>port <-> SPI bridge). This driver will expose the device as an SPI bus
>to the rest of the kernel. This driver doesn't care about what chip is
>plugged on it.
>
>2* A driver for the LM70 temperature sensor chip, which doesn't care
>about the chip location. This driver will use generic SPI commands as
>offered by the spi kernel interface.
>
>  
>
Ok, i see your point..

>It's really not a matter of how many features a chip has. Look at the
>lm75 or w83l785ts driver, you'll see they have very few features as
>well. It's a matter of having a common standard for exporting the
>values to user-space, so that the same library or application can
>handle all sources with minimum effort.
>
>  
>
Yes, again..
I shall start looking into these aspects & workin on it in the coming 
week..am up to my ears in other stuff right now..
though how exactly i don;t know now :) ; will certainly require your 
(and others) help on this..

>Thanks,
>  
>
Thank you, your long reply was very enlightening;
Kaiwan.

