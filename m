Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274859AbTHPQBo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 12:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274863AbTHPQBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 12:01:44 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:63922 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S274859AbTHPQBm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 12:01:42 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: increased verbosity in dmesg
Date: Sat, 16 Aug 2003 12:01:34 -0400
User-Agent: KMail/1.5.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200308160438.59489.gene.heskett@verizon.net> <200308161136.01133.gene.heskett@verizon.net> <1061048708.624.0.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1061048708.624.0.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308161201.34125.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.12.137] at Sat, 16 Aug 2003 11:01:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 August 2003 11:45, Felipe Alfaro Solana wrote:
>On Sat, 2003-08-16 at 17:36, Gene Heskett wrote:
>> >In 2.6.0-test, the ring bugger size is configurable. Just look
>> > for CONFIG_LOG_BUF_SHIFT. The kernel ring size will be
>> >2^CONFIG_LOG_BUF_SHIFT bytes, so for a CONFIG_LOG_BUF_SHIFT of
>> > 14, you'll 2^14 or 16 KBytes.
>>
>> Which says that a setting of 15 would get 32k then.
>> I take it this (for an i386 system) is the correct file to edit?
>
>Yes, a value of 15 means 32KB. However, I don't recommend you
> setting this value too high.
>
>> kernel/ikconfig.h:CONFIG_LOG_BUF_SHIFT=14 \n\
>> Mmmm, that says do not edit, auto-generated, so how about this
>> one?
>>
>> include/config/log/buf/shift.h
>>
>> which contains only that single line.  Its now 15 & we'll see.
>
>No, no, you'll need to edit the ".config" file to reflect the
> changes.

I don't recall .config falling out of a grep for that.  I also asked 
less to search for it in .config without finding it.  This was in 
2.6.0-test3-mm2's src dir.

I reran a make menuconfig and saved, and a trial make is underway now.

Damn, grep must not look at .files, its there, and still 14.  Thanks a 
bunch, new build underway.

However, I'd assume a make mrproper, or an oldconfig might reset that 
to the include/config/log/buf/shift.h value?  Its also in 
autoconfig.h FWTW.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

