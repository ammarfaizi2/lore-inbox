Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291088AbSCOLId>; Fri, 15 Mar 2002 06:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSCOLGk>; Fri, 15 Mar 2002 06:06:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6923 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290120AbSCOLFk>;
	Fri, 15 Mar 2002 06:05:40 -0500
Message-ID: <3C91D571.5070806@mandrakesoft.com>
Date: Fri, 15 Mar 2002 06:05:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Olivier Galibert <galibert@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203111829550.1153-100000@home.transmeta.com> <3C8D69E3.3080908@mandrakesoft.com> <20020311223439.A2434@zalem.nrockv01.md.comcast.net> <3C8D8061.4030503@mandrakesoft.com> <20020314141342.B37@toy.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi
>
>>Under more restricted domains, root cannot bit-bang the interface. 
>> s/CAP_SYS_RAWIO/CAP_DEVICE_CMD/ for the raw cmd ioctl interface.  Have 
>>
>
>Nobody uses capabilities these days, right?
>

Actually, the NSA and HP secure linux products do, at the very least. 
 And there is some ELF capabilities project out there IIRC, but I dunno 
if anybody's using it.

>>The filter is useful for other reasons like correctness, as well.
>>
>
>If you want to test if it works, you just disallow that access altogether.
>It is usually not needed , anyway.
>

The filter, or directly sending drive commands to userspace?

I agree the filter is of limited usefulness.

Sending drive commands directly from userspace is definitely -very- 
useful.  As we start doing more and more stuff in userspace, I predict 
this facility will be used more and more.  Plus, IBM particularly 
already has their Drive Fitness Tests, or whatever, sending direct drive 
commands.  With the proper sequencing, you can even do power management 
of the drives in userspace.  You don't want to do system suspend/resume 
that way, but you can certainly have a userspace policy daemon running, 
that powers-down and powers-up the drives, etc.

    Jeff





