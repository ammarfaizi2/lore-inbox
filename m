Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVAPWfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVAPWfR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 17:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVAPWfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 17:35:17 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:56220 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S262638AbVAPWda
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 17:33:30 -0500
Message-ID: <41EAEBB8.6040900@cwazy.co.uk>
Date: Sun, 16 Jan 2005 17:33:28 -0500
From: Jim Nelson <james4765@cwazy.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitors@lists.osdl.org
Subject: Re: [PATCH 0/13] remove cli()/sti() in drivers/char/*
References: <20050116135223.30109.26479.55757@localhost.localdomain>	 <20050116130452.10fabe52.akpm@osdl.org> <1105908079.12201.6.camel@localhost.localdomain>
In-Reply-To: <1105908079.12201.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [70.16.225.90] at Sun, 16 Jan 2005 16:33:29 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sul, 2005-01-16 at 21:04, Andrew Morton wrote:
> 
>>James Nelson <james4765@cwazy.co.uk> wrote:
>>
>>>This series of patches removes the last cli()/sti()/save_flags()/restore_flags()
>>> function calls in drivers/char.
>>
>>I don't see much point in this, really.  Those cli() calls are a big fat
>>sign saying "broken on smp" and they now generate compile-time warnings
>>emphasising that.  These drivers still need to be fixed up - we may las
>>well leave them as-is until someone gets onto doing that.
> 
> 
> Please drop all the serial ones. I'm slowly working through the serial
> drivers that are relevant to any kind of users and fixing them up or
> importing fixes from vendor branches as appropriate.
> 
> Simple substitions don't work here, and in some cases even simple tty
> device locks because many cards are chip level interfaces not port
> level.
> 
> Alan
> 
>

Right.  Please disregard this set of patches - I think I'm done flogging this 
directory for awhile :)
