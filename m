Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287276AbSBCOYo>; Sun, 3 Feb 2002 09:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287254AbSBCOYe>; Sun, 3 Feb 2002 09:24:34 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:63976 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S287279AbSBCOYY>; Sun, 3 Feb 2002 09:24:24 -0500
Date: Sun, 3 Feb 2002 15:23:18 +0100
From: "W. Michael Petullo" <mike@flyn.org>
To: linux-kernel@vger.kernel.org
Cc: sfr@canb.auug.org.au
Subject: Re: SMP Pentium III, GA-6VXDC7 MoBo. -- 2.4.18-pre7 SMP not working
Message-ID: <20020203152318.A3359@dragon.flyn.org>
In-Reply-To: <20020127172150.A1407@dragon.flyn.org> <20020202151241.A1417@dragon.flyn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020202151241.A1417@dragon.flyn.org>; from mike@dragon.flyn.org on Sat, Feb 02, 2002 at 03:12:41PM +0100
X-Operating-System: Linux dragon.flyn.org 2.4.17-xfs 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I have a home-built dual Pentium III computer which does not seem to
>> want to run recent SMP kernels.  The computer is built on a Gigabyte
>> GA-6VXDC7 motherboard, which is in turn based on a VIA Apollo Pro chip-set.
>> It is an exclusively SCSI system -- I do not compile any IDE drivers
>> into my kernel.
>>
>> Kernel 2.4.12 works fine when compiled with SMP on.  However, anything
>> newer fails to load when compiled with SMP support.  In the failing cases,
>> lilo prints its uncompressing kernel and booting kernel messages followed
>> by a system hang -- the kernel never prints anything.
>>
>> Kernel.org
>> Vanilla              CONFIG_SMP=y            # CONFIG_SMP is not set
>> Version              SMP Status              UP Status
>> ======================================================
>> 2.4.10               SMP works               Fine
>> 2.4.11               Wouldn't touch          Wouldn't touch
>> 2.4.12               SMP Works               Fine
>> 2.4.13               SMP does not boot       Fine
>> 2.4.14               Did not try             Did not try
>> 2.4.15               Did not try             Did not try
>> 2.4.16               SMP does not boot       Fine
>> 2.4.17               SMP does not boot       Fine
>> 2.4.18-pre7          SMP does not boot       Fine
>> 
>> Since the kernel does not even peep an oops message, I'm not sure where
>> to start debugging.  Is anyone else having similar problems?

> I'm having a lot of trouble debugging this one.
> [...]

Apparently there is some type of conflict introduced in 2.4.13's APM code.
I finally got 2.4.17 to boot with SMP enabled after I disabled APM.
Though APM is not SMP safe, I have been using successfully it for its
power-off feature.

I will look closer at the 2.4.13 APM changes to try and determine what
broke my SMP.

--
Mike

:wq

