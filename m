Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVHATrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVHATrs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 15:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVHATrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 15:47:47 -0400
Received: from pythagoras.zen.co.uk ([212.23.3.140]:42458 "EHLO
	pythagoras.zen.co.uk") by vger.kernel.org with ESMTP
	id S261195AbVHATqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 15:46:07 -0400
Message-ID: <42EE7B9F.6030709@dresco.co.uk>
Date: Mon, 01 Aug 2005 20:44:31 +0100
From: Jon Escombe <lists@dresco.co.uk>
Reply-To: lists@dresco.co.uk
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: abonilla@linuxwireless.org
CC: linux-kernel@vger.kernel.org,
       "'hdaps devel'" <hdaps-devel@lists.sourceforge.net>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       "'Dave Hansen'" <dave@sr71.net>
Subject: Re: [Hdaps-devel] Re: IBM HDAPS, I need a tip.
References: <003801c596c6$574e08b0$a20cc60a@amer.sykes.com>
In-Reply-To: <003801c596c6$574e08b0$a20cc60a@amer.sykes.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Hops: 1
X-Originating-Pythagoras-IP: [82.68.23.174]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> hard drive parking was already sorted out. We have a script that does this
> and works great parking the heads.

Would have to disagree with you here. Jens' ATA7 parking code is a great 
start but we still have a couple of issues to address before it's usable 
for this purpose. (1) it only works on a subset of the devices that the 
Windows driver works for, and (2) we need a way to freeze the device for 
a short period so that the next I/O request doesn't wake it up before it 
hits the floor...

> The problem here is that we have 10 different models.
> 
> One will have 20 as X and the others will have 500 as x. Some will increment
> in 20 when you move them 45Deg, and some will increment 50.
> 
> How can you determine from an shake, to a fall?

If there really are devices with resting values of 20 then I would agree 
we have a problem. I've tried on a few different Thinkpads and have 
always seen resting values of several hundreds. If this is true for all, 
I would like to think we could estimate a sensible value that works for 
everyone...

Regards,
Jon.

______________________________________________________________
Email via Mailtraq4Free from Enstar (www.mailtraqdirect.co.uk)
