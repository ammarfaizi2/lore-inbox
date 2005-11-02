Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbVKBALW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbVKBALW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbVKBALW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:11:22 -0500
Received: from mail.avalus.com ([195.82.114.197]:64708 "EHLO shed.alex.org.uk")
	by vger.kernel.org with ESMTP id S1751448AbVKBALV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:11:21 -0500
Date: Wed, 02 Nov 2005 00:11:10 +0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Florian Weimer <fw@deneb.enyo.de>,
       Lawrence Walton <lawrence@the-penguin.otak.com>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 3ware 9550SX problems - mke2fs incredibly slow writing last
 third of inode tables
Message-ID: <B4CA35A2CFBAF97FCE2856B0@[192.168.100.25]>
In-Reply-To: <87wtjs8f54.fsf@mid.deneb.enyo.de>
References: <BEDEA151E8B1D6CEDD295442@[192.168.100.25]>
 	<87oe54cza8.fsf@mid.deneb.enyo.de>
 	<20051101170413.GA11640@the-penguin.otak.com>
 <87wtjs8f54.fsf@mid.deneb.enyo.de>
X-Mailer: Mulberry/4.0.4 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On 01 November 2005 18:13 +0100 Florian Weimer <fw@deneb.enyo.de> wrote:

>>> In my experience, the 3ware SATA controllers which are not NCQ-capable
>>> have very, very lousy write performance with some drives, unless you
>>> enable the write cache (which is, of course, a bit dangerous without
>>> UPS or battery backup on the controller).
>
>> Not to sound like the a 3ware chearleader, but this card does support
>> NCQ.
>
> Oh.  I didn't know whether this particukar controller supported NCQ or
> not.

It even supports SATA-3, not much good that it does me.

I managed to format it reiserfs in the end. dbench (yes I know it isn't a
great benchmark) gives me a write speed of 7Mb/s compared to 700Mb/s if one
of the disks in the array is attached to the motherboard SATA controller.

7Mb/s is quite stunningly appalling. I realise the release notes warn of
slow writes, but that's just daft! I have a few bits in my setup to check
before I start pointing the finger comprehensively. It may (for instance)
be a large partition problem (suggested on the ext2 list).

I'm taking it that it works at least for some people (did you test write
speed Lawrence?).

--
Alex Bligh
