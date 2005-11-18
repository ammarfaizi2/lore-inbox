Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVKRQNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVKRQNI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 11:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVKRQNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 11:13:08 -0500
Received: from mail.dvmed.net ([216.237.124.58]:5318 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932319AbVKRQNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 11:13:06 -0500
Message-ID: <437DFD6C.1020106@pobox.com>
Date: Fri, 18 Nov 2005 11:12:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Adrian Bunk <bunk@stusta.de>, saw@saw.sw.com.sg,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
References: <20051118033302.GO11494@stusta.de> <20051118090158.GA11621@flint.arm.linux.org.uk>
In-Reply-To: <20051118090158.GA11621@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Nov 18, 2005 at 04:33:02AM +0100, Adrian Bunk wrote:
> 
>>This patch removes the obsolete drivers/net/eepro100.c driver.
>>
>>Is there any reason why it should be kept?
> 
> 
> Tt's the only driver which works correctly on ARM CPUs.  e100 is
> basically buggy.  This has been discussed here on lkml and more
> recently on linux-netdev.  If anyone has any further questions
> please read the archives of those two lists.

After reading the archives, one discovers the current status is:

	waiting on ARM folks to test e100

Latest reference is public message-id <4371A373.6000308@pobox.com>, 
which was CC'd to you.

There is a patch in netdev-2.6.git#e100-sbit and in Andrew's -mm tree 
that should solve the ARM problems, and finally allow us to kill 
eepro100.  But it's waiting for feedback...

	Jeff


