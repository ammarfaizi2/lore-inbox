Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317176AbSGXNP6>; Wed, 24 Jul 2002 09:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317180AbSGXNP6>; Wed, 24 Jul 2002 09:15:58 -0400
Received: from [195.63.194.11] ([195.63.194.11]:59149 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317176AbSGXNP5>; Wed, 24 Jul 2002 09:15:57 -0400
Message-ID: <3D3EA801.5090608@evision.ag>
Date: Wed, 24 Jul 2002 15:13:37 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] irqlock patch 2.5.27-H4
References: <Pine.SOL.4.30.0207241505430.15605-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Wed, 24 Jul 2002, Ingo Molnar wrote:
> 
> 
>>the latest irqlock patch can be found at:
>>
>>   http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-H4
>>
>>Changes in -H4:
>>
>> - fix the cli()/sti() hack in ide/main.c, per Marcin Dalecki's
>>   suggestion. [this leaves the tty layer as the only remaining subsystem
>>   that still has cli()/sti() related hacks.]
> 
> 
> Hi Ingo,
> 
> Marcin's suggestions will bring you nowhere.
> 
> You should remove all these locking from ide_unregister_subdriver()
> because in 100% cases it is already called with ide_lock held.

Indeed they can be just removed.

