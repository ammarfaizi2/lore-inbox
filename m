Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVCBO4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVCBO4H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 09:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVCBO4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 09:56:07 -0500
Received: from mailhub1.nextra.sk ([195.168.1.111]:779 "EHLO
	mailhub1.nextra.sk") by vger.kernel.org with ESMTP id S262327AbVCBOz6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 09:55:58 -0500
Message-ID: <4225D4B4.6020002@rainbow-software.org>
Date: Wed, 02 Mar 2005 15:59:00 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove dead cyrix/centaur mtrr init code
References: <20050228192001.GA14221@apps.cwi.nl> <1109721162.15795.47.camel@localhost.localdomain> <20050302075037.GH20190@apps.cwi.nl>
In-Reply-To: <20050302075037.GH20190@apps.cwi.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Tue, Mar 01, 2005 at 11:52:44PM +0000, Alan Cox wrote:
> 
>>On Llu, 2005-02-28 at 19:20, Andries Brouwer wrote:
>>
>>>One such case is the mtrr code, where struct mtrr_ops has an
>>>init field pointing at __init functions. Unless I overlook
>>>something, this case may be easy to settle, since the .init
>>>field is never used.
>>
>>The failure to invoke the ->init operator appears to be the bug.
>>The centaur code definitely wants the mcr init function to be called.
> 
> 
> Yes, I expected that to be the answer. Therefore #if 0 instead of deleting.
> But if calling ->init() is needed, and it has not been done the past
> three years, the question arises whether there are any users.

I'm running 2.6.10 on Cyrix MII PR333 and it works. Maybe the code is 
broken but I haven't noticed :-)


-- 
Ondrej Zary
