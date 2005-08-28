Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVH1C7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVH1C7V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 22:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVH1C7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 22:59:21 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:19682 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751095AbVH1C7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 22:59:21 -0400
Date: Sun, 28 Aug 2005 04:59:21 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
In-Reply-To: <20050827124148.GE1109@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.62.0508280453320.13233@artax.karlin.mff.cuni.cz>
References: <1125069494.18155.27.camel@betsy> <20050827124148.GE1109@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi!
>
>> Of late I have been working on a driver for the IBM Hard Drive Active
>> Protection System (HDAPS), which provides a two-axis accelerometer and
>> some other misc. data.  The hardware is found on recent IBM ThinkPad
>> laptops.
>>
>> The following patch adds the driver to 2.6.13-rc6-mm2.  It is
>> self-contained and fairly simple.
>
> Do we really need input interface *and* sysfs interface? Input should be 
> enough.

Hi!

I think he doesn't need to export it at all and he should write code to 
park and disable hard disk instead.
(in userspace it's unsolvable --- i.e. you can't enable hard disk when 
detected stable condition if the daemon is swapped out on that hard disk)

Mikulas
