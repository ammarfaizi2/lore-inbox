Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWBPRKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWBPRKd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 12:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWBPRKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 12:10:33 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:26484 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932096AbWBPRKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 12:10:32 -0500
Message-ID: <43F4B1C9.9070002@cfl.rr.com>
Date: Thu, 16 Feb 2006 12:09:29 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Seewer Philippe <philippe.seewer@bfh.ch>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com> <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com> <43F2E8BA.90001@bfh.ch> <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <11 <Pine.LNX.4.61.0602161125580.23082@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0602161125580.23082@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2006 17:11:28.0929 (UTC) FILETIME=[0696E110:01C6331C]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14271.000
X-TM-AS-Result: No--8.200000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> I read it, and it's wrong. You don't bother to learn. I will
> take one last hack at this and then drop it.
> 
> When a disk is first accessed, the BIOS reads the disk capacity.
> That's all. This disk capacity is in 512-byte things called "sectors".
> 

You don't bother to mention HOW it is wrong, so it appears it is you who 
fail to learn.  I will attempt once more to explain.  When you call int 
13 and ask it for C = 3, H = 4, S = 5, exactly which sector you get 
depends very much on what the bios thinks the geometry of the disk is, 
because the bios will translate 3/4/5 into a completely different value 
before sending it to the drive.  That translation is dependent entirely 
on which fake geometry the bios chooses to report the disk has.

I illustrated this translation and you simply say it is wrong.  If that 
is the case then show how.



