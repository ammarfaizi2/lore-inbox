Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289118AbSA3Ly2>; Wed, 30 Jan 2002 06:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289119AbSA3LyS>; Wed, 30 Jan 2002 06:54:18 -0500
Received: from 217-126-161-163.uc.nombres.ttd.es ([217.126.161.163]:8599 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S289118AbSA3LyH>; Wed, 30 Jan 2002 06:54:07 -0500
To: garzik@havoc.gtf.org, raul@viadomus.com
Subject: Re: Why 'linux/fs.h' cannot be included? I *can*...
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Message-Id: <E16VtWb-0002kV-00@DervishD.viadomus.com>
Date: Wed, 30 Jan 2002 13:07:37 +0100
From: DervishD <raul@viadomus.com>
Reply-To: DervishD <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Jeff :)

>>     Given the number of user-space apps that needs ioctl definitions
>> and things like those (that are supposed not to change easily), those
>> definitions should go in user-includable headers... IMHO.
>> 
>>     Fortunately, we have some of them in libc headers now.
>The policy is, never ever include kernel headers from userspace.

    I know, but sometimes it is just impossible (when they aren't
appropriate glibc headers, for example). In fact, all this question
arose because I'm coding an 'ioctl' command line interface, so you
can send any 'documented' ioctl to any device. And, since I'm going
to start with block devices, I need linux/fs.h.

    The problem is that I don't want to copy the definitions I need
from linux/fs.h, because this will lead to problems if those
definitions change. Anyway this is not an issue, because by changing
the running kernel those definitions in fact may not be valid...

    Resuming: I don't know how properly address this problem.

>Your libc should provide a "sanitized" version of the kernel headers,
>which is completely separate from any kernel sources.

    I suppose that those headers will contain definitions not subject
to change, won't they? But I don't know if I can consider the ioctl
constants as not subject to change (they should be permanent, though).

>So, any problems should be reported to your libc maintainer :)

    Well, I try... I can even try to make the sanitized header myself
and pray for it to be included in next glibc revision :)

    Thanks :)
    Raúl
