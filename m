Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310302AbSCGMi2>; Thu, 7 Mar 2002 07:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310301AbSCGMiI>; Thu, 7 Mar 2002 07:38:08 -0500
Received: from [195.63.194.11] ([195.63.194.11]:63504 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310300AbSCGMiH>; Thu, 7 Mar 2002 07:38:07 -0500
Message-ID: <3C875EF5.9060609@evision-ventures.com>
Date: Thu, 07 Mar 2002 13:37:09 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Voluspa <voluspa@bigfoot.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6-pre3 Kernel panic: VFS: Unable to mount root fs on 03:02
In-Reply-To: <20020307072124.6365c8ac.voluspa@bigfoot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voluspa wrote:

> VFS: Cannot open root device "302" or 03:02
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 03:02
> 
> I don't want to polute lkml with unnecessary dumps of /proc or .config, so ask for specifics and I will comply.
>

The problem is that your are propably using a modularized ide drivers, 
loaded by default from a initial ram disk. This has to be fixed soon, 
since in fact I was too lazy to convert my system to do this.
As a temporary solution please compile the ide core driver directly into
your kernel (which is saner anyway if you are booting from this device.)

The next round of ide patches is supposed to fix this.

