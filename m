Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264068AbUCZP7R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 10:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264069AbUCZP7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 10:59:17 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:35016 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264068AbUCZP7Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 10:59:16 -0500
Message-ID: <4064530C.5030308@pacbell.net>
Date: Fri, 26 Mar 2004 07:58:04 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Robert Schwebel <robert@schwebel.de>
CC: bert hubert <ahu@ds9a.nl>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] RNDIS Gadget Driver
References: <20040325221145.GJ10711@pengutronix.de> <20040326115947.GA22185@outpost.ds9a.nl> <20040326121928.GC16461@pengutronix.de>
In-Reply-To: <20040326121928.GC16461@pengutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel wrote:
> On Fri, Mar 26, 2004 at 12:59:47PM +0100, bert hubert wrote:
> 
>>>-	.bDeviceClass =		DEV_CONFIG_CLASS,
>>>+	.bDeviceClass =		0x02,
>>
>>Is this wise?
> 
> 
> Until now DEV_CONFIG_CLASS was 0xFF, which results in Windows getting
> hickup. If you directly set this to 0x02 (Network Device) Win is happy.

Actually I suspect setting it to USB_CLASS_COMM would be preferred, in
RNDIS-specific config descriptors....

- Dave


