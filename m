Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbVLNUtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbVLNUtS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 15:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbVLNUtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 15:49:18 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:21265 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S964955AbVLNUtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 15:49:17 -0500
Message-ID: <43A08546.8040708@superbug.co.uk>
Date: Wed, 14 Dec 2005 20:49:10 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Sridhar Samudrala <sri@us.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
References: <Pine.LNX.4.58.0512140042280.31720@w-sridhar.beaverton.ibm.com> <9a8748490512141216x7e25ca2cucb675f11f0c9d913@mail.gmail.com>
In-Reply-To: <9a8748490512141216x7e25ca2cucb675f11f0c9d913@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 12/14/05, Sridhar Samudrala <sri@us.ibm.com> wrote:
> 
>>These set of patches provide a TCP/IP emergency communication mechanism that
>>could be used to guarantee high priority communications over a critical socket
>>to succeed even under very low memory conditions that last for a couple of
>>minutes. It uses the critical page pool facility provided by Matt's patches
>>that he posted recently on lkml.
>>        http://lkml.org/lkml/2005/12/14/34/index.html
>>
>>This mechanism provides a new socket option SO_CRITICAL that can be used to
>>mark a socket as critical. A critical connection used for emergency
> 
> 
> So now everyone writing commercial apps for Linux are going to set
> SO_CRITICAL on sockets in their apps so their apps can "survive better
> under pressure than the competitors aps" and clueless programmers all
> over are going to think "cool, with this I can make my app more
> important than everyone elses, I'm going to use this".  When everyone
> and his dog starts to set this, what's the point?
> 
> 

I don't think the initial patches that Matt did were intended for what 
you are describing.
When I had the conversation with Matt at KS, the problem we were trying 
to solve was "Memory pressure with network attached swap space".
I came up with the idea that I think Matt has implemented.
Letting the OS choose which are "critical" TCP/IP sessions is fine. But 
letting an application choose is a recipe for disaster.

James
