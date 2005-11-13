Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbVKMQhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbVKMQhf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 11:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbVKMQhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 11:37:35 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:7687 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S964931AbVKMQhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 11:37:35 -0500
In-Reply-To: <1131834336.7406.46.camel@gaston>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <200511122145.38409.mbuesch@freenet.de> <Pine.LNX.4.64.0511121257000.3263@g5.osdl.org> <200511122237.17157.mbuesch@freenet.de> <1131834336.7406.46.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <71C11A0C-4FC8-4081-A890-A4FF7DA48752@kernel.crashing.org>
Cc: Michael Buesch <mbuesch@freenet.de>,
       ppc-dev list <linuxppc-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Linuv 2.6.15-rc1
Date: Sun, 13 Nov 2005 10:37:44 -0600
To: Paul Mackerras <paulus@samba.org>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 12, 2005, at 4:25 PM, Benjamin Herrenschmidt wrote:

> On Sat, 2005-11-12 at 22:37 +0100, Michael Buesch wrote:
>> On Saturday 12 November 2005 22:00, you wrote:
>>>
>>> On Sat, 12 Nov 2005, Michael Buesch wrote:
>>>>
>>>> Latest GIT tree does not boot on my G4 PowerBook.
>>>
>>> What happens if you do
>>>
>>> 	make ARCH=powerpc
>>>
>>> and build everything that way (including the "config" phase)?
>>
>> I did
>> make mrproper
>> copy the .config over again
>> make ARCH=powerpc menuconfig
>> exit and save from menuconfig
>> make ARCH=powerpc
>
> You need to disable PREP support when building with ARCH=powerpc  
> for 32
> bits, it doesn't build (yet). We should remove it from Kconfig...
>
> Also, there is an issue with the make clean stuff, make sure when
> switching archs to also remove arch/powerpc/include/asm symlink before
> trying to build.

Can we please add some defconfigs for arch/powerpc to possibly help  
with this issue.  I'm think a pmac32, pmac64, and whatever other 64  
bit configs would be a good start.

- kumar
