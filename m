Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUCKNSs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 08:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbUCKNSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 08:18:48 -0500
Received: from zero.aec.at ([193.170.194.10]:33030 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261238AbUCKNSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 08:18:44 -0500
To: Mickael Marchand <marchand@kde.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
References: <1ysXv-wm-11@gated-at.bofh.it> <1yuG3-2XI-15@gated-at.bofh.it>
	<1yweK-4Dw-21@gated-at.bofh.it> <1yxuq-6y6-13@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 18 Mar 2004 00:25:05 +0100
In-Reply-To: <1yxuq-6y6-13@gated-at.bofh.it> (Mickael Marchand's message of
 "Thu, 11 Mar 2004 13:30:27 +0100")
Message-ID: <m3hdwnawfi.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mickael Marchand <marchand@kde.org> writes:

> [snip]
>> > while I am at it, I am running a 64 bits kernel with 32 bits debian
>> > testing and it seems some ioctl conversion fails
>> > that happened with all 2.6 I tried.
>> > here is the relevant kernel messages part :
>> > ioctl32(dmsetup:26199): Unknown cmd fd(3) cmd(c134fd00){01} arg(0804c0b0)
>> > on /dev/mapper/control
>>
>> The device mapper version 1 ioctl interface was removed.  Perhaps you need
>> to update your dm tools?
> the debian tools are built with ioctlv4 (and compat for v1)
> I also tried with my own compiled dm tools from source without success

If it just uses them for compatibility probes then the ioctl handler can 
be silenced. 

>> > ioctl32(fsck.reiserfs:201): Unknown cmd fd(4) cmd(80081272){00}
>> > arg(ffffdab8) on /dev/ide/host0/bus0/target0/lun0/part4
>>
>> Is this something which 2.6 has always done, or is it new behaviour?
> always since 2.6 IIRC
>
>> reiserfs ioctl translation appears to be incomplete...
> ha :)

I will take a look at it.

-Andi

