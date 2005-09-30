Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbVI3PuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbVI3PuU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbVI3PuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:50:20 -0400
Received: from [65.195.187.51] ([65.195.187.51]:50370 "EHLO candi.us")
	by vger.kernel.org with ESMTP id S1030344AbVI3PuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:50:19 -0400
Message-ID: <433D5E9C.2030708@lorez.org>
Date: Fri, 30 Sep 2005 08:49:48 -0700
From: Bob Richmond <bob@lorez.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-stuff@comcast.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Immediate general protection errors on Tyan board
References: <431BE71F.2040901@lorez.org> <431BE9CE.8080302@comcast.net>
In-Reply-To: <431BE9CE.8080302@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got it working over the weekend. The machine had an Adaptec 29320 
64-bit PCI card driving a SCSI HD. It was removed, and the drive 
replaced with a Serial ATA drive, and it came up fine.

There were probably a lot of variables that were changed by removing the 
card, but I'm wondering if anyone has experienced the same symptoms with 
any 64-bit PCI card installed on this board.

Parag Warudkar wrote:

> Bob Richmond wrote:
> 
>> Immediately upon boot on this system, most userland programs will 
>> segfault, including mount. This causes the system to come up in a 
>> bizarre state with the root filesystem mounted read-only, and nothing 
>> runs without segfault. There have been numerous similar posts about 
>> this problem, but they also seem to point to an associated kernel 
>> message, "Bad page state" that I don't observe. dmesg (which runs 
>> without segfault) returns many similar messages to:
>>
>> start_udev[576] general protection rip:2aaaaae0fc70 rsp:7fffffb23d90 
>> error:0
> 
> 
> echo 0 > /proc/sys/kernel/randomize_va_space - Seems to fix it for most 
> people.
> 
> See http://bugzilla.kernel.org/show_bug.cgi?id=4851 for more details.
> 
> Parag
